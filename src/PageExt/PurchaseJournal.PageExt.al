pageextension 50070 PurchaseJournal extends "Purchase Journal"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 12)".

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify(ShortcutDimCode3)
        {
            Visible = true;
        }
        modify(ShortcutDimCode4)
        {
            Visible = true;
        }
        modify(ShortcutDimCode5)
        {
            Visible = true;
        }
        modify(ShortcutDimCode6)
        {
            Visible = true;
        }
        modify(ShortcutDimCode7)
        {
            Visible = true;
        }
        modify(ShortcutDimCode8)
        {
            Visible = true;
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode3)
        {
            field("Sales Name"; Rec."Sales Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account No.")
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
    }
}

