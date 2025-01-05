/// <summary>
/// Page Check Printing (ID 50007).
/// </summary>
page 50007 "Check Printing"
{
    DataCaptionFields = "Bank Account No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData "Bank Account Ledger Entry" = rm;
    SourceTable = "Bank Account Ledger Entry";
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Control1500004; Rec."Stale Cheque")
                {
                    Visible = false;
                }
                field("Stale Cheque Expiry Date"; Rec."Stale Cheque Expiry Date")
                {
                    Visible = false;
                }
                field("Cheque Stale Date"; Rec."Cheque Stale Date")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Our Contact Code"; Rec."Our Contact Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Open; Rec.Open)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Check Ledger E&ntries")
                {
                    Caption = 'Check Ledger E&ntries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Bank Account Ledger Entry No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(Narration)
                {
                    Caption = 'Narration';
                    Image = Description;
                    RunObject = Page "Posted Narrations";
                    RunPageLink = "Entry No." = FILTER(0), "Transaction No." = FIELD("Transaction No.");
                }
                action("Line Narration")
                {
                    Caption = 'Line Narration';
                    Image = LineDescription;
                    RunObject = Page "Posted Narrations";
                    RunPageLink = "Entry No." = FIELD("Entry No."), "Transaction No." = FIELD("Transaction No.");
                }
                action("Print Voucher")
                {
                    Caption = 'Print Voucher';
                    Ellipsis = true;
                    Image = PrintVoucher;

                    trigger OnAction()
                    var
                        GLEntry: Record "G/L Entry";
                    begin
                        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                        GLEntry.SETRANGE("Document No.", "Document No.");
                        GLEntry.SETRANGE("Posting Date", "Posting Date");
                        IF GLEntry.FIND('-') THEN
                            REPORT.RUNMODAL(REPORT::"Posted Voucher", TRUE, TRUE, GLEntry);
                    end;
                }
                action("Print Check")
                {
                    Caption = 'Print Check';
                    Image = Print;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        VendorLedgerEntry.RESET;
                        VendorLedgerEntry.SETRANGE("Document No.", "Document No.");
                        IF VendorLedgerEntry.FINDFIRST THEN
                            REPORT.RUNMODAL(50077, TRUE, FALSE, VendorLedgerEntry);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Reverse Transaction")
                {
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        CLEAR(ReversalEntry);
                        IF Rec.Reversed THEN
                            ReversalEntry.AlreadyReversedEntry(Rec.TABLECAPTION, Rec."Entry No.");
                        IF Rec."Journal Batch Name" = '' THEN
                            ReversalEntry.TestFieldError;
                        Rec.TESTFIELD("Transaction No.");
                        ReversalEntry.ReverseTransaction(Rec."Transaction No.");
                    end;
                }
                action("Stale Cheque")
                {
                    Caption = 'Stale Cheque';
                    Image = StaleCheck;

                    trigger OnAction()
                    begin
                        IF Rec."Stale Cheque" = FALSE THEN BEGIN
                            IF CONFIRM(
                                 Text16502, FALSE, Rec."Cheque No.", Rec."Bal. Account Type",
                                 Rec."Bal. Account No.") THEN BEGIN
                                IF Rec."Stale Cheque Expiry Date" >= WORKDATE THEN
                                    ERROR(Text16500, Rec."Stale Cheque Expiry Date");
                                Rec."Stale Cheque" := TRUE;
                                Rec."Cheque Stale Date" := WORKDATE;
                                Rec.MODIFY;
                            END;
                        END
                        ELSE
                            MESSAGE(Text16501);
                    end;
                }
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
        Text16500: Label 'Bank Ledger Entry can be marked as stale only after %1. ';
        Text16501: Label 'The cheque has already been marked stale.';
        Text16502: Label 'Financially stale check %1 to %2 %3';
        VendorLedgerEntry: Record "Vendor Ledger Entry";
}

