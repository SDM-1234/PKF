pageextension 50076 pageextension50076 extends "Recurring General Journal"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 16)".

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
        addafter("Bank Payment Type")
        {
            field("Cheque No."; "Cheque No.")
            {
            }
            field("Cheque Date"; "Cheque Date")
            {
            }
        }
        addafter("Expiration Date")
        {
            field(Narration; Narration)
            {
            }
        }
        addafter(Control3)
        {
            field("Service Tax Group Code"; "Service Tax Group Code")
            {
            }
            field("Service Tax Registration No."; "Service Tax Registration No.")
            {
            }
            field("Bal. Account Type"; "Bal. Account Type")
            {
            }
            field("Bal. Account No."; "Bal. Account No.")
            {
            }
            field("External Document No."; "External Document No.")
            {
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("<Action1000000006>")
            {
                Caption = 'Indian Bank Cheque';
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
            action("<Action1000000005>")
            {
                Caption = 'Bank Payment Voucher';
                Image = Print;
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
            action("<Action1000000001>")
            {
                Caption = 'Indian Bank - Multiple Line Printing';
                Image = Print;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJnlLine3: Record "Gen. Journal Line";
                begin
                    GenJnlLine3.RESET;
                    GenJnlLine3.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine3.SETRANGE("Document No.", "Document No.");
                    REPORT.RUNMODAL(50077, TRUE, FALSE, GenJnlLine3);
                end;
            }
            action("Print RTGS Report")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
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
            action(ApplyEntries)
            {
                Caption = 'ApplyEntries';
                Ellipsis = true;
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Gen. Jnl.-Apply";
                ShortCutKey = 'Shift+F11';
            }
        }
    }
}

