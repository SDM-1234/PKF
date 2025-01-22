pageextension 50160 SalesCrMemoSubform extends "Sales Cr. Memo Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}

