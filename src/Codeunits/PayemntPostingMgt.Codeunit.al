codeunit 50007 "Payemnt Posting Mgt"
{
    trigger OnRun()
    begin

    end;

    procedure ProcessData()
    var
        PaymentPostBuffer: Record "Payment Posting Buffer";
        SalesInv: Record "Sales Invoice Header";
        CustLedEntry: Record "Cust. Ledger Entry";
        BankAcc: Record "Bank Account";
    begin
        TestSetups();
        if PaymentPostBuffer.FindSet() then
            repeat
                PaymentPostBuffer."Error Description" := '';
                if SalesInv.get(PaymentPostBuffer.Reference) then begin
                    PaymentPostBuffer."Invoice Type" := format(SalesInv."Invoice Types");
                    PaymentPostBuffer."Salesperson Code" := SalesInv."Salesperson Code";
                    PaymentPostBuffer."Customer ID" := SalesInv."Bill-to Customer No.";
                    PaymentPostBuffer."Branch Code" := SalesInv."Shortcut Dimension 2 Code";
                end else
                    PaymentPostBuffer."Error Description" := 'Invoice not found';
                CustLedEntry.SetRange("Customer No.", PaymentPostBuffer."Customer ID");
                CustLedEntry.SetRange("Document Type", CustLedEntry."Document Type"::Invoice);
                CustLedEntry.SetRange("Document No.", PaymentPostBuffer.Reference);
                CustLedEntry.SetRange(Open, true);
                if CustLedEntry.FindFirst() then begin
                    CustLedEntry.CalcFields("Remaining Amount");
                    PaymentPostBuffer."Remaining amount" := CustLedEntry."Remaining Amount" - (PaymentPostBuffer.Total + PaymentPostBuffer.TDS);
                end else
                    PaymentPostBuffer."Error Description" := 'Invoice not Open';
                BankAcc.SetRange(Loc, PaymentPostBuffer.Loc);
                if BankAcc.isempty() then
                    PaymentPostBuffer."Error Description" := StrSubstNo('Bank account not found for LOC %1', PaymentPostBuffer.Loc);
                PaymentPostBuffer."Error" := PaymentPostBuffer."Error Description" <> '';
                PaymentPostBuffer.Modify();
            until PaymentPostBuffer.Next() = 0;
    end;

    procedure CreateJournalLine()
    var
        PaymentPostBuffer, PaymentPostBuffer1 : Record "Payment Posting Buffer";
        BankAcc: Record "Bank Account";
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesBatch: Codeunit "No. Series - Batch";
        AccType: Enum "Gen. Journal Account Type";
        LastSlNo: Integer;
        BankAmount: Decimal;
        DocumentNo: Code[20];
        Narrarion: Text[2048];
    begin
        TestSetups();
        ClearJnlBatch();
        GenJnlBatch.Get(GlSetup."Payment Posting Template", GlSetup."Payment Posting Batch");
        DocumentNo := NoSeriesBatch.GetLastNoUsed(GenJnlBatch."No. Series");
        PaymentPostBuffer.SetRange(Error, true);
        if not PaymentPostBuffer.IsEmpty() then
            Error('Clear all error before creating journal lines');
        Clear(PaymentPostBuffer);
        PaymentPostBuffer.Reset();
        PaymentPostBuffer.SetCurrentKey("Serial No.");
        if PaymentPostBuffer.FindSet() then
            repeat
                if LastSlNo <> PaymentPostBuffer."Serial No." then begin
                    if PaymentPostBuffer1.Loc <> '' then begin
                        PaymentPostBuffer1.Remarks := Narrarion;
                        BankAcc.SetRange(Loc, PaymentPostBuffer1.Loc);
                        if BankAcc.FindFirst() then
                            CreateJournal(PaymentPostBuffer1, AccType::"Bank Account", BankAcc."No.", BankAmount, DocumentNo)
                        else
                            Error('Bank account not found for LOC %1', PaymentPostBuffer1.Loc);
                        BankAmount := 0;
                        Narrarion := '';
                    end;
                    DocumentNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", PaymentPostBuffer.Date, DocumentNo);
                end;
                if Narrarion <> '' then
                    Narrarion := Narrarion + ', ' + PaymentPostBuffer.Reference
                else
                    Narrarion := PaymentPostBuffer.Remarks;
                LastSlNo := PaymentPostBuffer."Serial No.";
                PaymentPostBuffer1 := PaymentPostBuffer;
                if (GlSetup."Round off Variance" <> 0) and (GlSetup."Round off Variance" >= abs(PaymentPostBuffer."Remaining amount")) then begin
                    CreateJournal(PaymentPostBuffer, AccType::Customer, PaymentPostBuffer."Customer ID", -(PaymentPostBuffer.Total + PaymentPostBuffer.TDS + PaymentPostBuffer."Remaining amount"), DocumentNo);
                    CreateJournal(PaymentPostBuffer, AccType::"G/L Account", GlSetup."Round Off Account", PaymentPostBuffer."Remaining amount", DocumentNo);
                end else
                    CreateJournal(PaymentPostBuffer, AccType::Customer, PaymentPostBuffer."Customer ID", -(PaymentPostBuffer.Total + PaymentPostBuffer.TDS), DocumentNo);
                CreateJournal(PaymentPostBuffer, AccType::"G/L Account", GlSetup."Payment Posting TDS Acc", PaymentPostBuffer.TDS, DocumentNo);


                BankAmount += PaymentPostBuffer.Total;
            until PaymentPostBuffer.Next() = 0;
        if PaymentPostBuffer1.Loc <> '' then begin
            PaymentPostBuffer1.Remarks := Narrarion;
            BankAcc.SetRange(Loc, PaymentPostBuffer1.Loc);
            if BankAcc.FindFirst() then
                CreateJournal(PaymentPostBuffer1, AccType::"Bank Account", BankAcc."No.", BankAmount, DocumentNo)
            else
                Error('Bank account not found for LOC %1', PaymentPostBuffer1.Loc);
        end;
        Clear(PaymentPostBuffer);
        PaymentPostBuffer.Reset();
        PaymentPostBuffer.DeleteAll();

        if GlSetup."Payment Posting Type" = GlSetup."Payment Posting Type"::"Create & Post Journal" then
            PostJournal();

    end;

    local procedure CreateJournal(PaymentPostBuffer: Record "Payment Posting Buffer"; AccType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; Amount: Decimal; DocumentNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        Dim7Code: Code[20];
    begin
        if Amount = 0 then
            exit;
        LineNo += 10000;
        GenJnlLine.InitNewLine(PaymentPostBuffer.Date, PaymentPostBuffer.Date, 0D, '', '', '', 0, '');
        GenJnlLine."Journal Template Name" := GlSetup."Payment Posting Template";
        GenJnlLine."Journal Batch Name" := GlSetup."Payment Posting Batch";
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine.Validate("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.Validate("Account Type", AccType);
        GenJnlLine.Validate("Account No.", AccNo);
        GenJnlLine.Validate("Amount", Amount);
        GenJnlLine.Narration := CopyStr(PaymentPostBuffer.Remarks, 1, 200);
        if AccType = AccType::Customer then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := CopyStr(PaymentPostBuffer.Reference, 1, 20);
        end;
        GenJnlLine."Cheque Date" := PaymentPostBuffer.Date;
        GenJnlLine."External Document No." := PaymentPostBuffer."Check No.";
        GenJnlLine.Validate("Gen. Prod. Posting Group", '');
        GenJnlLine.Validate("Salespers./Purch. Code", PaymentPostBuffer."Salesperson Code");
        GenJnlLine.Validate("Shortcut Dimension 2 Code", PaymentPostBuffer."Branch Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentPostBuffer."Customer ID");
        Dim7Code := 'BANK';
        GenJnlLine.ValidateShortcutDimCode(7, Dim7Code);
        GenJnlLine.ValidateShortcutDimCode(8, PaymentPostBuffer."Invoice Type");
        GenJnlLine.Insert(true);
    end;

    local procedure ClearJnlBatch()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.SetRange("Journal Template Name", GlSetup."Payment Posting Template");
        GenJnlLine.SetRange("Journal Batch Name", GlSetup."Payment Posting Batch");
        GenJnlLine.DeleteAll(true);
    end;

    local procedure PostJournal()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        PostBatch: Codeunit "Gen. Jnl.-B.Post";
    begin
        Commit();
        GenJnlBatch.SetRange("Journal Template Name", GlSetup."Payment Posting Template");
        GenJnlBatch.SetRange(Name, GlSetup."Payment Posting Batch");
        if GenJnlBatch.FindFirst() then
            PostBatch.Run(GenJnlBatch);
    end;

    local procedure TestSetups()
    begin
        GlSetup.Get();
        GlSetup.TestField("Payment Posting Template");
        GlSetup.TestField("Payment Posting Batch");
        GlSetup.TestField("Payment Posting TDS Acc");
        if GlSetup."Round off Variance" <> 0 then
            GlSetup.TestField("Round Off Account");
    end;

    var
        GlSetup: Record "General Ledger Setup";
        LineNo: Integer;
}