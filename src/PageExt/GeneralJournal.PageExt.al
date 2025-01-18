pageextension 50086 GeneralJournal extends "General Journal"
{
    layout
    {

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
        addafter("Document No.")
        {
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

        addafter(Comment)
        {
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
            }
            field("Sales Name"; Rec."Sales Name")
            {
                Visible = true;
                ApplicationArea = All;
            }

            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
    }
}

