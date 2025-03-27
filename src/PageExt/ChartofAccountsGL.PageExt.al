pageextension 50122 ChartofAccountsGL extends "Chart of Accounts (G/L)"
{
    layout
    {

    }

    trigger OnOpenPage()
    begin

        //AccountsPermission();//SDMBCS on 02022019

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
    END;

}

