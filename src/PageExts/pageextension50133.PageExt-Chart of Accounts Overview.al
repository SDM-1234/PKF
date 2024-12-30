pageextension 50133 pageextension50133 extends "Chart of Accounts Overview"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NameIndent := 0;
    IF IsExpanded(Rec) THEN
      ActualExpansionStatus := 1
    #4..6
      ELSE
        ActualExpansionStatus := 2;
    FormatLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    AccountsPermission;//SDMBCS on 02022019
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpandAll
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ExpandAll;

    AccountsPermission;//SDMBCS on 02022019
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

