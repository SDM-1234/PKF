pageextension 50114 EmployeeList extends "Employee List"
{
    layout
    {
        addafter("Last Name")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
        }
    }
}

