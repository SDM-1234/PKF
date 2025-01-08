page 50013 "Reminder Type Card"
{
    PageType = Card;
    SourceTable = "Reminder Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
            group("Email Parameters")
            {
                field("Send To"; Rec."Send To")
                {
                }
                field("Send CC"; Rec."Send CC")
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
                ToolTip = 'Executes the Send Reminder For Month action.';

                trigger OnAction()
                begin
                    EmailReminderMonthly.RUN();
                end;
            }
            action("Send Reminder For Week")
            {
                Caption = 'Send Reminder For Week';
                Image = Reminder;
                ToolTip = 'Executes the Send Reminder For Week action.';

                trigger OnAction()
                begin
                    EmailReminderWeekly.RUN();
                end;
            }
        }
        area(Promoted)
        {
            actionref(SendReminderForMonth_Promoted; "Send Reminder For Month")
            {
            }
            actionref(SendReminderForWeek_Promoted; "Send Reminder For Week")
            {
            }

        }
    }

    var
        EmailReminderWeekly: Codeunit "Email Reminder-Weekely";
        EmailReminderMonthly: Codeunit "Email Reminder-Monthly";
}

