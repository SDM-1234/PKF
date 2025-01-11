pageextension 50123 LocationCard extends "Location Card"
{
    layout
    {
        addafter("Tax Information")
        {
            field("MSME No."; Rec."MSME No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bonded warehouse")
        {
            field("Cleartax Owner ID"; Rec."Cleartax Owner ID")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

    }

}

