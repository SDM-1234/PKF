tableextension 50042 ReturnReceiptHeader extends "Return Receipt Header"
{
    fields
    {
        modify("Salesperson Code")
        {
            TableRelation = "Employee LOB"."Emp No." WHERE(LOB = FIELD(LOB), Segment = FIELD(Segment));
        }
        field(50000; LOB; Text[40])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master";
        }
        field(50001; Segment; Text[100])
        {
            Description = 'AD_SD';
            TableRelation = "Segment Master" WHERE(LOB = FIELD(LOB));
        }
        field(50014; "Work Order No."; Code[20])
        {
            Description = 'AD_SD';
        }
        field(50020; Remarks; Text[250])
        {
            Description = 'AD_SD';
        }
        field(50023; "Type of Invoice"; Enum "Type of Invoice")
        {
            Description = 'AD_SD';
        }
        field(50025; "Invoice Types"; Enum "Invoice Types")
        {
            Description = 'AD_SD';
        }
        field(50033; "Team Leader"; Code[30])
        {
            Description = 'AD_SD';
            TableRelation = Employee WHERE(Type = FILTER(Partner | Others));
        }
        field(50050; "Sales Currency"; Enum "Sales Currency")
        {
            Description = 'AD_SD';
        }
        field(50051; "Resp. Name"; Text[80])
        {
            Description = 'AD_SD';
        }
    }
}

