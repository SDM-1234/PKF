pageextension 50146 SalesCommentSheet extends "Sales Comment Sheet"
{
    layout
    {
        addafter("Code")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
            field("Type Code"; Rec."Type Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

