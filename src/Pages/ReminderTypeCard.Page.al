page 50013 "Reminder Type Card"
{
    PageType = Card;
    SourceTable = "Reminder Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
            group("Email Parameters")
            {
                field("Send To"; "Send To")
                {
                }
                field("Send CC"; "Send CC")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000006; Outlook)
            {
            }
            systempart(Control1000000007; Notes)
            {
            }
            systempart(Control1000000008; MyNotes)
            {
            }
            systempart(Control1000000009; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Reminder For Month")
            {
                Caption = 'Send Reminder For Month';
                Image = Reminder;

                trigger OnAction()
                begin
                    EmailReminderMonthly.RUN
                end;
            }
            action("Send Reminder For Week")
            {
                Caption = 'Send Reminder For Week';

                trigger OnAction()
                begin
                    EmailReminderWeekly.RUN;
                end;
            }
        }
    }

    var
        EmailReminderWeekly: Codeunit "Email Reminder-Weekely";
        EmailReminderMonthly: Codeunit "Email Reminder-Monthly";
}

