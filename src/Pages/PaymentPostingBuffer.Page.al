page 50018 "Payment Posting Buffer"
{
    ApplicationArea = All;
    Caption = 'Auto Payment Posting';
    PageType = List;
    SourceTable = "Payment Posting Buffer";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Loc; Rec.Loc)
                {
                    ToolTip = 'Specifies the value of the Loc field.', Comment = '%';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.', Comment = '%';
                }
                field(FROM; Rec.FROM)
                {
                    ToolTip = 'Specifies the value of the FROM field.', Comment = '%';
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ToolTip = 'Specifies the value of the Customer ID field.', Comment = '%';
                }
                field("Check No."; Rec."Check No.")
                {
                    ToolTip = 'Specifies the value of the Check No. field.', Comment = '%';
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.', Comment = '%';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the value of the Invoice Type field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    ToolTip = 'Specifies the value of the GST Amount field.', Comment = '%';
                }
                field("Bank Charges"; Rec."Bank Charges")
                {
                    ToolTip = 'Specifies the value of the Bank Charges field.', Comment = '%';
                }
                field("Exchange loss"; Rec."Exchange loss")
                {
                    ToolTip = 'Specifies the value of the Exchange loss field.', Comment = '%';
                }
                field(Total; Rec.Total)
                {
                    ToolTip = 'Specifies the value of the Total field.', Comment = '%';
                }
                field(TDS; Rec.TDS)
                {
                    ToolTip = 'Specifies the value of the TDS field.', Comment = '%';
                }
                field("GR. Fees"; Rec."GR. Fees")
                {
                    ToolTip = 'Specifies the value of the GR. Fees field.', Comment = '%';
                }
                field(RE; Rec.RE)
                {
                    ToolTip = 'Specifies the value of the RE field.', Comment = '%';
                }
                field("ST %"; Rec."ST %")
                {
                    ToolTip = 'Specifies the value of the ST % field.', Comment = '%';
                }
                field("TDS %"; Rec."TDS %")
                {
                    ToolTip = 'Specifies the value of the TDS % field.', Comment = '%';
                }
                field("Doc. Ref"; Rec."Doc. Ref")
                {
                    ToolTip = 'Specifies the value of the Doc. Ref field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.', Comment = '%';
                }
                field("Remaining amount"; Rec."Remaining amount")
                {
                    ToolTip = 'Specifies the value of the Remaining amount field.', Comment = '%';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.', Comment = '%';
                }
                field("Error"; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.', Comment = '%';
                    Editable = false;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ProcessData)
            {
                ApplicationArea = All;
                Caption = 'Process Data';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PaymentPostingMgt: Codeunit "Payemnt Posting Mgt";
                begin
                    PaymentPostingMgt.ProcessData();
                    CurrPage.Update();
                end;
            }
            action(PostData)
            {
                ApplicationArea = All;
                Caption = 'Create & Post Payment Data';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PaymentPostingMgt: Codeunit "Payemnt Posting Mgt";
                begin
                    PaymentPostingMgt.CreateJournalLine();
                end;
            }
        }
    }
}
