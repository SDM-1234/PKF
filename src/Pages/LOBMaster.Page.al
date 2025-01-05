page 50004 "LOB Master"
{
    PageType = List;
    SourceTable = "LOB Master";
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
            }
        }
    }

    actions
    {
    }
}

