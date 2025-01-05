page 50003 "Primary Incharge"
{
    PageType = List;
    SourceTable = "Primary Incharge";
    ApplicationArea = All;

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

