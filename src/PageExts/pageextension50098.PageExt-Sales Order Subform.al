pageextension 50098 pageextension50098 extends "Sales Order Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".

        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
            }
        }
    }
}

