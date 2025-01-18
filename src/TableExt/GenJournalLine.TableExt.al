tableextension 50045 GenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(50003; Narration; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Payee Name"; Text[90])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Voucher Selection"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50006; "Employee Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('EMPLOYEE'), Code = FIELD("Shortcut Dimension 1 Code")));
            Editable = false;
            TableRelation = "Dimension Value".Name WHERE("Dimension Code" = CONST('EMPLOYEE'));
        }
        field(50007; "Sales Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Set ID" = FIELD("Dimension Set ID"), "Dimension Code" = FILTER('SALES')));
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SALES'));
        }
        field(50008; "Sales Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('SALES'), Code = FIELD("Sales Code")));
            Editable = false;
            TableRelation = "Dimension Value".Name WHERE("Dimension Code" = CONST('SALES'), Code = FIELD("Sales Code"));
        }
        field(50009; "Beneficiary Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Beneficiary."Beneficiary Code" WHERE("Beneficiary Code" = FIELD("Beneficiary Code"));
        }
    }
}

