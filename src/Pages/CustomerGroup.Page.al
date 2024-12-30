page 50000 "Customer Group"
{
    PageType = List;
    SourceTable = "Customer Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; Rec."Group Code")
                {
                }
                field("Customer Group"; Rec."Customer Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

