pageextension 50041 GSTCreditAdjustment extends "GST Credit Adjustment"
{
    layout
    {
        modify(AdjDocNo2)
        {
            Caption = 'Adjustment  Document No.';
        }
        modify(GSTINNo2)
        {
            Caption = 'GST Registration No.';
        }
        modify(PostingDate2)
        {
            Caption = 'Posting Date';
        }
        modify(DocumentNo2)
        {
            Caption = 'Document No.';
        }
    }
    actions
    {
        modify(ApplyEntries)
        {
            Caption = '&Apply Entries';
        }
    }

}

