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
                ToolTip = 'Specifies the value of the AddBody field.', Comment = '%';
            }
            field(AddSenderName; Rec.AddSenderName)
            {
                ToolTip = 'Specifies the value of the AddSenderName field.', Comment = '%';
            }
            field(AddSubject; Rec.AddSubject)
            {
                ToolTip = 'Specifies the value of the AddSubject field.', Comment = '%';
            }
            field(BccTo; Rec.BccTo)
            {
                ToolTip = 'Specifies the value of the BccTo field.', Comment = '%';
            }
            field(CCTo; Rec.CCTo)
            {
                ToolTip = 'Specifies the value of the CCTo field.', Comment = '%';
            }
            field("File Path"; Rec."File Path")
            {
                ToolTip = 'Specifies the value of the File Path field.', Comment = '%';
            }
            field(MailTo; Rec.MailTo)
            {
                ToolTip = 'Specifies the value of the MailTo field.', Comment = '%';
            }
        }
    }
}

