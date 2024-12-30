pageextension 50160 pageextension50160 extends "Sales Cr. Memo Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".

        addfirst(Control1)
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }
        }
        addafter("Line Amount")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
            }
            field("Service Tax Group"; "Service Tax Group")
            {
            }
        }
    }
}

