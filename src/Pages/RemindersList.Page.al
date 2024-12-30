page 50014 "Reminders List"
{
    CardPageID = "Reminder List Card";
    Editable = false;
    PageType = List;
    SourceTable = "Reminder List";

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
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
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
                    EmailReminderMonthly.RUN
                end;
            }
            action("Send Reminder For Week")
            {
                Caption = 'Send Reminder For Week';
                Image = Reminder;

                trigger OnAction()
                begin
                    EmailReminderWeekly.RUN;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Field20Visible := TRUE;
        Field19Visible := TRUE;
        Field18Visible := TRUE;
        Field17Visible := TRUE;
        Field16Visible := TRUE;
        Field15Visible := TRUE;
        Field14Visible := TRUE;
        Field13Visible := TRUE;
        Field12Visible := TRUE;
        Field11Visible := TRUE;
        Field10Visible := TRUE;
        Field9Visible := TRUE;
        Field8Visible := TRUE;
        Field7Visible := TRUE;
        Field6Visible := TRUE;
        Field5Visible := TRUE;
        Field4Visible := TRUE;
        Field3Visible := TRUE;
        Field2Visible := TRUE;
        Field1Visible := TRUE;
    end;

    var
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        EmailReminderWeekly: Codeunit "Email Reminder-Weekely";
        EmailReminderMonthly: Codeunit "Email Reminder-Monthly";
}

