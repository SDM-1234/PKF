
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

    actions
    {
        addafter("Print Voucher")
        {
            action(PrintRTGSReport)
            {
                ApplicationArea = All;
                Caption = 'Print Posted RTGS Report';
                Image = Report;
                ToolTip = 'Click to Print Posted RTGS form';

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50021, TRUE, FALSE, GLEntry);
                end;
            }
        }
    }
}

