tableextension 50021 CustLedgerEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50002; Remarks; Text[250])
        {
            CalcFormula = Lookup("Sales Invoice Header".Remarks WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Narration; Text[200])
        {
        }
        field(50006; "Team Leader"; Code[30])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Team Leader" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Employee WHERE(Type = FILTER(Partner | Others));
        }
        field(50007; Segment; Text[100])
        {
            CalcFormula = Lookup("Sales Invoice Header".Segment WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
            TableRelation = "Segment Master" WHERE(LOB = FIELD(LOB));
        }
        field(50008; LOB; Text[40])
        {
            CalcFormula = Lookup("Sales Invoice Header".LOB WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Segment Master";
        }
        field(50009; "Invoice Types"; Enum "Invoice Types")
        {
            CalcFormula = Lookup("Sales Invoice Header"."Invoice Types" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Remarks Cr. Memo"; Text[250])
        {
            CalcFormula = Lookup("Sales Cr.Memo Header".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'Santosh';
            FieldClass = FlowField;
        }
        field(50051; "Resp. Name"; Text[80])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Resp. Name" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

