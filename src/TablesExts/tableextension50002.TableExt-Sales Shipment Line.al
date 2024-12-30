tableextension 50002 tableextension50002 extends "Sales Shipment Line"
{
    fields
    {
        modify(Description)
        {

            //Unsupported feature: Property Modification (Data type) on "Description(Field 11)".

            Description = 'AD_SD';
        }
        field(50001; "Billing Type"; Option)
        {
            Description = 'AD_SD';
            OptionCaption = ' ,Event Driven,Date Driven,Time Sheet Driven,Completion Driven';
            OptionMembers = " ","Event Driven","Date Driven","Time Sheet Driven","Completion Driven";
        }
        field(50004; Scope1; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50005; Scope2; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50006; Scope3; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50007; Scope4; Text[150])
        {
            Description = 'AD_SD';
        }
    }
}

