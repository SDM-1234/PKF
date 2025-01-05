page 50012 "Reminder Types"
{
    CardPageID = "Reminder Type Card";
    PageType = List;
    SourceTable = "Reminder Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
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
    }
}

