table 50008 "Reminder Type"
{
    DrillDownPageID = "Reminder Types";
    LookupPageID = "Reminder Types";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Send To"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(4; "Send CC"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

