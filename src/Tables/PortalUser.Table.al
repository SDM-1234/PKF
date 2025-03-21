table 50002 "Portal User"
{

    fields
    {
        field(1; "User Name"; Code[10])
        {
            ToolTip = 'Specifies the value of the User Name field.';
        }
        field(2; "Full Name"; Text[100])
        {
            ToolTip = 'Specifies the value of the Full Name field.';
        }
        field(3; Password; Text[15])
        {
            ToolTip = 'Specifies the value of the Password field.';
        }
        field(4; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
            ToolTip = 'Specifies the value of the State field.';
        }
        field(5; "Super User"; Boolean)
        {
            ToolTip = 'Specifies the value of the Super User field.';
        }
        field(10; "Partner Code"; Code[20])
        {
            TableRelation = Employee;
            ToolTip = 'Specifies the value of the Partner Code field.';
        }
        field(11; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
            ToolTip = 'Specifies the value of the Contact Email field.';
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

