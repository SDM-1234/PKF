table 50015 "Payment Posting Buffer"
{
    Caption = 'Payment Posting Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Serial No."; Integer)
        {
            Caption = 'Serial No.';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; Loc; Code[10])
        {
            Caption = 'Loc';
        }
        field(5; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(6; FROM; Text[100])
        {
            Caption = 'FROM';
        }
        field(7; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
        }
        field(8; "Check No."; Code[20])
        {
            Caption = 'Check No.';
        }
        field(9; Reference; Text[2048])
        {
            Caption = 'Reference';
        }
        field(10; "Invoice Type"; code[20])
        {
            Caption = 'Invoice Type';
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(12; "GST Amount"; Decimal)
        {
            Caption = 'GST Amount';
        }
        field(13; "Bank Charges"; Decimal)
        {
            Caption = 'Bank Charges';
        }
        field(14; "Exchange loss"; Decimal)
        {
            Caption = 'Exchange loss';
        }
        field(15; Total; Decimal)
        {
            Caption = 'Total';
        }
        field(16; TDS; Decimal)
        {
            Caption = 'TDS';
        }
        field(17; "GR. Fees"; Decimal)
        {
            Caption = 'GR. Fees';
        }
        field(18; RE; Decimal)
        {
            Caption = 'RE';
        }
        field(19; "ST %"; Decimal)
        {
            Caption = 'ST %';
        }
        field(20; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
        }
        field(21; "Doc. Ref"; Text[50])
        {
            Caption = 'Doc. Ref';
        }
        field(22; Remarks; Text[2048])
        {
            Caption = 'Remarks';
        }
        field(23; "Employee Code"; Code[10])
        {
            Caption = 'Employee Code';
        }
        field(24; "Remaining amount"; Decimal)
        {
            Caption = 'Remaining amount';
        }
        field(25; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
        }
        field(26; "Error"; Boolean)
        {
            Caption = 'Error';
        }
        field(27; "Error Description"; Text[2048])
        {
            Caption = 'Error Description';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Serial No.")
        {
            Clustered = false;
        }
    }
}
