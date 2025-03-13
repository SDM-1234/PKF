namespace PKF.PKF;

page 50006 "LUT ARN List"
{
    ApplicationArea = All;
    Caption = 'LUT ARN List';
    PageType = List;
    SourceTable = "LUT / ARN Master";
    UsageCategory = Lists;
    CardPageId = "LUT/ARN Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
