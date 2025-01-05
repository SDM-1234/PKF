page 50001 "Customer Group Code"
{
    PageType = List;
    SourceTable = "Customer Group Code";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; Rec."Group Code")
                {
                }
                field("Group Description"; Rec."Group Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

