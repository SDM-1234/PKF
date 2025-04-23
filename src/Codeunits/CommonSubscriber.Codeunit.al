/// <summary>
/// Codeunit Common Subscriber-Sales (ID 50100).
/// </summary>
codeunit 50100 "Common Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Customer: Record Customer;
    begin
        If Customer.Get(CustLedgerEntry."Customer No.") then;
        CustLedgerEntry.Narration := GenJournalLine.Narration;
        CustLedgerEntry."Customer Name" := Customer.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure "Vendor Ledger Entry_OnAfterCopyVendLedgerEntryFromGenJnlLine"(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry.Narration := GenJournalLine.Narration;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterCheckMandatoryFields, '', false, false)]
    local procedure "Sales-Post_OnAfterCheckMandatoryFields"(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesHeader.TESTFIELD("Salesperson Code");
        SalesHeader.TESTFIELD("Sell-to Post Code");
        SalesHeader.TESTFIELD("Sell-to City");
        if SalesHeader."Customer Posting Group" = 'FOREIGN' then begin
            SalesHeader.TESTFIELD("Invoice Type", SalesHeader."Invoice Type"::Export);
            SalesHeader.TESTFIELD("GST Without Payment of Duty", TRUE);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry.Narration := GenJournalLine.Narration;
        GLEntry."Payee Name" := GenJournalLine."Payee Name";
        GLEntry."Beneficiary Code" := GenJournalLine."Beneficiary Code";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseOnBeforeStartPosting, '', false, False)]
    local procedure PKF_OnRunOnAfterConfirmRevereseEntry(var ReversalEntry: Record "Reversal Entry"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        InputDate: Date;
        IsConfirmed: Boolean;
    begin
        // Prompt the user for a date using a temporary page
        IsConfirmed := GetInputDate(InputDate);

        if IsConfirmed then begin
            ReversalEntry."Posting Date" := InputDate;
            GenJournalLine."Posting Date" := InputDate;
            GlEntry."Posting Date" := InputDate;
        end else
            Error('Posting canceled by the user.');
    end;

    // Helper procedure to open a temporary page for date input
    local procedure GetInputDate(var InputDate: Date): Boolean
    var
        InputPage: Page "Date Input Page";
        TempInputRecord: Record "Input Temp Table"; // Temporary table to store the date
        Confirmed: Boolean;
    begin
        // Initialize the temporary record
        TempInputRecord.Init();
        TempInputRecord."Input Date" := InputDate;
        TempInputRecord.Insert(true);

        // Set the temporary record as the source table for the page
        InputPage.SetTableView(TempInputRecord);

        // Open the page (non-modal)
        InputPage.Run();
        InputPage.close();
        // Retrieve the input date after the page is closed
        if TempInputRecord.FindFirst() then begin
            InputDate := TempInputRecord."Input Date";
            Confirmed := true;
        end else
            Confirmed := false;

        exit(Confirmed);
    end;


    [EventSubscriber(ObjectType::Report, Report::"Batch Post Sales Invoices", OnBeforeSalesHeaderPreDataItem, '', false, false)]
    local procedure "Batch Post Sales Invoices_OnBeforeSalesHeaderPreDataItem"(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."GST Customer Type" IN [SalesHeader."GST Customer Type"::Registered, SalesHeader."GST Customer Type"::Unregistered, SalesHeader."GST Customer Type"::" "] then
            CalculateGSTAmount(SalesHeader);

    end;

    local procedure CalculateGSTAmount(var Rec: Record "Sales Header")
    var
        SalesLine1: Record "Sales Line";
        TaxTrnasactionValue1: Record "Tax Transaction Value";
        TaxTrnasactionValue: Record "Tax Transaction Value";
        GSTCompAmount: array[10] of Decimal;
        GSTCompNo: Integer;
        GSTComponentCode: array[10] of Integer;
        GSTAmountByLineNo: Decimal;
    begin
        SalesLine1.SetCurrentKey("Document No.", "Document Type", "Line No.");
        SalesLine1.SetRange("Document No.", Rec."No.");
        SalesLine1.SetRange("Document Type", Rec."Document Type");
        SalesLine1.SetRange(Type, SalesLine1.Type::"G/L Account");
        if SalesLine1.FindSet() then
            repeat
                GSTAmountByLineNo := 0;
                GSTCompNo := 1;
                TaxTrnasactionValue.Reset();
                TaxTrnasactionValue.SetRange("Tax Record ID", SalesLine1.RecordId);
                TaxTrnasactionValue.SetRange("Tax Type", 'GST');
                TaxTrnasactionValue.SetRange("Value Type", TaxTrnasactionValue."Value Type"::COMPONENT);
                TaxTrnasactionValue.SetFilter(Percent, '<>%1', 0);
                if TaxTrnasactionValue.FindSet() then
                    repeat
                        GSTCompNo := TaxTrnasactionValue."Value ID";
                        GSTComponentCode[GSTCompNo] := TaxTrnasactionValue."Value ID";
                        TaxTrnasactionValue1.Reset();
                        TaxTrnasactionValue1.SetRange("Tax Record ID", SalesLine1.RecordId);
                        TaxTrnasactionValue1.SetRange("Tax Type", 'GST');
                        TaxTrnasactionValue1.SetRange("Value Type", TaxTrnasactionValue1."Value Type"::COMPONENT);
                        TaxTrnasactionValue1.SetRange("Value ID", GSTComponentCode[GSTCompNo]);
                        if TaxTrnasactionValue1.FindSet() then begin
                            repeat
                                GSTCompAmount[GSTCompNo] += TaxTrnasactionValue1."Amount";
                                GSTAmountByLineNo += TaxTrnasactionValue1.Amount;
                            until TaxTrnasactionValue1.Next() = 0;
                            GSTCompNo += 1;
                        end;
                    until TaxTrnasactionValue.Next() = 0;
                if GSTAmountByLineNo = 0 then
                    Error('GST Amount is not calculated for this line %1. Please check the GST Calculation', SalesLine1."Line No.");
            until SalesLine1.Next() = 0;
    end;

}