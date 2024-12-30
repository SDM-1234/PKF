page 50003 "Primary Incharge"
{
    PageType = List;
    SourceTable = "Primary Incharge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incharge Code"; Rec."Incharge Code")
                {
                }
                field("Incharge Description"; Rec."Incharge Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

