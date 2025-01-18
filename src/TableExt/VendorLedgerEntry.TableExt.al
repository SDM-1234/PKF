/// <summary>
/// TableExtension VendorLedgerEntry (ID 50024) extends Record Vendor Ledger Entry.
/// </summary>
tableextension 50024 VendorLedgerEntry extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; Remarks; Text[150])
        {
            CalcFormula = Lookup("Purch. Inv. Header".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Remarks Cr. Memo"; Text[150])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr.".Remarks WHERE("No." = FIELD("Document No.")));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "TDS NOD"; Code[10])
        {
            //CalcFormula = Lookup("TDS Entry"."TDS Nature of Deduction" WHERE("Document No." = FIELD("Document No.")));
            Description = 'Santosh';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(50003; "TDS Amount"; Decimal)
        {
            CalcFormula = Sum("TDS Entry"."TDS Amount" WHERE("Document No." = FIELD("Document No.")));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "TDS Account Amount"; Decimal)
        {
            CalcFormula = - Sum("G/L Entry".Amount WHERE("Document No." = FIELD("Document No."), "G/L Account Name" = FILTER('*TDS*')));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; Narration; Text[200])
        {
        }

    }
}

