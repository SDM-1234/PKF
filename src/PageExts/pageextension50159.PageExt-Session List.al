pageextension 50159 pageextension50159 extends "Session List"
{
    actions
    {
        addafter("Debug Next Session")
        {
            action("Kill Session")
            {

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to kill the session ?') THEN
                        STOPSESSION("Session ID");
                end;
            }
        }
    }
}

