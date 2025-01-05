page 50020 "E-Invoice Integration Setup"
{
    PageType = Card;
    SourceTable = "E-Inv Integration Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    Visible = false;
                }
                field("User Name"; Rec."User Name")
                {
                }
                field(Password; Rec.Password)
                {
                }
                field("Owner ID"; Rec."Owner ID")
                {
                    Visible = false;
                }
                field("Client ID"; Rec."Client ID")
                {
                    Visible = false;
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    Visible = false;
                }
                field("Access Token"; Rec."Access Token")
                {
                }
                field("Access Token Validity"; Rec."Access Token Validity")
                {
                }
                field("B2C E-Invoicing"; Rec."B2C E-Invoicing")
                {
                }
                field("Mode of E-Invoice - Sales"; Rec."Mode of E-Invoice - Sales")
                {
                }
                field("Mode of E-Invoice - Purchase"; Rec."Mode of E-Invoice - Purchase")
                {
                    Visible = false;
                }
                field("Mode of E-Invoice - Transfer"; Rec."Mode of E-Invoice - Transfer")
                {
                    Visible = false;
                }
                field("Access Token URL"; Rec."Access Token URL")
                {
                    Visible = false;
                }
                field("Generate E-Invoice URL"; Rec."Generate E-Invoice URL")
                {
                }
                field("Cancel E-Invoice URL"; Rec."Cancel E-Invoice URL")
                {
                }
                field("Activation Date"; Rec."Activation Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

