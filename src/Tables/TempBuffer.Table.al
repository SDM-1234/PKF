/// <summary>
/// Table Temp Buffer (ID 50014).
/// </summary>
table 50038 "Temp Buffer"
{
    Caption = 'Temp Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Code 1"; Code[20])
        {
            Caption = 'Code 1';
            DataClassification = CustomerContent;
        }
        field(3; "Code 2"; Code[20])
        {
            Caption = 'Code 2';
            DataClassification = CustomerContent;
        }
        field(4; "Decimal 1"; Decimal)
        {
            Caption = 'Decimal 1';
            DataClassification = CustomerContent;
        }
        field(5; "Decimal 2"; Decimal)
        {
            Caption = 'Decimal 2';
            DataClassification = CustomerContent;
        }
        field(6; "Decimal 3"; Decimal)
        {
            Caption = 'Decimal 3';
            DataClassification = CustomerContent;
        }
        field(7; "Date 1"; Date)
        {
            Caption = 'Date 1';
            DataClassification = CustomerContent;
        }
        field(8; "Boolean 1"; Boolean)
        {
            Caption = 'Boolean 1';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
