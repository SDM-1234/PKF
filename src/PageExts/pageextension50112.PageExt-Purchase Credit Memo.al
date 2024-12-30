pageextension 50112 pageextension50112 extends "Purchase Credit Memo"
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
            field("Posting No. Series"; "Posting No. Series")
            {
            }
            field(State; State)
            {
            }
        }
        addafter(Status)
        {
            field(Remarks; Remarks)
            {
            }
        }
    }
}

