tableextension 50031 tableextension50031 extends "Sales Header"
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
            TableRelation = "Employee LOB"."Emp No.";

            //Unsupported feature: Property Insertion (NotBlank) on ""Salesperson Code"(Field 43)".

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

        //Unsupported feature: Code Modification on ""Bill-to City"(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        IF NOT (("Bill-to City") IN['A'..'Z']) THEN
          ERROR('Only Alphabet is Allowed')

        */
        //end;


        //Unsupported feature: Code Insertion on ""Salesperson Code"(Field 43)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        //AD_SD
        IF (PAGE.RUNMODAL(PAGE::"Employee LOB",EmployeeLOB,EmployeeLOB.LOB) = ACTION::LookupOK) THEN
        BEGIN
          "Salesperson Code" := EmployeeLOB."Emp No.";
          "Resp. Name" := EmployeeLOB."Emp Name";
          LOB := EmployeeLOB.LOB;
          Segment := EmployeeLOB.Segment;
        END;
        //AD_SD
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to City"(Field 83).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        IF NOT (("Sell-to City") IN['A'..'Z']) THEN
          ERROR('Only Alphabet is Allowed')
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Post Code"(Field 85).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        IF NOT (("Bill-to Post Code") IN['1'..'9']) THEN
          ERROR('Only Numeric is Allowed')
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Post Code"(Field 88).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        IF NOT (("Sell-to Post Code") IN['1'..'9']) THEN
          ERROR('Only Numeric is Allowed')
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Post Code"(Field 91).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        IF NOT (("Ship-to Post Code") IN['1'..'9']) THEN
          ERROR('Only Numeric is Allowed')
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Dimension Set ID"(Field 480)".

        field(50000; LOB; Text[40])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master".LOB;
        }
        field(50001; Segment; Text[100])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master" WHERE (LOB = FIELD (LOB));
        }
        field(50002; "Take Print"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'SDMBCS';

            trigger OnValidate()
            begin
                IF "Take Print" = TRUE THEN
                    "Posting No." := "No.";
                IF "Take Print" = FALSE THEN
                    "Posting No." := '';
            end;
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
            OptionCaption = ' ,USD,EURO,GBP,AED,BDT,AUD,INR,SGD';
            OptionMembers = " ",USD,EURO,GBP,AED,BDT,AUD,INR,SGD;
        }
        field(50051; "Resp. Name"; Text[80])
        {
            Description = 'AD_SD';
        }
        field(50052; "Bank Selection For Report"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'ZOHO_1471';
            OptionCaption = ' ,ICICI,HDFC,INDIAN,ICICI2,HDFC2';
            OptionMembers = " ",ICICI,HDFC,INDIAN,ICICI2,HDFC2;
        }
    }


    //Unsupported feature: Property Modification (Id) on "PITCalcInvDiscErr(Variable 1000000000)".

    //var
    //>>>> ORIGINAL VALUE:
    //PITCalcInvDiscErr : 1000000000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PITCalcInvDiscErr : 1000000011;
    //Variable type has not been exported.

    var
        GetSegmentMaster: Record "Segment Master";
        EmployeeLOB: Record "Employee LOB";
}

