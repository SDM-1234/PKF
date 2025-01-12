page 50004 "LOB Master"
{
    PageType = List;
    SourceTable = "LOB Master";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Line of Business Master';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LOB; Rec.LOB)
                {
                    ToolTip = 'Line of Business';
                }
            }
        }
    }

    actions
    {
    }
}

