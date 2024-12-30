pageextension 50075 pageextension50075 extends "Source Code Setup"
{
    layout
    {
        modify(General)
        {
            Caption = 'General';
        }
        modify("Payment Reconciliation Journal")
        {
            ToolTip = 'Specifies the code linked to entries that are posted from a payment reconciliation journal.';
        }
        modify(Sales)
        {
            Caption = 'Sales';
        }
        modify(Purchases)
        {
            Caption = 'Purchases';
        }
        modify(Inventory)
        {
            Caption = 'Inventory';
        }
        modify(Resources)
        {
            Caption = 'Resources';
        }
        modify(Jobs)
        {
            Caption = 'Jobs';
        }
        modify("Fixed Assets")
        {
            Caption = 'Fixed Assets';
        }
        modify(Manufacturing)
        {
            Caption = 'Manufacturing';
        }
        modify(Service)
        {
            Caption = 'Service';
        }
        modify(Warehouse)
        {
            Caption = 'Warehouse';
        }
        modify("Cost Accounting")
        {
            Caption = 'Cost Accounting';
        }
    }

    //Unsupported feature: Property Deletion (CaptionML).

}

