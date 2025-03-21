
pageextension 50011 CashPaymentVoucher extends "Cash Payment Voucher"
{
    layout
    {
        addafter("Account No.")
        {
            field(PKFNarration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
    }
}
