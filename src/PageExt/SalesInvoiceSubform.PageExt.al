pageextension 50100 SalesInvoiceSubform extends "Sales Invoice Subform"
{
    layout
    {

        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Line No.")
        {
            Visible = true;
        }
        addlast(Control1)
        {


            field(Scope1; Rec.Scope1)
            {
                ApplicationArea = All;
            }
            field(Scope2; Rec.Scope2)
            {
                ApplicationArea = All;
            }
            field(Scope3; Rec.Scope3)
            {
                ApplicationArea = All;
            }
            field(Scope4; Rec.Scope4)
            {
                ApplicationArea = All;
            }
        }
    }
}

