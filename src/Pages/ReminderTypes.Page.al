/// <summary>
/// Page Reminder Types (ID 50012).
/// </summary>
page 50012 "Reminder Types"
{
    ApplicationArea = All;
    Caption = 'PKF - Reminder Types';
    CardPageID = "Reminder Type Card";
    PageType = List;
    SourceTable = "Reminder Type";
    UsageCategory = Lists;

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

