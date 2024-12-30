pageextension 50077 pageextension50077 extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Vendor Posting Group"; "Vendor Posting Group")
            {
            }
        }
        addafter("Purchaser Code")
        {
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
        addafter("Creditor No.")
        {
            field("Purchase (LCY)"; "Purchase (LCY)")
            {
            }
        }
        addafter("Remaining Amt. (LCY)")
        {
            field(Remarks; Remarks)
            {
            }
            field("Remarks Cr. Memo"; "Remarks Cr. Memo")
            {
            }
        }
    }
}

