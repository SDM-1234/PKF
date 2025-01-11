pageextension 50090 GLBalance extends "G/L Balance"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify(Name)
        {

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
            field("Account Type"; Rec."Account Type")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        AccountsPermission();//SDMBCS on 02022019
    end;

    trigger OnOpenPage()
    begin

        AccountsPermission();//SDMBCS on 02022019
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

