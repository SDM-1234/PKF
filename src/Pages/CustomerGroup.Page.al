page 50000 "Customer Group"
{
    PageType = List;
    SourceTable = "Customer Group";
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
                field("Customer Group"; Rec."Customer Group")
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

