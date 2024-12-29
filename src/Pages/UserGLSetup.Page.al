page 50025 "User GL Setup"
{
    PageType = List;
    SourceTable = "GL User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                }
                field("G/L Account No."; "G/L Account No.")
                {
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

