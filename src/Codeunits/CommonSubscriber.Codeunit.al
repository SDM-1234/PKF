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
}