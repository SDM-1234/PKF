tableextension 50048 GeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {

        field(50000; "Reminder Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'SDM.REM.00.01';
            TableRelation = "No. Series";
        }
    }
}

