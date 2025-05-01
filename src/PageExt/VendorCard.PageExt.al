/// <summary>
/// PageExtension VendorCard (ID 50073) extends Record Vendor Card.
/// </summary>
pageextension 50073 VendorCard extends "Vendor Card"
{

    layout
    {

    }
    actions
    {

        addlast("Ven&dor")
        {
            action(DeleteReverse)
            {
                ApplicationArea = All;

                Caption = 'Delete Reverse';
                trigger OnAction()
                var
                    RevEntry: Record "Reversal Entry";
                begin
                    RevEntry.SetRange("Line No.", 1);
                    RevEntry.Delete();
                end;
            }
        }

    }
}