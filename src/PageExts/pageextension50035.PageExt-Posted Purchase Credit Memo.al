pageextension 50035 pageextension50035 extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("Order Address Code")
        {
            Visible = false;
        }
        addafter("No. Printed")
        {
            field(Remarks; Remarks)
            {
                Editable = false;
            }
        }
    }
}

