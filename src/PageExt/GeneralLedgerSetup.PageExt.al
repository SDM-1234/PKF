pageextension 50004 GeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addafter("Appln. Rounding Precision")
        {
            field("Amount Decimal Places"; Rec."Amount Decimal Places")
            {
                ApplicationArea = All;
            }
            field("Unit-Amount Decimal Places"; Rec."Unit-Amount Decimal Places")
            {
                ApplicationArea = All;
            }
            field("Amount Rounding Precision"; Rec."Amount Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tax Information")
        {
            group(Reminder)
            {
                Caption = 'Reminder';
                field("Reminder Nos."; Rec."Reminder Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast(content)
        {
            group(AutoPaymentPosting)
            {
                Caption = 'Auto Payment Posting';
                field("Payment Posting Template"; Rec."Payment Posting Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Payment Posting field.';
                }
                field("Payment Posting Batch"; Rec."Payment Posting Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Payment Posting field.';
                }
                field("Payment Posting TDS Acc"; Rec."Payment Posting TDS Acc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Payment Posting field.';
                }
                field("Payment Posting Type"; Rec."Payment Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Payment Posting field.';
                }
                field(MyField; Rec."Round off Variance")
                {
                    ApplicationArea = All;
                    Caption = 'Round off Variance';
                    ToolTip = 'Specifies the value of the Round off Variance field.';
                }
                field("Round Off Account"; Rec."Round Off Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Round Off Account field.';
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
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = SendAsPDF;
                Promoted = true;
                ToolTip = 'Click to send email';

                trigger OnAction()
                begin
                    EmplGRec.RESET();
                    EmplGRec.SETFILTER("E-Mail", '<>%1', '');
                    EmplGRec.SETFILTER("Job Title", 'PARTNER');
                    IF EmplGRec.FINDSET() THEN
                        REPEAT
                            SendMailToEmplWithAttachment(EmplGRec."No.");
                        UNTIL EmplGRec.NEXT() = 0;
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
        //SMTPMail: Codeunit "SMTP Mail";
        //SMTPSetup: Record "SMTP Mail Setup";
        EmailMessage: Codeunit "Email Message";
        EmplGRec: Record Employee;

    procedure SendMailToEmplWithAttachment(EmplId: Code[20])
    var
        Employee: Record Employee;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        Email: Codeunit Email;
        ReportParameters: Text;
    //ResponsiblePersonwise: Report "Responsible Person-wise";

    begin
        //SMTPSetup.GET();
        Employee.GET(EmplId);
        Employee.TESTFIELD("E-Mail");
        //CLEAR(ResponsiblePersonwise);
        //CLEAR(SMTPMail);


        //ReportParameters := ResponsiblePersonwise.RunRequestPage();

        TempBlob.CreateOutStream(OutStr);
        //Report.SaveAs(Report::"Responsible Person-wise", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        //EmailMessage.Create();
        EmailMessage.Create('your email goes here', 'This is the subject', 'This is the body');
        EmailMessage.AddAttachment('FileName.pdf', 'PDF', InStr);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        //EmailMessage.CreateMessage(SMTPSetup.AddSenderName, SMTPSetup."User ID", Employee."E-Mail", SMTPSetup.AddSubject, SMTPSetup.AddBody, TRUE);
        EmailMessage.AppendToBody('Dear Sir / Madam');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Please find the attached soft copy of your customer outstanding');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Thanks & Regards,');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Accounts Team,');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('PKF Sridhar & Santhanam LLP');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Chartered Accountants');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Note');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('This is a System generated automatic E-Mail Message. Please do not reply.');
        //EmailMessage.AppendToBody(SMTPSetup.CCTo);

        CustLedgerEntry.RESET();
        CustLedgerEntry.SETRANGE("Salesperson Code", EmplId);
        IF CustLedgerEntry.FINDFIRST() THEN BEGIN
            //ResponsiblePersonwise.SetRecordsVar(EmplId);
            //ResponsiblePersonwise.SAVEASPDF(SMTPSetup."File Path" + 'Responsibleperson.pdf');

            TempBlob.CreateOutStream(OutStr);
            //Report.SaveAs(Report::"Responsible Person-wise", ReportParameters, ReportFormat::Pdf, OutStr);
            TempBlob.CreateInStream(InStr);
            //EmailMessage.Create();
            EmailMessage.Create('your email goes here', 'This is the subject', 'This is the body');
            EmailMessage.AddAttachment('FileName.pdf', 'PDF', InStr);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

            //SMTPMail.AddAttachment(SMTPSetup."File Path" + 'Responsibleperson.pdf', 'Responsibleperson.pdf');
            //SMTPMail.Send;
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default)
        END;
    end;
}

