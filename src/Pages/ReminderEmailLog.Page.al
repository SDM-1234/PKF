page 50011 "Reminder Email Log"
{
    PageType = List;
    SourceTable = "Reminder Email Log";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Reminder No."; Rec."Reminder No.")
                {
                }
                field("Period Start"; Rec."Period Start")
                {
                }
                field("Period End"; Rec."Period End")
                {
                }
                field("Email Sending Status"; Rec."Email Sending Status")
                {
                }
                field("Error"; Rec.Error)
                {
                }
                field("Error Text"; Rec."Error Text")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000010; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

