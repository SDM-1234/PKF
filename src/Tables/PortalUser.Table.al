table 50002 "Portal User"
{

    fields
    {
        field(1; "User Name"; Code[10])
        {
        }
        field(2; "Full Name"; Text[100])
        {
        }
        field(3; Password; Text[15])
        {
        }
        field(4; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(5; "Super User"; Boolean)
        {
        }
        field(10; "Partner Code"; Code[20])
        {
            TableRelation = Employee;
        }
        field(11; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
        }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    procedure VerifyLogin(UName: Code[10]; PPassword: Text[15]; var PName: Text[100]; var PEmail: Text[250]; var PPartnerCode: Code[20]; var PSuperUser: Boolean) RFound: Boolean
    begin
        SETRANGE("User Name", UName);
        SETRANGE(Password, PPassword);
        SETRANGE(State, State::Enabled);
        RFound := Rec.FINDFIRST();
        PEmail := "Contact Email";
        PName := "Full Name";
        PPartnerCode := "Partner Code";
        PSuperUser := "Super User";
    end;
}

