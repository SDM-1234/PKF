table 50011 "E-Invoicing Requests"
{

    fields
    {
        field(1; "Entry No."; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sale Invoice,Sale Cr. Memo,Transfer';
            OptionMembers = " ","Sale Invoice","Sale Cr. Memo",Transfer;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Acknowledgement No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Acknowledgement Date"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "IRN No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Signed QR Code"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Error Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Request ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Request Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Signed Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Signed QR Code2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Signed QR Code3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "QR Image"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "E-Invoice Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "E-Invoice Canceled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Cancel Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Cancel Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Cancel User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Signed QR Code4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Error Message2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Error Message3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Info Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Info Details2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "QR Code URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "E Invoice PDF URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "E-Invoice Generated")
        {
        }
        key(Key3; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

