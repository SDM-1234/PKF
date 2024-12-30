pageextension 50158 pageextension50158 extends "Sales Quote Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".

        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("GST Group Code")
        {
            Visible = true;
        }
        modify("Total GST Amount")
        {
            Visible = true;
        }
        modify("HSN/SAC Code")
        {
            Visible = true;
        }
        addafter("Appl.-to Item Entry")
        {
            field(Scope1; Scope1)
            {
            }
            field(Scope2; Scope2)
            {
            }
            field(Scope3; Scope3)
            {
            }
            field(Scope4; Scope4)
            {
            }
        }
    }
}

