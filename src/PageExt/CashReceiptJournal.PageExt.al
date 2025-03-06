
using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50012 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        addlast("Account Name")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
            }
        }
    }
}
