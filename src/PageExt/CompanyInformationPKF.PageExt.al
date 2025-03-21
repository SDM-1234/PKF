#pragma warning disable AL0197
pageextension 50001 "CompanyInformation_PKF" extends "Company Information"
#pragma warning restore AL0197
{
    layout
    {
        addafter("Registration No.")
        {
            field("Bank Logo"; Rec."Bank Logo")
            {
                ApplicationArea = All;
            }
        }
    }
}

