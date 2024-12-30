tableextension 50026 tableextension50026 extends "Bank Account Ledger Entry"
{
    fields
    {
        modify(Description)
        {

            //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".

            Description = 'SANTOSH';
        }

        //Unsupported feature: Property Modification (Data type) on ""Cheque No."(Field 16501)".

        field(50003; Narration; Text[200])
        {
            CalcFormula = Lookup ("G/L Entry".Narration WHERE (Entry No.=FIELD(Entry No.)));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "G/L Entry".Narration WHERE (Entry No.=FIELD(Entry No.));
        }
        field(50004;"Payee Name";Text[100])
        {
            CalcFormula = Lookup("G/L Entry"."Payee Name" WHERE (Entry No.=FIELD(Entry No.)));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "G/L Entry"."Payee Name" WHERE (Entry No.=FIELD(Entry No.));
        }
    }
}

