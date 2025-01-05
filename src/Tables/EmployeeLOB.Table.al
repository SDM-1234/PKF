/// <summary>
/// Table Employee LOB (ID 50006).
/// </summary>
table 50006 "Employee LOB"
{
    DrillDownPageID = "Employee LOB";
    LookupPageID = "Employee LOB";

    fields
    {
        field(1; LOB; Text[60])
        {
            TableRelation = "Segment Master".LOB;
        }
        field(2; Segment; Text[99])
        {
            TableRelation = "Segment Master".Segment WHERE(LOB = FIELD(LOB));
        }
        field(3; "Emp No."; Code[20])
        {
            TableRelation = Employee;
        }
        field(4; "Emp Name"; Text[30])
        {
        }
        field(5; "Contact No."; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; LOB, Segment, "Emp No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

