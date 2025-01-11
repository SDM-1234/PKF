pageextension 50003 AccountScheduleNames extends "Account Schedule Names"
{

    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    trigger OnAfterGetRecord()
    begin
        AccSchPremission();//AD_SD
    end;



    trigger OnOpenPage()
    begin
        AccSchPremission();//AD_SD
    end;

    local procedure AccSchPremission()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET();
        UserSetup.SETRANGE(UserSetup."User ID", UPPERCASE(USERID));
        IF UserSetup.FINDFIRST() THEN
            IF UserSetup."Super Super User" = FALSE THEN BEGIN
                Rec.SETRANGE("Super User Show", TRUE);
                IF UserSetup."Super User" = FALSE THEN
                    Rec.SETRANGE("Normal User Show", TRUE);
            END ELSE
                IF UserSetup."Super User" = FALSE THEN
                    Rec.SETRANGE("Super User Show", TRUE);
    end;
}

