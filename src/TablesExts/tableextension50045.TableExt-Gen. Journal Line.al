tableextension 50045 tableextension50045 extends "Gen. Journal Line"
{
    fields
    {
        modify(Description)
        {

            //Unsupported feature: Property Modification (Data type) on "Description(Field 8)".

            Description = 'SANTOSH';
        }
        field(50003; Narration; Text[200])
        {
            Description = 'AD_SD';
        }
        field(50004; "Payee Name"; Text[90])
        {
            Description = 'AD_SD';
        }
        field(50005; "Voucher Selection"; Boolean)
        {
            Description = 'AD_SD';
        }
        field(50006; "Employee Name"; Text[50])
        {
            CalcFormula = Lookup ("Dimension Value".Name WHERE (Dimension Code=CONST(EMPLOYEE),Code=FIELD(Shortcut Dimension 1 Code)));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Name WHERE (Dimension Code=CONST(EMPLOYEE));
        }
        field(50007;"Sales Code";Code[20])
        {
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE (Dimension Set ID=FIELD(Dimension Set ID),Dimension Code=FILTER(SALES)));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=CONST(SALES));
        }
        field(50008;"Sales Name";Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE (Dimension Code=CONST(SALES),Code=FIELD(Sales Code)));
            Description = 'Santosh';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Name WHERE (Dimension Code=CONST(SALES),Code=FIELD(Sales Code));
        }
        field(50009;"Beneficiary Code";Code[10])
        {
            Description = 'Santosh';
            TableRelation = Beneficiary."Beneficiary Code" WHERE (Beneficiary Code=FIELD(Beneficiary Code));
        }
    }

    //Unsupported feature: Property Modification (Length) on "UpdateDescription(PROCEDURE 43).Name(Parameter 1000)".

}

