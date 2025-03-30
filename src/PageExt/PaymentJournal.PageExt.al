
pageextension 50007 PaymentJournal extends "Payment Journal"

{

    layout
    {
        modify(BalAccName)
        {
            Visible = true;
        }
        addafter("Account No.")
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Code"; Rec."Beneficiary Code")
            {
                ApplicationArea = All;
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
        }
        modify("Salespers./Purch. Code")
        {
            Visible = true;
        }
        moveafter("External Document No."; "Salespers./Purch. Code")
        addafter(Amount)
        {
            field("PKF-Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
                ToolTip = 'Specifies the value of the Debit Amount field.';
            }
            field("PKF-Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
                ToolTip = 'Specifies the value of the Credit Amount field.';
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                if Rec.FindFirst() then
                    repeat
                        //SDM.RSF.01
                        IF Rec."Account Type" = Rec."Account Type"::Customer THEN
                            Rec.TESTFIELD("Salespers./Purch. Code")
                    //SDM.RSF.01
                    until rec.Next() = 0;
            end;
        }

        addafter(SuggestVendorPayments)
        {
            action(PrintRTGSReport)
            {
                ApplicationArea = All;
                Caption = 'Print RTGS Report';
                Image = BankAccountStatement;
                ToolTip = 'Click to Print RTGS form';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50020, true, false, GenJournalLine);
                end;
            }
            action(PrintDepositChallan)
            {
                ApplicationArea = All;
                Caption = 'Print Deposit Challan';
                Image = Payment;
                ToolTip = 'Click to Print Deposit Challan';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50022, true, false, GenJournalLine);
                end;
            }
            action(IndianBankCheque)
            {
                ApplicationArea = All;
                Caption = 'Indian Bank Cheque';
                Image = Check;
                ToolTip = 'Click to Print Indian Bank Cheque';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50065, true, false, GenJournalLine);
                end;
            }
            action(BankPaymentVoucher)
            {
                ApplicationArea = All;
                Caption = 'Bank Payment Voucher';
                Image = BankAccountLedger;
                ToolTip = 'Click to Print Bank Payment Voucher';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50080, true, false, GenJournalLine);
                end;
            }
            action(IndianBankMultipleLinePrinting)
            {
                ApplicationArea = All;
                Caption = 'Indian Bank - Multiple Line Printing';
                Image = Check;
                ToolTip = 'Click to Print Indian Bank - Multiple Line Printing';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUNMODAL(50077, true, false, GenJournalLine);
                end;
            }


        }

    }

}
