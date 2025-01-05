page 50001 "Customer Group Code"
{
    PageType = List;
    SourceTable = "Customer Group Code";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Group Description"; Rec."Group Description")
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

