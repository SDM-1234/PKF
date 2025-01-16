namespace PKF.PKF;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50007 PaymentJournal extends "Payment Journal"
{
    layout
    {
        addafter("Bal. Account Name")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
            }
            field("Beneficiary Code"; Rec."Beneficiary Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Beneficiary Code field.', Comment = '%';
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee Name field.', Comment = '%';
            }
        }
    }
}
