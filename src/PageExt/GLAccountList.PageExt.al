pageextension 50063 GLAccountList extends "G/L Account List"
{
    layout
    {

    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
    }
    var
        GLUserSetup: Record "GL User Setup";


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    begin

        AccountsPermission(); //AD_SD

        //SDM.RSF.281024
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("No.", GLUserSetup.FilterGLAccount());
        Rec.FILTERGROUP(0);
        //SDm.RSF.281024

    end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    trigger OnOpenPage()
    begin

        AccountsPermission(); //AD_SD

        //SDM.RSF.281024
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("No.", GLUserSetup.FilterGLAccount());
        Rec.FILTERGROUP(0);
        //SDm.RSF.281024

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

