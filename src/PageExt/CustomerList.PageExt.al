pageextension 50066 CustomerList extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Registration Number"; Rec."Registration Number")
            {
                ApplicationArea = All;
                Caption = 'TAN No.';
                ToolTip = 'Specifies the registration number of the customer. You can enter a maximum of 20 characters, both numbers and letters.';
            }
        }
        addafter("Post Code")
        {
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Phone No.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

