table 50010 "E-Inv Integration Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Password; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Client ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Client Secret"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Access Token"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(7; "Access Token Validity"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "B2C E-Invoicing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Mode of E-Invoice - Sales"; Enum ModeOfEInvoice)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Mode of E-Invoice - Purchase"; Enum ModeOfEinvoicePurchase)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Mode of E-Invoice - Transfer"; Enum ModeOfEInvTransfer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Access Token URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Generate E-Invoice URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Cancel E-Invoice URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Activation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Owner ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

