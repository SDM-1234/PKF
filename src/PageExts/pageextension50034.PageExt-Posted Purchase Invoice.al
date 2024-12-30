pageextension 50034 pageextension50034 extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Order Address Code")
        {
            Visible = false;
        }
        addafter("Responsibility Center")
        {
            field(Remarks; Remarks)
            {
                Editable = false;
            }
        }
    }
}

