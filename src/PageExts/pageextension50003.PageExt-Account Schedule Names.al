pageextension 50003 pageextension50003 extends "Account Schedule Names"
{

    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*
    AccSchPremission;//AD_SD
    */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    AccSchPremission;//AD_SD
    */
    //end;

    local procedure AccSchPremission()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE(UserSetup."User ID", UPPERCASE(USERID));
        IF UserSetup.FINDFIRST THEN BEGIN
            IF UserSetup."Super Super User" = FALSE THEN BEGIN
                SETRANGE("Super User Show", TRUE);
                IF UserSetup."Super User" = FALSE THEN BEGIN
                    SETRANGE("Normal User Show", TRUE);
                END;
            END ELSE
                IF UserSetup."Super User" = FALSE THEN BEGIN
                    SETRANGE("Super User Show", TRUE);
                END;
        END;
    end;
}

