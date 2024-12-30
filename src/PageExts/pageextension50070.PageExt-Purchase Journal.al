pageextension 50070 pageextension50070 extends "Purchase Journal"
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
        modify("ShortcutDimCode[3]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[5]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = true;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = true;
        }
        addafter("Service Tax Group Code")
        {
            field("Service Tax Type"; "Service Tax Type")
            {
            }
            field("Service Tax Entry"; "Service Tax Entry")
            {
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Employee Name"; "Employee Name")
            {
            }
        }
        addafter("ShortcutDimCode[3]")
        {
            field("Sales Name"; "Sales Name")
            {
            }
        }
        addafter(Control3)
        {
            field(Narration; Narration)
            {
            }
        }
    }
}

