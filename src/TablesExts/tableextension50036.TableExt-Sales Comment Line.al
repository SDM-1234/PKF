tableextension 50036 tableextension50036 extends "Sales Comment Line"
{
    fields
    {
        field(50000; Type; Option)
        {
            Description = 'AD_SD';
            OptionCaption = ' ,Partner,Leader,CA1,CA2,CA3,CA4,CA5,Assistants1,Assistants2,Assistants3,Assistants4,Assistants5,Assistants6,Assistants7,Assistants8,Assistants9,Assistants10,Assistants11,Assistants12,Assistants13,Assistants14,Assistants15,Assistants16,Assistants17,Assistants18,Assistants19,Assistants20,Associate1,Associate2,Associate3,Associate4,Expense to be billed';
            OptionMembers = " ",Partner,Leader,CA1,CA2,CA3,CA4,CA5,Assistants1,Assistants2,Assistants3,Assistants4,Assistants5,Assistants6,Assistants7,Assistants8,Assistants9,Assistants10,Assistants11,Assistants12,Assistants13,Assistants14,Assistants15,Assistants16,Assistants17,Assistants18,Assistants19,Assistants20,Associate1,Associate2,Associate3,Associate4,"Expense to be billed";
        }
        field(50001; "Type Code"; Code[20])
        {
            Description = 'AD_SD';
            TableRelation = IF (Type = CONST (Partner)) "Employee LOB"."Emp No." ELSE
            IF (Type = CONST (Leader)) Employee.No. ELSE IF (Type=CONST(CA1)) Employee.No. ELSE IF (Type=CONST(CA2)) Employee.No. ELSE IF (Type=CONST(CA3)) Employee.No. ELSE IF (Type=CONST(CA4)) Employee.No. ELSE IF (Type=CONST(CA5)) Employee.No. ELSE IF (Type=CONST(Associate1)) Vendor.No. ELSE IF (Type=CONST(Associate2)) Vendor.No. ELSE IF (Type=CONST(Associate3)) Vendor.No. ELSE IF (Type=CONST(Associate4)) Vendor.No. ELSE IF (Type=CONST(Assistants1)) Employee.No. ELSE IF (Type=CONST(Assistants2)) Employee.No. ELSE IF (Type=CONST(Assistants3)) Employee.No. ELSE IF (Type=CONST(Assistants4)) Employee.No. ELSE IF (Type=CONST(Assistants5)) Employee.No. ELSE IF (Type=CONST(Assistants6)) Employee.No. ELSE IF (Type=CONST(Assistants7)) Employee.No. ELSE IF (Type=CONST(Assistants8)) Employee.No. ELSE IF (Type=CONST(Assistants9)) Employee.No. ELSE IF (Type=CONST(Assistants10)) Employee.No. ELSE IF (Type=CONST(Assistants11)) Employee.No. ELSE IF (Type=CONST(Assistants12)) Employee.No. ELSE IF (Type=CONST(Assistants13)) Employee.No. ELSE IF (Type=CONST(Assistants14)) Employee.No. ELSE IF (Type=CONST(Assistants15)) Employee.No. ELSE IF (Type=CONST(Assistants16)) Employee.No. ELSE IF (Type=CONST(Assistants17)) Employee.No. ELSE IF (Type=CONST(Assistants18)) Employee.No. ELSE IF (Type=CONST(Assistants19)) Employee.No. ELSE IF (Type=CONST(Assistants20)) Employee.No.;
        }
    }
}

