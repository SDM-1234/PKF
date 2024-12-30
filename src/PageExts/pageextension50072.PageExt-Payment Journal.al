pageextension 50072 pageextension50072 extends "Payment Journal"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 12)".

        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[3]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[5]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = true;
        }
        addafter("Document No.")
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; "Payee Name")
            {
            }
            field("Beneficiary Code"; "Beneficiary Code")
            {
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Employee Name"; "Employee Name")
            {
            }
        }
        addafter("ShortcutDimCode[3]")
        {
            field("Sales Name"; "Sales Name")
            {
            }
        }
        addafter("Has Payment Export Error")
        {
            field(Narration; Narration)
            {
            }
            field("Cheque Date"; "Cheque Date")
            {
            }
            field("Cheque No."; "Cheque No.")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Post(Action 46).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //SDM.RSF.01
        IF FINDFIRST THEN REPEAT
          IF "Account Type"="Account Type"::Customer THEN
            TESTFIELD("Salespers./Purch. Code")
        UNTIL NEXT=0;
        //SDM.RSF.01
        #1..3
        */
        //end;
        addafter(PreviewCheck)
        {
            action("Print RTGS Report")
            {
                Caption = 'Print RTGS Report';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RTGSReport: Report "RTGS Report";
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    /*
                    GenJnlLine.RESET;
                    //GenJnlLine.COPY(Rec);
                    GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
                    GenJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
                    GenJnlLine.SETRANGE("Document No.","Document No.");
                    REPORT.RUNMODAL(50100,TRUE,FALSE,GenJnlLine);
                    */
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50020, TRUE, FALSE, GenJournalLine);

                end;
            }
        }
        addafter("Void Check")
        {
            action("Print Deposit Challan")
            {
                Caption = 'Print Deposit Challan';
                Image = Payment;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50022, TRUE, FALSE, GenJournalLine);
                end;
            }
        }
        addafter("Void &All Checks")
        {
            action("Indian Bank Cheque")
            {
                Caption = 'Indian Bank Cheque';
                Ellipsis = false;
                Image = Print;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJnlL: Record "Gen. Journal Line";
                begin
                    GenJnlL.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50065, TRUE, FALSE, GenJnlL);
                end;
            }
        }
        addafter(CreditTransferRegisters)
        {
            action("Bank Payment Voucher")
            {
                Caption = 'Bank Payment Voucher';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50080, TRUE, FALSE, GenJournalLine);
                end;
            }
        }
        addafter(PositivePayExport)
        {
            action("Indian Bank - Multiple Line Printing")
            {
                Caption = 'Indian Bank - Multiple Line Printing';
                Image = Print;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GenJnlLine3.RESET;
                    GenJnlLine3.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine3.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50077, TRUE, FALSE, GenJnlLine3);
                end;
            }
        }
    }

    var
        GenJnlLine3: Record "Gen. Journal Line";
}

