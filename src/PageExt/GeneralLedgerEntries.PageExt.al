
/// <summary>
/// PageExtension GeneralLedgerEntries (ID 50009) extends Record General Ledger Entries.
/// </summary>
pageextension 50009 GeneralLedgerEntries extends "General Ledger Entries"
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

    trigger OnAfterGetRecord()
    begin
        Rec.FILTERGROUP(2);
        if not GLNos THEN
            Rec.SETFILTER("G/L Account No.", GLUserSetup.FilterGLAccount())
        else begin
            Rec.SETRANGE("Document No.", DocNoVar);
            Rec.SETRANGE("Posting Date", PostingDateVar);
        end;
        Rec.FILTERGROUP(0);

    end;

    trigger OnOpenPage()
    begin
        GLNos := GLFilterSingleInstance.GetGLFilter();
        PostingDateVar := GLFilterSingleInstance.GetPostingDate();
        DocNoVar := GLFilterSingleInstance.GetDocNo();

        Rec.FILTERGROUP(2);
        if NOT GLNos THEN
            Rec.SETFILTER("G/L Account No.", GLUserSetup.FilterGLAccount())
        ELSE BEGIN
            Rec.SETRANGE("Document No.", DocNoVar);
            Rec.SETRANGE("Posting Date", PostingDateVar);
        END;
        Rec.FILTERGROUP(0);
    end;

    var
        GLUserSetup: Record "GL User Setup";
        GLFilterSingleInstance: Codeunit "GL Filter Single Instance";
        GLNos: Boolean;
        DocNoVar: Code[20];
        PostingDateVar: Date;
}

