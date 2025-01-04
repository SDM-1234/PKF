table 50012 "Reminder Email Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Reminder No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Period Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Period End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Email Sending Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Error Text"; Text[250])
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
    }

    fieldgroups
    {
    }
}

