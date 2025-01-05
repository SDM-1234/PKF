pageextension 50065 CustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Primary Incharge"; Rec."Primary Incharge")
            {
                ApplicationArea = All;
            }
            field(Group; Rec.Group)
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    begin
        Rec.TESTFIELD("Country/Region Code"); //ZE.RSF.524
    end;
}

