namespace PKF.PKF;

#pragma warning disable AW0006
page 50007 "LUT/ARN Card"
#pragma warning restore AW0006
{
    ApplicationArea = All;
    Caption = 'LUT/ARN Card';
    PageType = Card;
    SourceTable = "LUT / ARN Master";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Location Code"; Rec."Location Code")
                {
                }
                field("ARN / LUT No."; Rec."ARN / LUT No.")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
        }
    }
}
