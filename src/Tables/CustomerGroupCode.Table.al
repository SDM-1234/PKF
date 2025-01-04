table 50001 "Customer Group Code"
{

    fields
    {
        field(1; "Group Code"; Code[20])
        {
        }
        field(2; "Group Description"; Text[30])
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

