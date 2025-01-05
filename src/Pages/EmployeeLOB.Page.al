page 50010 "Employee LOB"
{
    PageType = List;
    SourceTable = "Employee LOB";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LOB; Rec.LOB)
                {
                }
                field(Segment; Rec.Segment)
                {
                }
                field("Emp No."; Rec."Emp No.")
                {
                }
                field("Emp Name"; Rec."Emp Name")
                {
                }
                field("Contact No."; Rec."Contact No.")
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

