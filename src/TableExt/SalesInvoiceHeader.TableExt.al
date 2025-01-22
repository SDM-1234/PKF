tableextension 50003 SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        modify("Salesperson Code")
        {
            Description = 'Changed Lookup from Salesperson/Purchaser to "Employee LOB"';
            TableRelation = "Employee LOB"."Emp No." WHERE(LOB = FIELD(LOB), Segment = FIELD(Segment));
        }
        field(50000; LOB; Text[40])
        {
            TableRelation = "Segment Master".LOB;
        }
        field(50001; Segment; Text[100])
        {
            TableRelation = "Segment Master".Segment WHERE(LOB = FIELD(LOB));
        }
        field(50014; "Work Order No."; Code[20])
        {
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50023; "Type of Invoice"; Enum "Type of Invoice")
        {
        }
        field(50025; "Invoice Types"; Enum "Invoice Types")
        {
        }
        field(50033; "Team Leader"; Code[30])
        {
            TableRelation = Employee WHERE(Type = FILTER(Partner | Others));
        }
        field(50050; "Sales Currency"; Enum "Sales Currency")
        {
        }
        field(50051; "Resp. Name"; Text[80])
        {
            Description = 'AD_SD';
        }
        field(50052; "Bank Selection For Report"; enum "Bank Selection For Report")
        {
        }
    }
}