tableextension 50042 tableextension50042 extends "Return Receipt Header"
{
    fields
    {
        modify("Bill-to Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Bill-to Name"(Field 5)".

            Description = 'AD_SD';
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Data type) on ""Bill-to Address"(Field 7)".

            Description = 'AD_SD';
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Bill-to Address 2"(Field 8)".

            Description = 'AD_SD';
        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Ship-to Name"(Field 13)".

            Description = 'AD_SD';
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Data type) on ""Ship-to Address"(Field 15)".

            Description = 'AD_SD';
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Ship-to Address 2"(Field 16)".

            Description = 'AD_SD';
        }
        modify("Salesperson Code")
        {
            TableRelation = "Employee LOB"."Emp No." WHERE (LOB = FIELD (LOB), Segment = FIELD (Segment));
            Description = 'AD Changed Lookup from Salesperson/Purchaser to "Employee LOB"';
        }
        modify("Sell-to Customer Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Sell-to Customer Name"(Field 79)".

            Description = 'AD_SD';
        }
        modify("Sell-to Address")
        {

            //Unsupported feature: Property Modification (Data type) on ""Sell-to Address"(Field 81)".

            Description = 'AD_SD';
        }
        modify("Sell-to Address 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Sell-to Address 2"(Field 82)".

            Description = 'AD_SD';
        }
        field(50000; LOB; Text[40])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master";
        }
        field(50001; Segment; Text[100])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master" WHERE (LOB = FIELD (LOB));
        }
        field(50014; "Work Order No."; Code[20])
        {
            Description = 'AD_SD';
        }
        field(50020; Remarks; Text[250])
        {
            Description = 'AD_SD';
        }
        field(50023; "Type of Invoice"; Option)
        {
            Description = 'AD_SD';
            OptionCaption = ' ,Settlement';
            OptionMembers = " ",Settlement;
        }
        field(50025; "Invoice Types"; Option)
        {
            Description = 'AD_SD';
            OptionCaption = ' ,Fees,Expenses';
            OptionMembers = " ",Fees,Expenses;
        }
        field(50033; "Team Leader"; Code[30])
        {
            Description = 'AD_SD';
            TableRelation = Employee WHERE (Type = FILTER (Partner | Others));
        }
        field(50050; "Sales Currency"; Option)
        {
            Description = 'AD_SD';
            OptionCaption = ' ,USD,EURO,GBP,AED,BDT,AUD';
            OptionMembers = " ",USD,EURO,GBP,AED,BDT,AUD;
        }
        field(50051; "Resp. Name"; Text[80])
        {
            Description = 'AD_SD';
        }
    }
}

