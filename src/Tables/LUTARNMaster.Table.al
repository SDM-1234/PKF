
table 50014 "LUT / ARN Master"
{
    Caption = 'LUT / ARN Master';
    DataClassification = CustomerContent;
    DrillDownPageId = "LUT ARN List";
    LookupPageId = "LUT/ARN Card";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(4; "ARN / LUT No."; Code[50])
        {
            Caption = 'ARN / LUT No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Location Code", "Start Date", "End Date", "ARN / LUT No.")
        {
            Clustered = true;
        }
    }
}
