table 50038 "Temp Buffer"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Code 1"; Code[50])
        {
        }
        field(3; "Code 2"; Code[50])
        {
        }
        field(4; "Decimal 1"; Decimal)
        {
        }
        field(5; "Decimal 2"; Decimal)
        {
        }
        field(6; "Decimal 3"; Decimal)
        {
        }
        field(7; "Date 1"; Date)
        {
        }
        field(8; "Boolean 1"; Boolean)
        {
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

