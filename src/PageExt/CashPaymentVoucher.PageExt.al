
pageextension 50011 CashPaymentVoucher extends "Cash Payment Voucher"
{
    layout
    {
        addafter("Account No.")
        {
            field(PKFNarration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
        }
    }
}
