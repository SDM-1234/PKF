tableextension 50034 CVLedgerEntryBuffer extends "CV Ledger Entry Buffer"
{
    fields
    {
        modify("Salesperson Code")
        {
            TableRelation = Employee;
        }
    }
}

