pageextension 50031 PostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action("GST Fee Credit Memo")
            {
                Caption = 'GST Fee Credit Memo';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = New;
                ToolTip = 'Executes the GST Fee Credit Memo action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50016, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
            action("GST Expense Credit Memo")
            {
                Caption = 'GST Expense Credit Memo';
                Image = CreditMemo;
                Promoted = true;
                ToolTip = 'Executes the GST Expense Credit Memo action.';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50018, true, false, SalesCreditMemoHeader);
                end;
            }
        }
        addafter("Import E-Invoice Response")
        {
            action("Generate E-Invoice Cleartax")
            {
                Image = ElectronicCollectedTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate E-Invoice Cleartax';
                ApplicationArea = All;
                trigger OnAction()
                begin

                end;
            }
        }
    }
}

