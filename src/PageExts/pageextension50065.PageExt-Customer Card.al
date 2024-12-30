pageextension 50065 pageextension50065 extends "Customer Card"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Name(Control 4)".


        //Unsupported feature: Property Modification (ImplicitType) on "Address(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Address 2"(Control 8)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Search Name"(Control 18)".

        modify("L.S.T. No.")
        {
            Caption = 'TAN No.';
        }
        addafter("Last Date Modified")
        {
            field("Primary Incharge"; "Primary Incharge")
            {
            }
            field(Group; Group)
            {
            }
        }
    }


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //begin
    /*
    {
    //SDM SANTOSH ON 09032019
    IF "Primary Incharge" = '' THEN
      ERROR('Primary Incharge cannot be blank. Select the Primary Incharge for %1',"No.");
    }
    */
    //end;


    //Unsupported feature: Code Insertion on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //begin
    /*
    {
    //SDM SANTOSH ON 09032019
    IF "Primary Incharge" = '' THEN
      ERROR('Primary Incharge cannot be blank. Select the Primary Incharge for %1',"No.");
    }
    */
    //end;


    //Unsupported feature: Code Insertion on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //begin
    /*
    TESTFIELD("Country/Region Code"); //ZE.RSF.524
    */
    //end;
}

