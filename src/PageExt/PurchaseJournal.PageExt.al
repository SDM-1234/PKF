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
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Posting Type")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
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
        addafter(Amount)
        {
            field("PKF-Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
                ToolTip = 'Specifies the value of the Debit Amount field.';
            }
            field("PKF-Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
                ToolTip = 'Specifies the value of the Credit Amount field.';
            }
        }
    }
}

