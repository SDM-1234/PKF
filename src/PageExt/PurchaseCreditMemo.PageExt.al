pageextension 50112 PurchaseCreditMemo extends "Purchase Credit Memo"
{
    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        addafter("Assigned User ID")
        {

            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. field.', Comment = '%';
            }
            field(State; Rec.State)
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {

            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }

        }
    }
}

