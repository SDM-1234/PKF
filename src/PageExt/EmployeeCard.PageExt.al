pageextension 50113 EmployeeCard extends "Employee Card"
{
    layout
    {
        addafter("No.")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
        }
    }
}

