pageextension 50020 pageextension50020 extends "Posted Sales Invoice"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 61)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address"(Control 63)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address 2"(Control 65)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 18)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address"(Control 20)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address 2"(Control 22)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 38)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 40)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address 2"(Control 42)".

        addafter("Free Supply")
        {
            field("Bank Selection For Report"; "Bank Selection For Report")
            {
                Editable = false;
                Visible = BankTypeSelectionVisible;
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field(LOB; LOB)
                {
                }
                field(Segment; Segment)
                {
                }
                field(Remarks; Remarks)
                {
                }
                field("Type of Invoice"; "Type of Invoice")
                {
                }
                field("Invoice Types"; "Invoice Types")
                {
                }
                field("Team Leader"; "Team Leader")
                {
                }
                field("Sales Currency"; "Sales Currency")
                {
                }
                field("Work Order No."; "Work Order No.")
                {
                }
            }
        }
        addafter("GST Customer Type")
        {
            field("Customer GST Reg. No."; "Customer GST Reg. No.")
            {
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Posted Reference Invoice No.")
        {
            action("Generate E-Invoice")
            {
                Image = ElectronicCollectedTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Cancel E-Invoice")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
        addafter("Print Excise Invoice")
        {
            action("Sales Invoice")
            {
                Caption = 'Sales Invoice';
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50000, TRUE, FALSE, SalesInvoiceHeader)
                end;
            }
            action("Expense Invoice")
            {
                Caption = 'Expense Invoice';
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50002, TRUE, FALSE, SalesInvoiceHeader)
                end;
            }
            action("GST Sales Invoice")
            {
                Caption = 'GST Sales Invoice';
                Image = Invoice;
                Promoted = true;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50010, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
            action("GST Expense Invoice")
            {
                Caption = 'GST Expense Invoice';
                Image = Invoice;
                Promoted = true;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50012, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
            action("<Action1000000013>")
            {
                Caption = 'GST Sales Invoice Export & SEZ';
                Promoted = true;

                trigger OnAction()
                var
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeaderL.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50004, TRUE, FALSE, SalesInvoiceHeaderL);
                end;
            }
        }
    }

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CompanyInformation: Record "Company Information";
        BankTypeSelectionVisible: Boolean;


        //Unsupported feature: Code Insertion on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //begin
        /*
        BankTypeSelectionVisible := FALSE;
        */
        //end;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

        CompanyInformation.GET;
        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN
          BankTypeSelectionVisible := TRUE;
        */
        //end;
}

