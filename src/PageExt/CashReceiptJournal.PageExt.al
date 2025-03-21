
#pragma warning disable AL0789
#pragma warning disable DOC0101
#pragma warning disable DOC0101
#pragma warning restore DOC0101
/// <summary>
/// Unknown Microsoft.
/// </summary>
using Microsoft.Finance.GeneralLedger.Journal;
#pragma warning restore DOC0101
#pragma warning restore AL0789

pageextension 50012 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        addlast("Account Name")
        {

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
    }
}
