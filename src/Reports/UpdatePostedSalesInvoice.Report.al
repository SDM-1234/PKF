namespace PKF.PKF;

using Microsoft.Sales.History;

report 50002 UpdatePostedSalesInvoice
{
    ApplicationArea = All;
    Caption = 'Update Posted Sales Invoice';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Sales Invoice Header" = rm;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                "Sell-to Post Code" := '999999';
                "Ship-to Post Code" := '999999';
                "Bill-to Post Code" := '999999';
                if ("Sell-to Post Code" = '999999') and
                    ("Ship-to Post Code" = '999999') and
                        ("Bill-to Post Code" = '999999') then
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
