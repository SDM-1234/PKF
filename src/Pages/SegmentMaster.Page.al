page 50005 "Segment Master"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Segment Master";
    UsageCategory = Lists;

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
            }
        }
    }

    actions
    {
    }
}

