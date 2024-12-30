pageextension 50092 pageextension50092 extends "G/L Balance/Budget"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 8)".

            Editable = false;
        }
        modify("Income/Balance")
        {
            Editable = false;
        }
    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NameIndent := 0;
    CalcFormFields;
    FormatLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    AccountsPermission;//SDMBCS on 02022019
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"GLBudget-Open",Rec);
    FindPeriod('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"GLBudget-Open",Rec);
    FindPeriod('');
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

