table 50004 "LOB Master"
{

    fields
    {
        field(1; LOB; Text[60])
        {
            ToolTip = 'Line of Business';
        }
    }

    keys
    {
        key(Key1; LOB)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

