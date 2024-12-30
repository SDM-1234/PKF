pageextension 50088 pageextension50088 extends "SMTP Mail Setup"
{
    layout
    {
        addafter("Secure Connection")
        {
            field(MailTo; MailTo)
            {
            }
            field(CCTo; CCTo)
            {
            }
            field(BccTo; BccTo)
            {
            }
            field(AddSenderName; AddSenderName)
            {
            }
            field(AddSubject; AddSubject)
            {
            }
            field(AddBody; AddBody)
            {
            }
            field("File Path"; "File Path")
            {
            }
        }
    }
}

