pageextension 50060 GLAccountCard extends "G/L Account Card"
{
    layout
    {

        modify("Direct Posting")
        {
            Editable = true;
        }
        addafter(Balance)
        {
            field("RSF View"; Rec."RSF View")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Posting")
        {
            field("RTGS Deb. Amt. Control"; Rec."RTGS Deb. Amt. Control")
            {
                ApplicationArea = All;
            }
            field("RTGS Cre. Amt. Control"; Rec."RTGS Cre. Amt. Control")
            {
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Normal User Hide"; Rec."Normal User Hide")
                {
                    ApplicationArea = All;
                }
                field("Super User Hide"; Rec."Super User Hide")
                {
                    ApplicationArea = All;
                }
                field("BLR Hide"; Rec."BLR Hide")
                {
                    ApplicationArea = All;
                }
                field("HYD Hide"; Rec."HYD Hide")
                {
                    ApplicationArea = All;
                }
                field("AUDIT Hide"; Rec."AUDIT Hide")
                {
                    ApplicationArea = All;
                }
                field("DEL Hide"; Rec."DEL Hide")
                {
                    ApplicationArea = All;
                }
                field("MUM Hide"; Rec."MUM Hide")
                {
                    ApplicationArea = All;
                }
                field("CHN FO Hide"; Rec."CHN FO Hide")
                {
                    ApplicationArea = All;
                }
                field("Invoice Hide"; Rec."Invoice Hide")
                {
                    ApplicationArea = All;
                }
                field("Payroll + Normal User Hide"; Rec."Payroll + Normal User Hide")
                {
                    ApplicationArea = All;
                }
                field("Payroll Hide"; Rec."Payroll Hide")
                {
                    ApplicationArea = All;
                }
                field("Recievable Hide"; Rec."Recievable Hide")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin

        AccountsPermission();

    end;


    trigger OnOpenPage()
    begin

        AccountsPermission();

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

