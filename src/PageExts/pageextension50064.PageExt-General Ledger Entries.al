pageextension 50064 pageextension50064 extends "General Ledger Entries"
{

    //Unsupported feature: Property Modification (PageType) on ""General Ledger Entries"(Page 20)".


    //Unsupported feature: Property Insertion (ShowFilter) on ""General Ledger Entries"(Page 20)".

    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 10)".

        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
        addfirst(Control1)
        {
            field("Creation Date"; "Creation Date")
            {
            }
        }
        addafter("Document No.")
        {
            field("External Document No."; "External Document No.")
            {
            }
            field("Document Date"; "Document Date")
            {
            }
            field("Dimension Set ID"; "Dimension Set ID")
            {
                Visible = false;
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Employee Name"; "Employee Name")
            {
            }
            field("Sales Code"; "Sales Code")
            {
                Visible = true;
            }
            field("Sales Name"; "Sales Name")
            {
            }
        }
        addafter(Quantity)
        {
            field("Debit Amount"; "Debit Amount")
            {
            }
            field("Credit Amount"; "Credit Amount")
            {
            }
        }
        addafter(Amount)
        {
            field("Source Type"; "Source Type")
            {
            }
            field("Source No."; "Source No.")
            {
            }
            field("Source Vendor Name"; "Source Vendor Name")
            {
            }
            field("Source Customer Name"; "Source Customer Name")
            {
            }
            field("PAN No."; "PAN No.")
            {
            }
            field("TDS NOD"; "TDS NOD")
            {
            }
            field("TDS Amount"; "TDS Amount")
            {
            }
            field("TDS Account Amount"; "TDS Account Amount")
            {
            }
        }
        addafter("Entry No.")
        {
            field(Control1000000000; Narration)
            {
            }
            field("Payee Name"; "Payee Name")
            {
            }
            field("Beneficiary Code"; "Beneficiary Code")
            {
            }
            field("Beneficiary Name"; "Beneficiary Name")
            {
            }
            field("Remarks Sales Invoice"; "Remarks Sales Invoice")
            {
            }
            field("Remarks Sales Cr. Memo"; "Remarks Sales Cr. Memo")
            {
            }
            field("Remarks Purch. Invoice"; "Remarks Purch. Invoice")
            {
            }
            field("Remarks Purch. Cr. Memo"; "Remarks Purch. Cr. Memo")
            {
            }
        }
    }
    actions
    {
        modify(ReverseTransaction)
        {
            ShortCutKey = 'F11';
        }


        //Unsupported feature: Code Modification on ""&Navigate"(Action 24).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Navigate.SetDoc("Posting Date","Document No.");
        Navigate.RUN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Navigate.SetDoc("Posting Date","Document No.");
        Navigate.RUN;

        GLFilterSingleInstance.SetGLFilter(TRUE,"Posting Date","Document No."); //SDM.RSF.281024
        */
        //end;
        addafter("Print Voucher")
        {
            action(Action1006)
            {
                Caption = 'RTGS Print Out';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJournalLine: Record "G/L Entry";
                begin
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50021, TRUE, FALSE, GenJournalLine);
                end;
            }
        }
    }

    var
        VarEmpName: Text[50];
        DSE: Record "Dimension Set Entry";
        DIMVAL: Record "Dimension Value";
        GLFilterSingleInstance: Codeunit "GL Filter Single Instance";
        GLUserSetup: Record "GL User Setup";
        GLNos: Boolean;
        DocNoVar: Code[20];
        PostingDateVar: Date;


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //SDM.RSF.281024

        FILTERGROUP(2);
        IF NOT  GLNos THEN BEGIN
          SETFILTER("G/L Account No.",GLUserSetup.FilterGLAccount)
        END ELSE BEGIN
          SETRANGE("Document No.",DocNoVar);
          SETRANGE("Posting Date",PostingDateVar);
        END;
        FILTERGROUP(0);
        //SDM.RSF.281024
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //SDM.RSF.281024
        GLNos := GLFilterSingleInstance.GetGLFilter;
        PostingDateVar := GLFilterSingleInstance.GetPostingDate;
        DocNoVar := GLFilterSingleInstance.GetDocNo;

        FILTERGROUP(2);
        IF NOT  GLNos THEN BEGIN
          SETFILTER("G/L Account No.",GLUserSetup.FilterGLAccount)
        END ELSE BEGIN
          SETRANGE("Document No.",DocNoVar);
          SETRANGE("Posting Date",PostingDateVar);
        END;
        FILTERGROUP(0);
        //SDM.RSF.281024
        */
        //end;
}

