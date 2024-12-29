page 50009 "Portal User Card"
{
    PageType = Card;
    SourceTable = "Portal User";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User Name"; "User Name")
                {
                }
                field(Password; Password)
                {
                    ExtendedDatatype = Masked;
                }
                field(State; State)
                {
                }
                field("Super User"; "Super User")
                {
                }
            }
            group("Personal Details")
            {
                field("Full Name"; "Full Name")
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

