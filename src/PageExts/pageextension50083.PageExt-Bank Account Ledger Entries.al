pageextension 50083 pageextension50083 extends "Bank Account Ledger Entries"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 10)".

        addafter(Amount)
        {
            field("Debit Amount"; "Debit Amount")
            {
            }
            field("Credit Amount"; "Credit Amount")
            {
            }
        }
        addafter("Amount (LCY)")
        {
            field("Debit Amount (LCY)"; "Debit Amount (LCY)")
            {
            }
            field("Credit Amount (LCY)"; "Credit Amount (LCY)")
            {
            }
        }
        addafter("Remaining Amount")
        {
            field("External Document No."; "External Document No.")
            {
            }
            field("Cheque No."; "Cheque No.")
            {
            }
            field("Cheque Date"; "Cheque Date")
            {
            }
        }
        addafter("Bal. Account No.")
        {
            field("Payee Name"; "Payee Name")
            {
            }
            field(Control1000000005; Narration)
            {
            }
        }
    }
    actions
    {
        addafter("Print Voucher")
        {
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

    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
}

