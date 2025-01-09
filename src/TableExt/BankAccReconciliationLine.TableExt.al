tableextension 50027 BankAccReconciliationLine extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "External Document No."; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Bank Account Ledger Entry"."External Document No." WHERE("Bank Account No." = FIELD("Bank Account No."), "Document No." = FIELD("Document No.")));
            TableRelation = "Bank Account Ledger Entry"."External Document No." WHERE("Bank Account No." = FIELD("Bank Account No."), "Document No." = FIELD("Document No."));
        }
    }
}

