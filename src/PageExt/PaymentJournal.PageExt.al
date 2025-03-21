
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
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Code"; Rec."Beneficiary Code")
            {
                ApplicationArea = All;
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SuggestVendorPayments)
        {
            action(PrintRTGSReport)
            {
                ApplicationArea = All;
                Caption = 'Print RTGS Report';
                Image = BankAccountStatement;
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
