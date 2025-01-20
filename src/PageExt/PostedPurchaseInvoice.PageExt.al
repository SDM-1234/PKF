pageextension 50034 PostedPurchaseInvoice extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Order Address Code")
        {
            Visible = false;
        }
        addafter("Responsibility Center")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}

