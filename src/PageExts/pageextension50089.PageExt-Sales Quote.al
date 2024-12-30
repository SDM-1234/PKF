pageextension 50089 pageextension50089 extends "Sales Quote"
{
    layout
    {
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address"(Control 71)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address 2"(Control 73)".

        modify("Order Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {

            //Unsupported feature: Property Modification (Name) on "Status(Control 106)".


            //Unsupported feature: Property Modification (SourceExpr) on "Status(Control 106)".

            Importance = Additional;

            //Unsupported feature: Property Modification (ImplicitType) on "Status(Control 106)".

        }
        modify(Control1500004)
        {
            Editable = true;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 18)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address"(Control 20)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address 2"(Control 22)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 38)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 40)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address 2"(Control 42)".

        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("Sell-to Contact")
        {
            field("Location Code"; "Location Code")
            {
                Editable = true;
                Importance = Promoted;

                trigger OnValidate()
                begin
                    SetLocGSTRegNoEditable;
                end;
            }
        }
        addafter("Order Date")
        {
            field("Posting Date"; "Posting Date")
            {
            }
        }
        addafter("Document Date")
        {
            field("Payment Terms Code"; "Payment Terms Code")
            {
                Importance = Promoted;
            }
            field("External Document No."; "External Document No.")
            {
            }
        }
        addafter("Salesperson Code")
        {
            field(LOB; LOB)
            {
                Editable = false;
            }
            field(Segment; Segment)
            {
                Editable = false;
            }
            field("Resp. Name"; "Resp. Name")
            {
                Editable = false;
            }
        }
        addafter("Assigned User ID")
        {
            field(Remarks; Remarks)
            {
            }
            field("Invoice Types"; "Invoice Types")
            {
            }
            field("Team Leader"; "Team Leader")
            {
                Importance = Additional;
            }
            field("Sales Currency"; "Sales Currency")
            {
            }
        }
        addafter(Status)
        {
            field("Take Print"; "Take Print")
            {
                Visible = false;
            }
            field("Posting No."; "Posting No.")
            {
                Editable = false;
                Importance = Additional;
            }
        }
    }
}

