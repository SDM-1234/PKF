pageextension 50037 PostedSalesInvoices extends "Posted Sales Invoices"
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
                Caption = 'Tax Amount';
                ApplicationArea = All;
            }
            field("Amt in LCY"; AmtinLCY)
            {
                Caption = 'Amount to Customer Local Currency';
                ApplicationArea = All;
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

