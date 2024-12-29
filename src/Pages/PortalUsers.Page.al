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
                field("User Name"; "User Name")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field("Super User"; "Super User")
                {
                }
                field(State; State)
                {
                }
                field("Partner Code"; "Partner Code")
                {
                }
                field("Contact Email"; "Contact Email")
                {
                }
            }
        }
    }

    actions
    {
    }
}

