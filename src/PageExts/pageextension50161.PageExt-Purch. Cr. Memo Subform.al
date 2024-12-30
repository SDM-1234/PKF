pageextension 50161 pageextension50161 extends "Purch. Cr. Memo Subform"
{
    layout
    {
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
        }
        addafter("Line Discount Amount")
        {
            field("Service Tax Group"; "Service Tax Group")
            {
            }
            field("TDS Nature of Deduction"; "TDS Nature of Deduction")
            {
            }
        }
    }
}

