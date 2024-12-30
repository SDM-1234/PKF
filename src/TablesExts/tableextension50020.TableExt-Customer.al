tableextension 50020 tableextension50020 extends Customer
{
    fields
    {
        modify(Name)
        {

            //Unsupported feature: Property Modification (Data type) on "Name(Field 2)".

            Description = 'AD_SD';
        }
        modify("Search Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Search Name"(Field 3)".

            Description = 'AD_SD';
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Data type) on "Address(Field 5)".

            Description = 'AD_SD';
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Address 2"(Field 6)".

            Description = 'AD_SD';
        }

        //Unsupported feature: Property Deletion (CaptionML) on "Name(Field 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Search Name"(Field 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Name 2"(Field 4)".


        //Unsupported feature: Property Deletion (CaptionML) on "Address(Field 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Address 2"(Field 6)".

        field(50000; "Contact Person Mob. No."; Code[20])
        {
            Description = 'AD_SD';
            Numeric = true;
        }
        field(50001; "Alternative Mobile No."; Code[10])
        {
            Description = 'AD_SD';
            Numeric = true;
        }
        field(50002; "Customer Grp."; Code[10])
        {
            Description = 'AD_SD';
            TableRelation = "Customer Group";
        }
        field(50003; "Industry Group"; Code[10])
        {
            Description = 'AD_SD';
            TableRelation = "Industry Group";
        }
        field(50012; "Resp. Person Name"; Text[80])
        {
            Description = 'AD_SD';
        }
        field(50013; "Contact No."; Code[20])
        {
            Description = 'AD_SD';
            Numeric = true;
        }
        field(50014; Group; Code[20])
        {
            Description = 'AD_SD';
            TableRelation = "Customer Group Code";
        }
        field(50015; "Primary Incharge"; Code[30])
        {
            Description = 'AD_SD';
            TableRelation = "Primary Incharge";
        }
        field(50016; "Team Leader"; Code[20])
        {
            Description = 'AD_SD';
            TableRelation = Employee WHERE (Type = FILTER (Partner | Others));
        }
    }
}

