pageextension 50066 pageextension50066 extends "Customer List"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Search Name"(Control 12)".

        modify("Fax No.")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field(Address; Address)
            {
            }
            field("Address 2"; "Address 2")
            {
            }
            field(City; City)
            {
            }
        }
        addafter("Post Code")
        {
            field("State Code"; "State Code")
            {
            }
        }
        addafter("Phone No.")
        {
            field("E-Mail"; "E-Mail")
            {
            }
            field("L.S.T. No."; "L.S.T. No.")
            {
                Caption = 'TAN No.';
                Visible = false;
            }
        }
        addafter("Search Name")
        {
            field("Balance (LCY)"; "Balance (LCY)")
            {
            }
            field("Sales (LCY)"; "Sales (LCY)")
            {
            }
        }
        addafter(Blocked)
        {
            field("P.A.N. No."; "P.A.N. No.")
            {
            }
            field("GST Customer Type"; "GST Customer Type")
            {
            }
            field("GST Registration No."; "GST Registration No.")
            {
            }
        }
    }
}

