tableextension 50022 Vendor extends Vendor
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
        modify("Name 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Name 2"(Field 4)".

            Description = 'AD_SD';
        }
        field(50000; "Resopnsible Person"; Code[20])
        {
            Description = 'AD_SD';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF GetEmployee.GET("Resopnsible Person") THEN BEGIN
                    "Resp. Person Name" := GetEmployee."First Name";
                    "Contact No." := GetEmployee."Mobile Phone No.";
                END ELSE BEGIN
                    "Resp. Person Name" := '';
                    "Contact No." := '';
                END;
            end;
        }
        field(50001; "Resp. Person Name"; Text[80])
        {
            Description = 'AD_SD';
        }
        field(50002; "Contact No."; Code[20])
        {
            Description = 'AD_SD';
            Numeric = true;
        }
    }

    var
        GetEmployee: Record Employee;
}

