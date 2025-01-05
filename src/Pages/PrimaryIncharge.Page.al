page 50003 "Primary Incharge"
{
    PageType = List;
    SourceTable = "Primary Incharge";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incharge Code"; Rec."Incharge Code")
                {
                    ApplicationArea = All;
                }
                field("Incharge Description"; Rec."Incharge Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

