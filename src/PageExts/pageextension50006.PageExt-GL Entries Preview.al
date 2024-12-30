pageextension 50006 pageextension50006 extends "G/L Entries Preview"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 10)".

        modify("Job No.")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        addafter("Global Dimension 2 Code")
        {
            field("Debit Amount"; "Debit Amount")
            {
            }
            field("Credit Amount"; "Credit Amount")
            {
            }
        }
    }
}

