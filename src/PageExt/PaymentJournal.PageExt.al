
pageextension 50007 PaymentJournal extends "Payment Journal"

{

    layout
    {
        modify(BalAccName)
        {
            Visible = true;
        }
        addafter("Account No.")
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
    actions
    {
        addafter(SuggestVendorPayments)
        {
            action(PrintRTGSReport)
            {
                Image = BankAccountStatement;
                Caption = 'Print RTGS Report';
                ApplicationArea = All;
                ToolTip = 'Click to Print RTGS form';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50020, TRUE, FALSE, GenJournalLine);
                end;
            }
        }
    }
}
