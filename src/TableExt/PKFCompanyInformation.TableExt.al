//crs-al disable
tableextension 50044 "PKFCompanyInformation" extends "Company Information"
//crs-al enable
{
    fields
    {
        field(50000; "Bank Logo"; Blob)
        {
            Caption = 'Bank Logo';
            ToolTip = 'Specifies the value of the Bank Logo field.', Comment = '%';
        }
    }
}

