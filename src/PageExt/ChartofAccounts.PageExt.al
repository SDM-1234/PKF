pageextension 50039 ChartofAccounts extends "Chart of Accounts"
{
    layout
    {

    }
    var
        GLUserSetup: Record "GL User Setup";



    trigger OnAfterGetRecord()
    begin
        // AccountsPermission();//AD_SD
        // Rec.FILTERGROUP(2);
        // Rec.SETFILTER("No.", GLUserSetup.FilterGLAccount());
        // Rec.FILTERGROUP(0);
    end;

    trigger OnOpenPage()
    begin
        AccountsPermission();//AD_SD
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("No.", GLUserSetup.FilterGLAccount());
        Rec.FILTERGROUP(0);
    end;

    local procedure AccountsPermission()
    var
        RecUserSetup: Record "User Setup";
    begin
        RecUserSetup.RESET();
        RecUserSetup.SETRANGE(RecUserSetup."User ID", UPPERCASE(USERID));
        IF RecUserSetup.FINDFIRST() THEN
            IF RecUserSetup."Super Super User" = FALSE THEN //BEGIN
                Rec.SETRANGE("Super User Hide", FALSE);
        //  IF RecUserSetup."Super User" = FALSE THEN
        //    Rec.SETRANGE("Normal User Hide", FALSE);
        //END ELSE
        //  IF RecUserSetup."Super User" = FALSE THEN
        //    Rec.SETRANGE("Super User Hide", TRUE);
    end;
}

