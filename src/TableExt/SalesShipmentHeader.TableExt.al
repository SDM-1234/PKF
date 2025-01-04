tableextension 50001 "SalesShipmentHeader" extends "Sales Shipment Header"
{
    fields
    {
        modify("Salesperson Code")
        {
            TableRelation = "Employee LOB"."Emp No." WHERE(LOB = FIELD(LOB), Segment = FIELD(Segment));
            Description = 'Changed Lookup from Salesperson/Purchaser to "Employee LOB"';
        }
        //crs-al disable
        field(50000; "LOB"; Text[40])
        {
            TableRelation = "Segment Master";
        }
        field(50001; "Segment"; Text[100])
        {
            TableRelation = "Segment Master" WHERE(LOB = FIELD(LOB));
        }
        field(50014; "Work Order No."; Code[20])
        {
        }
        field(50020; "Remarks"; Text[250])
        {
        }
        field(50023; "Type of Invoice"; Enum "Type of Invoice")
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Invoice Types"; enum "Invoice Types")
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Team Leader"; Code[30])
        {
            TableRelation = Employee WHERE(Type = FILTER(Partner | Others));
        }
        field(50050; "Sales Currency"; enum "Sales Currency")
        {
        }
        field(50051; "Resp. Name"; Text[80])
        {
        }
        //crs-al enable
    }
}

