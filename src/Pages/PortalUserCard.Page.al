page 50009 "Portal User Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Portal User";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User Name"; Rec."User Name")
                {
                }
                field(Password; Rec.Password)
                {
                    ExtendedDatatype = Masked;
                }
                field(State; Rec.State)
                {
                }
                field("Super User"; Rec."Super User")
                {
                }
            }
            group("Personal Details")
            {
                field("Full Name"; Rec."Full Name")
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

