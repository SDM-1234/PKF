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
        field(60000; "Payment Posting Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Posting Template"));
        }
        field(60001; "Payment Posting Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(60002; "Payment Posting TDS Acc"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Posting TDS Account';
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
        field(60003; "Payment Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Posting Type';
            OptionMembers = "Create Journal","Create & Post Journal";
        }
        field(60004; "Round Off Account"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Round Off Account';
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
        field(60005; "Round off Variance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Round off Variance';
        }
    }
}

