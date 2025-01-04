table 50003 "Primary Incharge"
{

    fields
    {
        field(1; "Incharge Code"; Code[50])
        {
        }
        field(2; "Incharge Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Incharge Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

