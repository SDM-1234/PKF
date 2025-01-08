/// <summary>
/// PageExtension PurchaseOrderSubform (ID 50119) extends Record Purchase Order Subform.
/// </summary>
pageextension 50119 PurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Custom Duty Amount")
        {
            Visible = false;
        }
        modify("GST Assessable Value")
        {
            Visible = false;
        }
        modify("GST Group Type")
        {
            Visible = false;
        }
        modify(Exempted)
        {
            Visible = false;
        }
        // modify("GST Base Amount")
        // {
        //     Visible = false;
        // }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }

    }
}

