pageextension 50076 RecurringGeneralJournal extends "Recurring General Journal"
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
        modify(ShortcutDimCode3)
        {
            Visible = true;
        }
        modify(ShortcutDimCode4)
        {
            Visible = true;
        }
        modify(ShortcutDimCode5)
        {
            Visible = true;
        }
        modify(ShortcutDimCode6)
        {
            Visible = true;
        }
        modify(ShortcutDimCode7)
        {
            Visible = true;
        }
        modify(ShortcutDimCode8)
        {
            Visible = true;
        }
        addafter("Document No.")
        {
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Code"; Rec."Beneficiary Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode3)
        {
            field("Sales Name"; Rec."Sales Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bank Payment Type")
        {
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; Rec."Cheque Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expiration Date")
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
        addafter(Control1)
        {
            field("Bal. Account Type"; Rec."Bal. Account Type")
            {
                ApplicationArea = All;
            }
            field("Bal. Account No."; Rec."Bal. Account No.")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJnlL: Record "Gen. Journal Line";
                begin
                    GenJnlL.SETRANGE("Document No.", Rec."Document No.");
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
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.RESET();
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
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
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJnlLine3: Record "Gen. Journal Line";
                begin
                    GenJnlLine3.RESET();
                    GenJnlLine3.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine3.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    GenJnlLine3.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50077, TRUE, FALSE, GenJnlLine3);
                end;
            }
            action("Print RTGS Report")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin

                    GenJournalLine.RESET();
                    //GenJnlLine.COPY(Rec);
                    GenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50100, TRUE, FALSE, GenJournalLine);

                    GenJournalLine.RESET();
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
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
                ApplicationArea = All;
            }
        }
    }
}

