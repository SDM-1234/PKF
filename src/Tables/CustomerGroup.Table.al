/// <summary>
/// Table PKF-Customer Group (ID 50000).
/// </summary>
table 50000 "Customer Group"
{
    DrillDownPageId = "Customer Group";
    LookupPageId = "Customer Group";
    fields
    {
        field(1; "Group Code"; Code[20])
        {
        }
        field(2; "Customer Group"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

