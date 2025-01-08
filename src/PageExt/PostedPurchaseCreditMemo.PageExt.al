pageextension 50035 PostedPurchaseCreditMemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("Order Address Code")
        {
            Visible = false;
        }
        addafter("No. Printed")
        {
            field(Remarks; Rec.Remarks)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

