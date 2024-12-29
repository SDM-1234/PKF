table 50007 Beneficiary
{

    fields
    {
        field(1; "Beneficiary Code"; Code[10])
        {
        }
        field(2; "Beneficiary Name"; Text[60])
        {
        }
        field(3; "Beneficiary A/C No."; Code[21])
        {
        }
        field(4; "Beneficiary Bank Name"; Text[60])
        {
        }
        field(5; "Beneficiary IFS Code"; Code[11])
        {
        }
        field(6; "Beneficiary Branch Address"; Text[60])
        {
        }
    }

    keys
    {
        key(Key1; "Beneficiary Code")
        {
            Clustered = true;
        }
        key(Key2; "Beneficiary Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Beneficiary Code", "Beneficiary Name", "Beneficiary A/C No.", "Beneficiary Bank Name", "Beneficiary IFS Code", "Beneficiary Branch Address")
        {
        }
    }
}

