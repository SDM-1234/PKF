pageextension 50063 pageextension50063 extends "G/L Account List"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".

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

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NameIndent := 0;
        FormatLine;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        NameIndent := 0;
        FormatLine;
        AccountsPermission; //AD_SD

        //SDM.RSF.281024
        FILTERGROUP(2);
        SETFILTER("No.",GLUserSetup.FilterGLAccount);
        FILTERGROUP(0);
        //SDm.RSF.281024
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        AccountsPermission; //AD_SD

        //SDM.RSF.281024
        FILTERGROUP(2);
        SETFILTER("No.",GLUserSetup.FilterGLAccount);
        FILTERGROUP(0);
        //SDm.RSF.281024
        */
        //end;

    local procedure AccountsPermission()
    var
        RecUserSetup: Record "User Setup";
    begin
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE(RecUserSetup."User ID", UPPERCASE(USERID));
        IF RecUserSetup.FINDFIRST THEN BEGIN
            IF RecUserSetup."Super Super User" = FALSE THEN BEGIN
                SETRANGE("Super User Hide", FALSE);
                IF RecUserSetup."Super User" = FALSE THEN BEGIN
                    SETRANGE("Normal User Hide", FALSE);
                END;
            END ELSE
                IF RecUserSetup."Super User" = FALSE THEN BEGIN
                    SETRANGE("Super User Hide", TRUE);
                END;
        END;
    end;
}

