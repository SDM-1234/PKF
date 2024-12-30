page 50005 "Segment Master"
{
    PageType = List;
    SourceTable = "Segment Master";

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

