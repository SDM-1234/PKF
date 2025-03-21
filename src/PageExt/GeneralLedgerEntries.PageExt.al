
#pragma warning disable DOC0101
/// <summary>
/// PageExtension GeneralLedgerEntries (ID 50009) extends Record General Ledger Entries.
/// </summary>
#pragma warning disable DOC0101
pageextension 50009 GeneralLedgerEntries extends "General Ledger Entries"
#pragma warning restore DOC0101
#pragma warning restore DOC0101
{
    layout
    {
        addafter("Dimension Set ID")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = All;
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Creation Date field.', Comment = '%';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
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

