pageextension 50100 pageextension50100 extends "Sales Invoice Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".

        modify("TCS Nature of Collection")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Visible = true;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Document No.")
        {
            Visible = false;
        }
        modify("Line No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }
        }
        addafter("Service Tax Registration No.")
        {
            field("Service Tax Group"; "Service Tax Group")
            {
                Visible = false;
            }
        }
        addafter("Line Discount Amount")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field(Scope1; Scope1)
            {
            }
            field(Scope2; Scope2)
            {
            }
            field(Scope3; Scope3)
            {
            }
            field(Scope4; Scope4)
            {
            }
        }
    }
}

