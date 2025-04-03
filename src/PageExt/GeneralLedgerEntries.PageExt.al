
/// <summary>
/// PageExtension GeneralLedgerEntries (ID 50009) extends Record General Ledger Entries.
/// </summary>
pageextension 50009 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {

        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify(Description)
        {
            Editable = false;
        }
        addafter("Dimension Set ID")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                Editable = false;
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
            field("Source Vendor Name"; Rec."Source Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Vendor Name field.', Comment = '%';
            }
            field("Source Customer Name"; Rec."Source Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Customer Name field.', Comment = '%';
            }
            field("Remarks Sales Invoice"; Rec."Remarks Sales Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks Sales Invoice field.', Comment = '%';
            }
            field("Account Id"; Rec."Account Id")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Id field.', Comment = '%';
            }
            field("Remarks Sales Cr. Memo"; Rec."Remarks Sales Cr. Memo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks Sales Cr. Memo field.', Comment = '%';
            }
            field("Remarks Purch. Cr. Memo"; Rec."Remarks Purch. Cr. Memo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks Purch. Cr. Memo field.', Comment = '%';
            }
            field("Remarks Purch. Invoice"; Rec."Remarks Purch. Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks Purch. Invoice field.', Comment = '%';
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Creation Date field.', Comment = '%';
            }
            field("PAN No."; Rec."PAN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PAN No. field.', Comment = '%';
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Leader field.', Comment = '%';
            }
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LOB field.', Comment = '%';
            }
            field("Sales Code"; Rec."Sales Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Code field.', Comment = '%';
            }
            field("Sales Name"; Rec."Sales Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Name field.', Comment = '%';
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

