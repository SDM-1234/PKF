tableextension 50034 tableextension50034 extends "CV Ledger Entry Buffer"
{
    fields
    {
        modify(Description)
        {

            //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".

            Description = 'SANTOSH';
        }
        modify("Salesperson Code")
        {
            TableRelation = Employee;
            Description = 'AD_SD_Lookup was -Salesperson/Purchaser';
        }
    }
}

