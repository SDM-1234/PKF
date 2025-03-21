
pageextension 50008 BankAccountLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
