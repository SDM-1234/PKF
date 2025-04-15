
page 50019 "Update Narration"
{
    ApplicationArea = All;
    Caption = 'Update Narration';
    PageType = Card;
    UsageCategory = Administration;
    Permissions = TableData "Cust. Ledger Entry" = RM, TableData "G/L Entry" = RM;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(InvNo; InvNo)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice No.';
                    ToolTip = 'Enter the invoice number to update the narration.';
                }

                field(Narration; Narration)
                {
                    ApplicationArea = All;
                    Caption = 'Narration';
                    ToolTip = 'Enter the new narration for the invoice.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CLEUpdate)
            {
                ApplicationArea = All;
                Caption = 'Update Narration', comment = 'NLB="YourLanguageCaption"';
                ToolTip = 'Update the narration for the customer,Vendor,general ledger entry.';
                Image = UpdateDescription;
                trigger OnAction()
                var
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    GLEntry: Record "G/L Entry";
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    Error: Boolean;
                begin
                    CustLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Entry No.");
                    CustLedgerEntry.SetRange("Document No.", InvNo);
                    if CustLedgerEntry.FindFirst() then
                        repeat
                            CustLedgerEntry.Narration := narration;
                            CustLedgerEntry.Modify(true);
                            Error := true;
                        until CustLedgerEntry.Next() = 0;

                    VendorLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Entry No.");
                    VendorLedgerEntry.SetRange("Document No.", InvNo);
                    if VendorLedgerEntry.FindFirst() then
                        repeat
                            VendorLedgerEntry.Narration := narration;
                            VendorLedgerEntry.Modify(true);
                            Error := true;
                        until VendorLedgerEntry.Next() = 0;


                    GLEntry.SetCurrentKey("Document No.", "Document Type", "Entry No.");
                    GLEntry.SetRange("Document No.", InvNo);
                    if GLEntry.FindFirst() then
                        repeat
                            GLEntry.Narration := narration;
                            GLEntry.Modify(true);
                            Error := true;
                        until GLEntry.Next() = 0;

                    if Error then
                        Message('All entries updated successfully.')
                    else
                        Message('No entries found for the given invoice number.');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';

                actionref(CLEUpdate_Promoted; CLEUpdate)
                {
                }
            }
        }
    }
    var
        InvNo: Code[20];

        Narration: Text[200];
}
