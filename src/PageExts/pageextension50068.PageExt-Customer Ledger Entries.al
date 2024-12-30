pageextension 50068 pageextension50068 extends "Customer Ledger Entries"
{
    layout
    {
        modify("Message to Recipient")
        {
            Visible = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 10)".

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
        addafter("Posting Date")
        {
            field("Document Date"; "Document Date")
            {
            }
        }
        addafter(Description)
        {
            field("Customer Posting Group"; "Customer Posting Group")
            {
            }
        }
        addafter("Currency Code")
        {
            field("Sales (LCY)"; "Sales (LCY)")
            {
            }
        }
        addafter("Remaining Amt. (LCY)")
        {
            field(Control1000000000; Narration)
            {
            }
            field(Remarks; Remarks)
            {
            }
            field("Remarks Cr. Memo"; "Remarks Cr. Memo")
            {
                Editable = false;
            }
            field("Team Leader"; "Team Leader")
            {
            }
            field(Segment; Segment)
            {
            }
            field(LOB; LOB)
            {
            }
            field("Invoice Types"; "Invoice Types")
            {
            }
            field("Resp. Name"; "Resp. Name")
            {
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("External Document No."; "External Document No.")
            {
            }
        }
    }
}

