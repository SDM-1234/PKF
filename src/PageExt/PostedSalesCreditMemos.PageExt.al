pageextension 50038 PostedSalesCreditMemos extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("No.")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Amount)
        {
            field(TaxAmount; Rec."Amount Including VAT" - Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Tax Amount';
            }
            field("Amt in LCY"; AmtinLCY)
            {
                ApplicationArea = All;
                Caption = 'Amount to Customer Local Currency';
            }
        }
        addlast(Control1)
        {
            field("QR Code_"; Rec."QR Code".HasValue)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'QR Code';
                Caption = 'QR Code';
            }
        }
    }

    var
        DCLE: Record "Detailed Cust. Ledg. Entry";
        AmtinLCY: Decimal;

    trigger OnAfterGetRecord()
    begin
        AmtinLCY := 0;
        DCLE.RESET();
        DCLE.SETRANGE(DCLE."Document No.", Rec."No.");
        DCLE.SETRANGE(DCLE."Initial Document Type", DCLE."Initial Document Type"::Invoice);
        IF DCLE.FINDFIRST() THEN
            AmtinLCY := DCLE."Amount (LCY)";
    end;
}

