tableextension 50031 SalesHeader extends "Sales Header"
{
    fields
    {
        modify("Salesperson Code")
        {
            TableRelation = "Employee LOB"."Emp No.";
            Description = 'Changed Lookup from Salesperson/Purchaser to "Employee LOB"';
        }
        modify("Bill-to City")
        {
            trigger OnAfterValidate()
            begin
                IF NOT (("Bill-to City") IN ['A' .. 'Z']) THEN
                    ERROR('Only Alphabet is Allowed')
            end;
        }
        modify("Sell-to City")
        {
            trigger OnAfterValidate()
            begin
                IF NOT (("Bill-to City") IN ['A' .. 'Z']) THEN
                    ERROR('Only Alphabet is Allowed')
            end;
        }
        modify("Bill-to Post Code")
        {
            trigger OnAfterValidate()
            begin
                IF NOT (("Ship-to Post Code") IN ['1' .. '9']) THEN
                    ERROR('Only Numeric is Allowed');
            end;
        }
        modify("Sell-to Post Code")
        {
            trigger OnAfterValidate()
            begin
                IF NOT (("Ship-to Post Code") IN ['1' .. '9']) THEN
                    ERROR('Only Numeric is Allowed');
            end;
        }
        modify("Ship-to Post Code")
        {
            trigger OnAfterValidate()
            begin
                IF NOT (("Ship-to Post Code") IN ['1' .. '9']) THEN
                    ERROR('Only Numeric is Allowed');
            end;
        }
        field(50000; LOB; Text[60])
        {
            TableRelation = "Segment Master".LOB;
        }
        field(50001; Segment; Text[100])
        {
            TableRelation = "Segment Master" WHERE(LOB = FIELD(LOB));
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
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50023; "Type of Invoice"; Enum "Type of Invoice")
        {
        }
        field(50025; "Invoice Types"; ENum "Invoice Types")
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
        }
        field(50052; "Bank Selection For Report"; enum "Bank Selection For Report")
        {
        }
    }
}

