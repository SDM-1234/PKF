pageextension 50102 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Importance = Standard;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("License Start Date"; Rec."License Start Date")
            {

                ApplicationArea = all;
            }
            field("License End Date"; Rec."License End Date")
            {

                ApplicationArea = all;
            }
        }
    }
}

