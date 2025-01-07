pageextension 50094 SalesCreditMemo extends "Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
    }
}

