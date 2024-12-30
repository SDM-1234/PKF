pageextension 50094 pageextension50094 extends "Sales Credit Memo"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address"(Control 65)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address 2"(Control 67)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 20)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address"(Control 22)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address 2"(Control 24)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address 2"(Control 36)".

        modify("Reference Invoice No.")
        {
            Visible = false;
        }
        addafter("Your Reference")
        {
            field("Reference Invoice No."; "Reference Invoice No.")
            {
            }
        }
        addafter("Assigned User ID")
        {
            field("Posting No. Series"; "Posting No. Series")
            {
            }
        }
        addafter(Status)
        {
            field(Remarks; Remarks)
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Post(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
    }
}

