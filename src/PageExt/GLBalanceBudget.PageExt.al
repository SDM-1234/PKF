pageextension 50092 GLBalanceBudget extends "G/L Balance/Budget"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify(Name)
        {
            Editable = false;
        }
        modify("Income/Balance")
        {
            Editable = false;
        }
    }
    trigger OnAfterGetRecord()
    begin

        AccountsPermission();//SDMBCS on 02022019
    end;

    trigger OnOpenPage()
    begin

        AccountsPermission();//SDMBCS on 02022019
    end;

    local procedure AccountsPermission()
    var
        RecUserSetup: Record "User Setup";
    begin
        RecUserSetup.RESET();
        RecUserSetup.SETRANGE(RecUserSetup."User ID", UPPERCASE(USERID));
        IF RecUserSetup.FINDFIRST() THEN BEGIN
            IF RecUserSetup."Super Super User" = FALSE THEN
                Rec.SETRANGE("Super User Hide", FALSE);
            IF RecUserSetup."Super User" = FALSE THEN
                Rec.SETRANGE("Normal User Hide", FALSE);
        END ELSE
            IF RecUserSetup."Super User" = FALSE THEN
                Rec.SETRANGE("Super User Hide", TRUE);
    end;
}

