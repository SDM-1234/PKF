page 50000 "Customer Group"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Customer Group";
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

