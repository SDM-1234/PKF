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

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnSetUpNewLineOnBeforeSetBalAccount, '', false, false)]
    local procedure "Gen. Journal Line_OnSetUpNewLineOnBeforeSetBalAccount"(var GenJournalLine: Record "Gen. Journal Line"; LastGenJournalLine: Record "Gen. Journal Line"; var Balance: Decimal; var IsHandled: Boolean; GenJnlTemplate: Record "Gen. Journal Template"; GenJnlBatch: Record "Gen. Journal Batch"; BottomLine: Boolean; var Rec: Record "Gen. Journal Line"; CurrentFieldNo: Integer)
    begin
        case GenJnlTemplate.Type of
            GenJnlTemplate.Type::Payments:
                begin
                    Rec."Account Type" := LastGenJournalLine."Account Type";
                    Rec."Document Type" := LastGenJournalLine."Document Type";
                end;
        end;
    end;

}