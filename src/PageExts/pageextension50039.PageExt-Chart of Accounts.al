pageextension 50039 pageextension50039 extends "Chart of Accounts"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".

    }
    var
        "PKF_SDM-": Integer;
        GLUserSetup: Record "GL User Setup";


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoEmphasize := "Account Type" <> "Account Type"::Posting;
        NameIndent := Indentation;
        NameEmphasize := "Account Type" <> "Account Type"::Posting;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        AccountsPermission;//AD_SD

        //RSF.SDM.281024
        FILTERGROUP(2);
        SETFILTER("No.",GLUserSetup.FilterGLAccount);
        FILTERGROUP(0);
        //RSF.SDM.281024
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        AccountsPermission;//AD_SD

        //RSF.SDM.281024
        FILTERGROUP(2);
        SETFILTER("No.",GLUserSetup.FilterGLAccount);
        FILTERGROUP(0);
        //RSF.SDM.281024
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

