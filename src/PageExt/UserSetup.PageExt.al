pageextension 50005 UserSetup extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Super User"; Rec."Super User")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Super Super User"; Rec."Super Super User")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
}

