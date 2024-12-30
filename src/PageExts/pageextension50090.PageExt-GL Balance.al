pageextension 50090 pageextension50090 extends "G/L Balance"
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
        modify("Debit Amount")
        {
            Editable = false;
        }
        modify("Credit Amount")
        {
            Editable = false;
        }
        modify("Net Change")
        {
            Editable = false;
        }
        addafter(Name)
        {
            field("Account Type"; "Account Type")
            {
                Editable = false;
            }
        }
    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NameIndent := 0;
    IF DebitCreditTotals THEN
      CALCFIELDS("Net Change","Debit Amount","Credit Amount")
    #4..11
      END
    END;
    FormatLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14

    AccountsPermission;//SDMBCS on 02022019
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FindPeriod('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
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

