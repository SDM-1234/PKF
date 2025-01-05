pageextension 50068 CustomerLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        modify("Original Amt. (LCY)")
        {
            Visible = true;
        }
        modify("Amount (LCY)")
        {
            Visible = true;
        }
        addafter("Remaining Amt. (LCY)")
        {
            field(Control1000000000; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Remarks Cr. Memo"; Rec."Remarks Cr. Memo")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
            }
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
            }
            field("Resp. Name"; Rec."Resp. Name")
            {
                ApplicationArea = All;
            }
        }
    }
}

