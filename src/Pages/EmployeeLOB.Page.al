page 50010 "Employee LOB"
{
    PageType = List;
    SourceTable = "Employee LOB";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LOB; LOB)
                {
                }
                field(Segment; Segment)
                {
                }
                field("Emp No."; "Emp No.")
                {
                }
                field("Emp Name"; "Emp Name")
                {
                }
                field("Contact No."; "Contact No.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000008; Outlook)
            {
            }
            systempart(Control1000000009; Notes)
            {
            }
            systempart(Control1000000010; Links)
            {
            }
        }
    }

    actions
    {
    }
}

