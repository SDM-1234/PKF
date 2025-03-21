/// <summary>
/// Page EmailParamers (ID 50088).
/// </summary>
page 50088 EmailParamers
{
    ApplicationArea = all;
    Caption = 'PKF SMTP Mail Setup Parameters';
    SourceTable = EmailParameter;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            field(AddBody; Rec.AddBody)
            {
            }
            field(AddSenderName; Rec.AddSenderName)
            {
            }
            field(AddSubject; Rec.AddSubject)
            {
            }
            field(BccTo; Rec.BccTo)
            {
            }
            field(CCTo; Rec.CCTo)
            {
            }
            field("File Path"; Rec."File Path")
            {
            }
            field(MailTo; Rec.MailTo)
            {
            }
        }
    }
}

