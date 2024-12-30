pageextension 50086 pageextension50086 extends "General Journal"
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
        modify("Bank Payment Type")
        {
            Visible = false;
        }
        addafter("Document No.")
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }
        }
        addafter("Country Code")
        {
            field("Bank Payment Type"; "Bank Payment Type")
            {
            }
            field("Cheque No."; "Cheque No.")
            {
            }
            field("Cheque Date"; "Cheque Date")
            {
            }
        }
        addafter(Quantity)
        {
            field("Amount (LCY)"; "Amount (LCY)")
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
                Visible = true;
            }
        }
        addafter(Control7)
        {
            field(Narration; Narration)
            {
            }
        }
    }
}

