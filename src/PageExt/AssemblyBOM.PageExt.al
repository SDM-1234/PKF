pageextension 50081 AssemblyBOM extends "Assembly BOM"
{
    layout
    {
        addfirst(Control1)
        {
            field("Parent Item No."; Rec."Parent Item No.")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

