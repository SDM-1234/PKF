
pageextension 50008 BankAccountLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee Name field.', Comment = '%';
            }
        }
    }
}
