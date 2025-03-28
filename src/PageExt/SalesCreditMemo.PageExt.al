pageextension 50094 SalesCreditMemo extends "Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. field.', Comment = '%';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. Series field.', Comment = '%';
            }
        }
    }
}

