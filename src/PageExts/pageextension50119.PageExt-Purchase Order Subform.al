pageextension 50119 pageextension50119 extends "Purchase Order Subform"
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
        modify("GST Base Amount")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
            }
        }
    }
}

