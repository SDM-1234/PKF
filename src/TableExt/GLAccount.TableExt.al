tableextension 50012 GLAccount extends "G/L Account"
{
    fields
    {
        field(50000; NetChange; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(FILTER(Totaling)), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Posting Date" = FIELD("Date Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Code")));
            Description = 'SDM';
            FieldClass = FlowField;

        }
        field(50002; "Normal User Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50003; "Super User Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50004; "Opening Control Account"; Boolean)
        {
            Description = 'SDM';
        }
        field(50005; "BLR Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50006; "HYD Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50007; "AUDIT Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50008; "DEL Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50009; "MUM Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50010; "CHN FO Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50011; "Invoice Hide"; Boolean)
        {
            Description = 'SDM';
        }
        field(50012; "RTGS Deb. Amt. Control"; Boolean)
        {
            Description = 'SDM';
        }
        field(50013; "RTGS Cre. Amt. Control"; Boolean)
        {
            Description = 'SDM';
        }
        field(50014; "Payroll + Normal User Hide"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'SDM';
        }
        field(50015; "Recievable Hide"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'SDM';
        }
        field(50016; "Payroll Hide"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'SDM';
        }
        field(50017; "RSF View"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'SDM';
        }
    }
}

