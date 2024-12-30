pageextension 50120 pageextension50120 extends "Purch. Invoice Subform"
{
    layout
    {
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
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
            }
        }
    }
}

