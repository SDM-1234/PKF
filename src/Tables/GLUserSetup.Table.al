table 50025 "GL User Setup"
{
    DrillDownPageID = "Segment Master";
    LookupPageID = "Segment Master";

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE("Account Type" = FILTER(Posting));

            trigger OnValidate()
            begin
                IF GLAccount.GET("G/L Account No.") THEN
                    "G/L Account Name" := GLAccount.Name
                ELSE
                    "G/L Account Name" := '';
            end;
        }
        field(3; "G/L Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "User ID", "G/L Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GLAccount: Record "G/L Account";

    [Scope('Internal')]
    procedure FilterGLAccount(): Text
    var
        GLUserSetup: Record "GL User Setup";
        GLFilter: Text;
        I: Integer;
    begin
        I := 1;
        GLUserSetup.SETRANGE("User ID", USERID);
        IF GLUserSetup.COUNT > 1000 THEN
            EXIT('');
        IF GLUserSetup.FINDSET THEN
            REPEAT
                IF I = 1 THEN
                    GLFilter += '<>' + GLUserSetup."G/L Account No."
                ELSE
                    GLFilter += '&<>' + GLUserSetup."G/L Account No.";

                I := I + 1;
            UNTIL GLUserSetup.NEXT = 0;
        EXIT(GLFilter);
    end;
}

