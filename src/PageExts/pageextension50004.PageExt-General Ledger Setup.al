pageextension 50004 pageextension50004 extends "General Ledger Setup"
{
    layout
    {
        addafter("Appln. Rounding Precision")
        {
            field("Amount Decimal Places"; "Amount Decimal Places")
            {
            }
            field("Unit-Amount Decimal Places"; "Unit-Amount Decimal Places")
            {
            }
            field("Amount Rounding Precision"; "Amount Rounding Precision")
            {
            }
            field("Unit-Amount Rounding Precision"; "Unit-Amount Rounding Precision")
            {
            }
        }
        addafter("Tax Information")
        {
            group(Reminder)
            {
                Caption = 'Reminder';
                field("Reminder Nos."; "Reminder Nos.")
                {
                }
            }
        }
    }
    actions
    {
        addafter("Change Payment &Tolerance")
        {
            action("Send Email")
            {
                Caption = 'Send Email';
                Image = SendAsPDF;
                Promoted = true;

                trigger OnAction()
                begin
                    EmplGRec.RESET;
                    EmplGRec.SETFILTER("E-Mail", '<>%1', '');
                    EmplGRec.SETFILTER("Job Title", 'PARTNER');
                    IF EmplGRec.FINDSET THEN BEGIN
                        REPEAT
                            SendMailToEmplWithAttachment(EmplGRec."No.");
                        UNTIL EmplGRec.NEXT = 0;
                    END;
                end;
            }
        }
    }


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked?;ENN=Do you want to change all open entries for every customer and vendor that are not blocked?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;ENN=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?;ENN=If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?;
    //Variable type has not been exported.

    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        EmplGRec: Record Employee;
        ResponsiblePersonwise: Report "Responsible Person-wise";

    procedure SendMailToEmplWithAttachment(EmplId: Code[20])
    var
        Employee: Record Employee;
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        SMTPSetup.GET;
        Employee.GET(EmplId);
        Employee.TESTFIELD("E-Mail");
        CLEAR(ResponsiblePersonwise);
        CLEAR(SMTPMail);
        SMTPMail.CreateMessage(SMTPSetup.AddSenderName, SMTPSetup."User ID", Employee."E-Mail", SMTPSetup.AddSubject, SMTPSetup.AddBody, TRUE);
        SMTPMail.AppendBody('Dear Sir / Madam');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Please find the attached soft copy of your customer outstanding');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Thanks & Regards,');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Accounts Team,');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('PKF Sridhar & Santhanam LLP');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Chartered Accountants');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Note');
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('This is a System generated automatic E-Mail Message. Please do not reply.');
        SMTPMail.AddCC(SMTPSetup.CCTo);

        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Salesperson Code", EmplId);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            ResponsiblePersonwise.SetRecordsVar(EmplId);
            ResponsiblePersonwise.SAVEASPDF(SMTPSetup."File Path" + 'Responsibleperson.pdf');
            SMTPMail.AddAttachment(SMTPSetup."File Path" + 'Responsibleperson.pdf', 'Responsibleperson.pdf');
            SMTPMail.Send;
        END;
    end;
}

