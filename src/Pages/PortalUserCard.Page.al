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
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Password; Rec.Password)
                {
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                }
                field("Super User"; Rec."Super User")
                {
                    ToolTip = 'Specifies the value of the Super User field.';
                }
            }
            group("Personal Details")
            {
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.';
                }
                field("Partner Code"; Rec."Partner Code")
                {
                    ToolTip = 'Specifies the value of the Partner Code field.';
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ToolTip = 'Specifies the value of the Contact Email field.';
                }
            }
        }
    }

    actions
    {
    }
}

