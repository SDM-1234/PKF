page 50002 "Portal Users"
{
    CardPageID = "Portal User Card";
    PageType = List;
    SourceTable = "Portal User";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Name"; Rec."User Name")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
                field("Super User"; Rec."Super User")
                {
                }
                field(State; Rec.State)
                {
                }
                field("Partner Code"; Rec."Partner Code")
                {
                }
                field("Contact Email"; Rec."Contact Email")
                {
                }
            }
        }
    }

    actions
    {
    }
}

