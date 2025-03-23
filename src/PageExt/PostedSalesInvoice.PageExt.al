pageextension 50020 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LOB field.';
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Segment field.';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Types field.';
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Leader field.';
            }
            field("Sales Currency"; Rec."Sales Currency")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Currency field.';
            }
            field("Work Order No."; Rec."Work Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Work Order No. field.';
            }
            field("Bank Selection For Report"; Rec."Bank Selection For Report")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = BankTypeSelectionVisible;
                ToolTip = 'Specifies the value of the Bank Selection For Report field.';
            }
        }
    }
    actions
    {
        addafter("Import E-Invoice Response")
        {
            action("Generate E-Invoice Cleartax")
            {
                Image = ElectronicCollectedTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate E-Invoice Online';
                Caption = 'Generate E-Invoice Online';
                ApplicationArea = All;

            }
            action("Cancel E-Invoice Cleartax")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Cancel E-Invoice Online';
                Caption = 'Cancel E-Invoice Online';
            }
        }
        addafter(Print)
        {
            action("GST Sales Invoice")
            {
                Caption = 'GST Sales Invoice';
                Image = Invoice;
                Promoted = true;
                ToolTip = 'Executes the GST Sales Invoice action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50010, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
            action("GST Expense Invoice")
            {
                Caption = 'GST Expense Invoice';
                Image = Invoice;
                Promoted = true;
                ToolTip = 'Executes the GST Expense Invoice action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50012, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
            action("GST Sales Invoice Export & SEZ")
            {
                Caption = 'GST Sales Invoice Export & SEZ';
                Promoted = true;
                Image = PostedTaxInvoice;
                ToolTip = 'Executes the GST Sales Invoice Export & SEZ action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50004, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        BankTypeSelectionVisible: Boolean;


    trigger OnOpenPage()
    begin
        CompanyInformation.GET();
        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN
            BankTypeSelectionVisible := TRUE;
    end;
}

