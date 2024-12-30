pageextension 50060 pageextension50060 extends "G/L Account Card"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Search Name"(Control 22)".

        modify("Direct Posting")
        {
            Editable = true;
        }
        addafter(Balance)
        {
            field("RSF View"; "RSF View")
            {
            }
        }
        addafter("Direct Posting")
        {
            field("RTGS Deb. Amt. Control"; "RTGS Deb. Amt. Control")
            {
            }
            field("RTGS Cre. Amt. Control"; "RTGS Cre. Amt. Control")
            {
            }
        }
        addafter(General)
        {
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Normal User Hide"; "Normal User Hide")
                {
                }
                field("Super User Hide"; "Super User Hide")
                {
                }
                field("BLR Hide"; "BLR Hide")
                {
                }
                field("HYD Hide"; "HYD Hide")
                {
                }
                field("AUDIT Hide"; "AUDIT Hide")
                {
                }
                field("DEL Hide"; "DEL Hide")
                {
                }
                field("MUM Hide"; "MUM Hide")
                {
                }
                field("CHN FO Hide"; "CHN FO Hide")
                {
                }
                field("Invoice Hide"; "Invoice Hide")
                {
                }
                field("Payroll + Normal User Hide"; "Payroll + Normal User Hide")
                {
                }
                field("Payroll Hide"; "Payroll Hide")
                {
                }
                field("Recievable Hide"; "Recievable Hide")
                {
                }
            }
        }
    }


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*
    AccountsPermission;
    */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    AccountsPermission;
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

