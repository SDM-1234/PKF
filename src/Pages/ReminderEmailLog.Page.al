page 50011 "Reminder Email Log"
{
    PageType = List;
    SourceTable = "Reminder Email Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Reminder No."; "Reminder No.")
                {
                }
                field("Period Start"; "Period Start")
                {
                }
                field("Period End"; "Period End")
                {
                }
                field("Email Sending Status"; "Email Sending Status")
                {
                }
                field(Error; Error)
                {
                }
                field("Error Text"; "Error Text")
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

