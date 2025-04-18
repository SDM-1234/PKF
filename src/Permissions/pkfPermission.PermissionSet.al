/// <summary>
/// Unknown PKFPermisionsSet.
/// </summary>
namespace PKFPermisionsSet;

using PKF.PKF;

permissionset 50000 "pkf_Permission"
{
    Assignable = true;
    Permissions = tabledata Beneficiary = RIMD,
        tabledata "Customer Group" = RIMD,
        tabledata "Customer Group Code" = RIMD,
        tabledata "E-Inv Integration Setup" = RIMD,
        tabledata "E-Invoicing Requests" = RIMD,
        tabledata "Employee LOB" = RIMD,
        tabledata "GL User Setup" = RIMD,
        tabledata "LOB Master" = RIMD,
        tabledata "Portal User" = RIMD,
        tabledata "Primary Incharge" = RIMD,
        tabledata "Reminder Email Log" = RIMD,
        tabledata "Reminder List" = RIMD,
        tabledata "Reminder List Buffer" = RIMD,
        tabledata "Reminder Type" = RIMD,
        tabledata "Segment Master" = RIMD,
        tabledata "LUT / ARN Master" = RIMD,
        table Beneficiary = X,
        table "Customer Group" = X,
        table "Customer Group Code" = X,
        table "E-Inv Integration Setup" = X,
        table "E-Invoicing Requests" = X,
        table "Employee LOB" = X,
        table "GL User Setup" = X,
        table "LOB Master" = X,
        table "Portal User" = X,
        table "Primary Incharge" = X,
        table "Reminder Email Log" = X,
        table "Reminder List" = X,
        table "Reminder List Buffer" = X,
        table "Reminder Type" = X,
        table "Segment Master" = X,
        table "LUT / ARN Master" = X,
        codeunit "Email Reminder-Monthly" = X,
        codeunit "Email Reminder-Weekely" = X,
        codeunit "GL Filter Single Instance" = X,
        page "Beneficiary List" = X,
        page "Customer Group" = X,
        page "Customer Group Code" = X,
        page "E-Invoice Integration Setup" = X,
        page "E-Invoice Requests" = X,
        page "Employee LOB" = X,
        page "LOB Master" = X,
        page "Matrix Reminder List By Period" = X,
        page "Portal User Card" = X,
        page "Portal Users" = X,
        page "Primary Incharge" = X,
        page "Reminder Email Log" = X,
        page "Reminder List Card" = X,
        page "Reminder Matrix" = X,
        page "Reminder Type Card" = X,
        page "Reminder Types" = X,
        page "Reminders List" = X,
        page "Segment Master" = X,
        page "User GL Setup" = X,
        page "LUT ARN List" = X,
        codeunit "Common Subscriber" = X,
        Codeunit CMSFileMgt = X,
        tabledata EmailParameter = RIMD,
        table EmailParameter = X,
        tabledata "Temp Buffer" = RIMD,
        table "Temp Buffer" = X,
        report "Bank Payment Voucher" = X,
        report "Check Printing" = X,
        report "Check Printing Report w/o PA" = X,
        report "Proforma Invoice" = X,
        report "Responsible Person-wise" = X,
        report "RTGS Report" = X,
        report "RTGS Report Posted" = X,
        page EmailParamers = X,
        tabledata "Payment Posting Buffer" = RIMD,
        table "Payment Posting Buffer" = X,
        report "Challan Book" = X,
        report "Credit Memo Fee GST" = X,
        report "Expense Invoice GST" = X,
        report "Indian BanK - Single Line" = X,
        report "Pre Sales Invoice GST" = X,
        report "Purchase Order" = X,
        report "Sales Invoice GST" = X,
        report "Sales Invoice GST SEZ" = X,
        report "Sales Register Extraction" = X,
        report UpdateCLE = X,
        report UpdatePostedSalesInvoice = X,
        codeunit "Amount To Customer" = X,
        codeunit AmountToWords = X,
        codeunit "API Consumer E-Invoicing" = X,
        page "LUT/ARN Card" = X,
        codeunit "Payemnt Posting Mgt" = X,
        codeunit "PKF Portal Web Services" = X,
        page "Payment Posting Buffer" = X;
}