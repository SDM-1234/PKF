pageextension 50077 VendorLedgerEntries extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
        }
        addafter("Purchaser Code")
        {
            field("TDS NOD"; Rec."TDS NOD")
            {

                ApplicationArea = All;
            }
            field("TDS Amount"; Rec."TDS Amount")
            {
                ApplicationArea = All;

            }
            field("TDS Account Amount"; Rec."TDS Account Amount")
            {
                ApplicationArea = All;

            }
        }
        addafter("Creditor No.")
        {
            field("Purchase (LCY)"; Rec."Purchase (LCY)")
            {
                ApplicationArea = All;

            }
        }
        addafter("Remaining Amt. (LCY)")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
            field("Remarks Cr. Memo"; Rec."Remarks Cr. Memo")
            {
                ApplicationArea = All;

            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
        }
    }
}

