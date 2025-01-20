pageextension 50161 PurchCrMemoSubform extends "Purch. Cr. Memo Subform"

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
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("Line Discount Amount")
        {
            // field("Service Tax Group"; Rec."Service Tax Group")
            // {
            //     ApplicationArea = All;
            // }
            // field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
            // {
            //     ApplicationArea = All;
            // }
        }
    }
}

