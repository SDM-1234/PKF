/// <summary>
/// Codeunit Common Subscriber-Sales (ID 50100).
/// </summary>
codeunit 50100 "Common Subscriber-Sales"
{
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.Narration := GenJournalLine.Narration;
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
}