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
                field("Group Code"; "Group Code")
                {
                }
                field("Customer Group"; "Customer Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

