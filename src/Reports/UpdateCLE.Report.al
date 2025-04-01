namespace PKF.PKF;

using Microsoft.Sales.Receivables;
using Microsoft.Sales.Customer;

report 50006 UpdateCLE
{
    ApplicationArea = All;
    Caption = 'UpdateCLE';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Cust. Ledger Entry" = rm;

    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Sell-to Customer No.") then;
                "Customer Name" := Customer.Name;
                Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
