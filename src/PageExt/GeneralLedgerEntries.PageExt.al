
pageextension 50009 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Dimension Set ID")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Beneficiary Name field.', Comment = '%';
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee Name field.', Comment = '%';
            }
        }
    }
}
