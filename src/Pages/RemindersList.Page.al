/// <summary>
/// Page Reminders List (ID 50014).
/// </summary>
page 50014 "Reminders List"
{
    CardPageID = "Reminder List Card";
    Editable = false;
    PageType = List;
    SourceTable = "Reminder List";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'PKF - Reminder Lists';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = Field2Visible;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin

                        IF Rec.AssistEditProc() THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Type; Rec.Type)
                {
                    Editable = Field2Visible;
                }
                field(Decription; Rec.Decription)
                {
                    Editable = Field3Visible;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    Editable = Field4Visible;
                }
                field("Purchase Amount"; Rec."Purchase Amount")
                {
                    Editable = Field5Visible;
                }
                field("Start Period"; Rec."Start Period")
                {
                    Editable = Field2Visible;
                }
                field("End Period"; Rec."End Period")
                {
                    Editable = Field7Visible;
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Company; Rec.Company)
                {
                }
                field("Count"; Rec.Count)
                {
                }
                field("Send To"; Rec."Send To")
                {
                }
                field("Send CC"; Rec."Send CC")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Generated From Previous Entry"; Rec."Generated From Previous Entry")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000012; Outlook)
            {
            }
            systempart(Control1000000013; Notes)
            {
            }
            systempart(Control1000000014; MyNotes)
            {
            }
            systempart(Control1000000015; Links)
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
                    EmailReminderMonthly.RUN();
                end;
            }
            action("Send Reminder For Week")
            {
                Caption = 'Send Reminder For Week';
                Image = Reminder;

                trigger OnAction()
                begin
                    EmailReminderWeekly.RUN();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Field5Visible := TRUE;
        Field4Visible := TRUE;
        Field3Visible := TRUE;
        Field2Visible := TRUE;
    end;

    var
        EmailReminderWeekly: Codeunit "Email Reminder-Weekely";
        EmailReminderMonthly: Codeunit "Email Reminder-Monthly";


        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;


        Field7Visible: Boolean;

}

