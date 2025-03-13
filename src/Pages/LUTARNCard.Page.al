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
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("ARN / LUT No."; Rec."ARN / LUT No.")
                {
                    ToolTip = 'Specifies the value of the ARN / LUT No. field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
            }
        }
    }
}
