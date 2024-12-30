pageextension 50102 pageextension50102 extends "Purchase Order"
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
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("Payment Terms Code"; "Payment Terms Code")
            {
                Importance = Promoted;
            }
            field("Shipment Method Code"; "Shipment Method Code")
            {
            }
            field("Location Code"; "Location Code")
            {
                Importance = Promoted;

                trigger OnValidate()
                begin
                    SetLocGSTRegNoEditable;
                end;
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
            }
            field("License Start Date"; "License Start Date")
            {
            }
            field("License End Date"; "License End Date")
            {
            }
        }
    }
}

