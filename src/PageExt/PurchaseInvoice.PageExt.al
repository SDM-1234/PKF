pageextension 50105 PurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
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
        addafter("Posting No. Series")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

