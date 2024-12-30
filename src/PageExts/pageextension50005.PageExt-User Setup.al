pageextension 50005 pageextension50005 extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Super User"; "Super User")
            {
                Editable = false;
            }
            field("Super Super User"; "Super Super User")
            {
                Editable = false;
            }
            field("E-Mail"; "E-Mail")
            {
            }
        }
    }
}

