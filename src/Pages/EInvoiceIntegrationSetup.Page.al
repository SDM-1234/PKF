page 50020 "E-Invoice Integration Setup"
{
    PageType = Card;
    SourceTable = "E-Inv Integration Setup";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Primary Key"; "Primary Key")
                {
                    Visible = false;
                }
                field("User Name"; "User Name")
                {
                }
                field(Password; Password)
                {
                }
                field("Owner ID"; "Owner ID")
                {
                    Visible = false;
                }
                field("Client ID"; "Client ID")
                {
                    Visible = false;
                }
                field("Client Secret"; "Client Secret")
                {
                    Visible = false;
                }
                field("Access Token"; "Access Token")
                {
                }
                field("Access Token Validity"; "Access Token Validity")
                {
                }
                field("B2C E-Invoicing"; "B2C E-Invoicing")
                {
                }
                field("Mode of E-Invoice - Sales"; "Mode of E-Invoice - Sales")
                {
                }
                field("Mode of E-Invoice - Purchase"; "Mode of E-Invoice - Purchase")
                {
                    Visible = false;
                }
                field("Mode of E-Invoice - Transfer"; "Mode of E-Invoice - Transfer")
                {
                    Visible = false;
                }
                field("Access Token URL"; "Access Token URL")
                {
                    Visible = false;
                }
                field("Generate E-Invoice URL"; "Generate E-Invoice URL")
                {
                }
                field("Cancel E-Invoice URL"; "Cancel E-Invoice URL")
                {
                }
                field("Activation Date"; "Activation Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

