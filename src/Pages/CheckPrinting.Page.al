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

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field(Control1500004; "Stale Cheque")
                {
                    Visible = false;
                }
                field("Stale Cheque Expiry Date"; "Stale Cheque Expiry Date")
                {
                    Visible = false;
                }
                field("Cheque Stale Date"; "Cheque Stale Date")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Our Contact Code"; "Our Contact Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Open; Open)
                {
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    Visible = false;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field("Entry No."; "Entry No.")
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
                    RunPageLink = Bank Account Ledger Entry No.=FIELD(Entry No.);
                    RunPageView = SORTING(Bank Account Ledger Entry No.);
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action(Narration)
                {
                    Caption = 'Narration';
                    Image = Description;
                    RunObject = Page "Posted Narrations";
                                    RunPageLink = Entry No.=FILTER(0),Transaction No.=FIELD(Transaction No.);
                }
                action("Line Narration")
                {
                    Caption = 'Line Narration';
                    Image = LineDescription;
                    RunObject = Page "Posted Narrations";
                                    RunPageLink = Entry No.=FIELD(Entry No.),Transaction No.=FIELD(Transaction No.);
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
                        GLEntry.SETCURRENTKEY("Document No.","Posting Date");
                        GLEntry.SETRANGE("Document No.","Document No.");
                        GLEntry.SETRANGE("Posting Date","Posting Date");
                        IF GLEntry.FIND('-') THEN
                          REPORT.RUNMODAL(REPORT::"Posted Voucher",TRUE,TRUE,GLEntry);
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
                        VendorLedgerEntry.SETRANGE("Document No.","Document No.");
                        IF VendorLedgerEntry.FINDFIRST THEN
                          REPORT.RUNMODAL(50077,TRUE,FALSE,VendorLedgerEntry);
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
                        IF Reversed THEN
                          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
                        IF "Journal Batch Name" = '' THEN
                          ReversalEntry.TestFieldError;
                        TESTFIELD("Transaction No.");
                        ReversalEntry.ReverseTransaction("Transaction No.");
                    end;
                }
                action("Stale Cheque")
                {
                    Caption = 'Stale Cheque';
                    Image = StaleCheck;

                    trigger OnAction()
                    begin
                        IF "Stale Cheque" = FALSE THEN BEGIN
                          IF CONFIRM(
                               Text16502,FALSE,"Cheque No.","Bal. Account Type",
                               "Bal. Account No.") THEN BEGIN
                            IF "Stale Cheque Expiry Date" >= WORKDATE THEN
                              ERROR(Text16500,"Stale Cheque Expiry Date");
                            "Stale Cheque" := TRUE;
                            "Cheque Stale Date" := WORKDATE;
                            MODIFY;
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
                    Navigate.SetDoc("Posting Date","Document No.");
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

