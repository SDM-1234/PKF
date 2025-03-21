/// <summary>
/// TableExtension GLEntry (ID 50018) extends Record G/L Entry.
/// </summary>
tableextension 50018 GLEntry extends "G/L Entry"
{
    fields
    {
        field(50000; "TDS NOD"; Code[20])
        {
            CalcFormula = Lookup("TDS Entry".Section WHERE("Document No." = FIELD("Document No.")));
            Description = 'Santsoh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "TDS Amount"; Decimal)
        {
            CalcFormula = sum("TDS Entry"."TDS Amount" WHERE("Document No." = FIELD("Document No.")));
            Description = 'Santsoh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Remarks Sales Invoice"; Text[250])
        {
            CalcFormula = Lookup("Sales Invoice Header".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Narration; Text[200])
        {
            Description = 'AD_SD';
            ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
        }
        field(50004; "Payee Name"; Text[100])
        {
            Description = 'AD_SD';
            ToolTip = 'Specifies the value of the Payee Name field.', Comment = '%';
        }
        field(50005; "TDS Account Amount"; Decimal)
        {
            CalcFormula = - Sum("G/L Entry".Amount WHERE("Document No." = FIELD("Document No."), "G/L Account Name" = FILTER('*TDS*')));
            Description = 'Santsoh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Team Leader"; Code[30])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Team Leader" WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Employee WHERE(Type = FILTER('Partner|Others'));
        }
        field(50007; Segment; Text[100])
        {
            CalcFormula = Lookup("Sales Invoice Header".Segment WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            FieldClass = FlowField;
            TableRelation = "Segment Master" WHERE(LOB = FIELD(LOB));
        }
        field(50008; LOB; Text[40])
        {
            CalcFormula = Lookup("Sales Invoice Header".LOB WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Segment Master";
        }
        field(50009; "Invoice Types"; enum "Invoice Types")
        {
            CalcFormula = lookup("Sales Invoice Header"."Invoice Types" WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Employee Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code")));
            Description = 'Santosh';
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code"));
            ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
        }
        field(50011; "Sales Code"; Code[20])
        {
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Set ID" = FIELD("Dimension Set ID"), "Dimension Code" = FILTER('SALES')));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SALES'));
        }
        field(50012; "Sales Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('SALES'), Code = FIELD("Sales Code")));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Name WHERE("Dimension Code" = CONST('SALES'), Code = FIELD("Sales Code"));
        }
        field(50013; "Source Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Source No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = IF ("Source Type" = FILTER(Vendor)) Vendor.Name WHERE("No." = FIELD("Source No."));
        }
        field(50014; "Remarks Sales Cr. Memo"; Text[250])
        {
            CalcFormula = Lookup("Sales Cr.Memo Header".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Remarks Purch. Invoice"; Text[150])
        {
            CalcFormula = Lookup("Purch. Inv. Header".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Remarks Purch. Cr. Memo"; Text[150])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr.".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "PAN No."; Code[20]) //RSF
        {
            CalcFormula = Lookup(Vendor."P.A.N. No." WHERE("No." = FIELD("Source No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = IF ("Source Type" = FILTER(Vendor)) Vendor."P.A.N. No." WHERE("No." = FIELD("Source No."));
        }
        field(50018; "Beneficiary Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'santosh';
            Editable = false;
        }
        field(50019; "Beneficiary Name"; Text[60])
        {
            CalcFormula = Lookup(Beneficiary."Beneficiary Name" WHERE("Beneficiary Code" = FIELD("Beneficiary Code")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Beneficiary."Beneficiary Name" WHERE("Beneficiary Code" = FIELD("Beneficiary Code"));
            ToolTip = 'Specifies the value of the Beneficiary Name field.', Comment = '%';
        }
        field(50020; "Source Customer Name"; Text[130])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Source No.")));
            Description = 'santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = IF ("Source Type" = FILTER(Customer)) Customer.Name WHERE("No." = FIELD("Source No."));
        }
        field(50051; "Resp. Name"; Text[80])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Resp. Name" WHERE("No." = FIELD("Document No.")));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'SDM.DEC';
        }
    }
    keys
    {
    }

    trigger OnInsert()
    begin
        "Creation Date" := WORKDATE();
    end;
}

