tableextension 50021 tableextension50021 extends "Cust. Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".


        //Unsupported feature: Property Modification (Editable) on ""Location GST Reg. No."(Field 16614)".

        field(50002; Remarks; Text[250])
        {
            CalcFormula = Lookup ("Sales Invoice Header".Remarks WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003;Narration;Text[150])
        {
            Description = 'AD_SD';
        }
        field(50006;"Team Leader";Code[30])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Team Leader" WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Employee WHERE (Type=FILTER(Partner|Others));
        }
        field(50007;Segment;Text[100])
        {
            CalcFormula = Lookup("Sales Invoice Header".Segment WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            FieldClass = FlowField;
            TableRelation = "Segment Master" WHERE (LOB=FIELD(LOB));
        }
        field(50008;LOB;Text[40])
        {
            CalcFormula = Lookup("Sales Invoice Header".LOB WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Segment Master";
        }
        field(50009;"Invoice Types";Option)
        {
            CalcFormula = Lookup("Sales Invoice Header"."Invoice Types" WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Fees,Expenses';
            OptionMembers = " ",Fees,Expenses;
        }
        field(50010;"Remarks Cr. Memo";Text[250])
        {
            CalcFormula = Lookup("Sales Cr.Memo Header".Remarks WHERE (No.=FIELD(Document No.)));
            Description = 'Santosh';
            FieldClass = FlowField;
        }
        field(50051;"Resp. Name";Text[80])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Resp. Name" WHERE (No.=FIELD(Document No.)));
            Description = 'AD_SD';
            Editable = false;
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Customer No." := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        #4..85
            END;
        END;
        "GST Customer Type" := GenJnlLine."GST Customer Type";
        "Location GST Reg. No." := GenJnlLine."Location GST Reg. No.";
        OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..88
        Narration := GenJnlLine.Narration;//AD_SD
        "Location GST Reg. No." := GenJnlLine."Location GST Reg. No.";
        OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;
}

