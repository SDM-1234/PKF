table 50005 "Segment Master"
{

    fields
    {
        field(1; LOB; Text[60])
        {
            TableRelation = "LOB Master";
        }
        field(2; Segment; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; LOB, Segment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

