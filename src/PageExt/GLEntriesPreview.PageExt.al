pageextension 50006 GLEntriesPreview extends "G/L Entries Preview"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }

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
    }

}

