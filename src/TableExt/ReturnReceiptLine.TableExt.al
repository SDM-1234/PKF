tableextension 50043 ReturnReceiptLine extends "Return Receipt Line"
{
    fields
    {
        field(50001; "Billing Type"; Enum "Billing Type")
        {
            Description = 'AD_SD';
        }
        field(50004; Scope1; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50005; Scope2; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50006; Scope3; Text[150])
        {
            Description = 'AD_SD';
        }
        field(50007; Scope4; Text[150])
        {
            Description = 'AD_SD';
        }
    }
}

