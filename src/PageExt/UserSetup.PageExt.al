pageextension 50005 UserSetup extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Super User"; Rec."Super User")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Super Super User"; Rec."Super Super User")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
}

