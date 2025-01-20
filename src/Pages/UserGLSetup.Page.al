page 50025 "User GL Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "GL User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

