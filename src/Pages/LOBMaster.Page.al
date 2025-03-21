page 50004 "LOB Master"
{
    ApplicationArea = All;
    Caption = 'Line of Business Master';
    PageType = List;
    SourceTable = "LOB Master";
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
            }
        }
    }

    actions
    {
    }
}

