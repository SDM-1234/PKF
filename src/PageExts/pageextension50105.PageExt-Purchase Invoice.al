pageextension 50105 pageextension50105 extends "Purchase Invoice"
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
        addafter("Prices Including VAT")
        {
            field("Posting No."; "Posting No.")
            {
            }
        }
    }
}

