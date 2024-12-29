page 50001 "Customer Group Code"
{
    PageType = List;
    SourceTable = "Customer Group Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; "Group Code")
                {
                }
                field("Group Description"; "Group Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

