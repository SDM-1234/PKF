page 50012 "Reminder Types"
{
    CardPageID = "Reminder Type Card";
    PageType = List;
    SourceTable = "Reminder Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
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
    }
}

