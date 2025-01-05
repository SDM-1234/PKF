tableextension 50020 Customer extends Customer
{
    fields
    {
        field(50000; "Contact Person Mob. No."; Code[20])
        {
            Numeric = true;
        }
        field(50001; "Alternative Mobile No."; Code[10])
        {
            Numeric = true;
        }
        field(50002; "Customer Grp."; Code[10])
        {
            TableRelation = "Customer Group";
        }
        field(50003; "Industry Group"; Code[10])
        {
            TableRelation = "Industry Group";
        }
        field(50012; "Resp. Person Name"; Text[80])
        {
        }
        field(50013; "Contact No."; Code[20])
        {
            Numeric = true;
        }
        field(50014; Group; Code[20])
        {
            TableRelation = "Customer Group Code";
        }
        field(50015; "Primary Incharge"; Code[30])
        {
            TableRelation = "Primary Incharge";
        }
        field(50016; "Team Leader"; Code[20])
        {
            TableRelation = Employee WHERE(Type = FILTER(Partner | Others));
        }
    }
}

