pageextension 50020 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
            }
            field("Sales Currency"; Rec."Sales Currency")
            {
                ApplicationArea = All;
            }
            field("Work Order No."; Rec."Work Order No.")
            {
                ApplicationArea = All;
            }
            field("Bank Selection For Report"; Rec."Bank Selection For Report")
            {
                Editable = false;
                Visible = BankTypeSelectionVisible;
                ApplicationArea = All;
            }
        }
    }
    // actions
    // {
    //     addafter("Posted Reference Invoice No.")
    //     {
    //         action("Generate E-Invoice")
    //         {
    //             Image = ElectronicCollectedTax;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //         }
    //         action("Cancel E-Invoice")
    //         {
    //             Image = Cancel;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //         }
    //     }
    //     addafter("Print Excise Invoice")
    //     {
    //         action("Sales Invoice")
    //         {
    //             Caption = 'Sales Invoice';
    //             Image = Print;
    //             Promoted = true;

    //             trigger OnAction()
    //             begin
    //                 SalesInvoiceHeader.RESET;
    //                 SalesInvoiceHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50000, TRUE, FALSE, SalesInvoiceHeader)
    //             end;
    //         }
    //         action("Expense Invoice")
    //         {
    //             Caption = 'Expense Invoice';
    //             Image = Print;
    //             Promoted = true;

    //             trigger OnAction()
    //             begin
    //                 SalesInvoiceHeader.RESET;
    //                 SalesInvoiceHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50002, TRUE, FALSE, SalesInvoiceHeader)
    //             end;
    //         }
    //         action("GST Sales Invoice")
    //         {
    //             Caption = 'GST Sales Invoice';
    //             Image = Invoice;
    //             Promoted = true;

    //             trigger OnAction()
    //             var
    //                 SalesInvoiceHeaderL: Record "Sales Invoice Header";
    //             begin
    //                 SalesInvoiceHeaderL.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50010, TRUE, FALSE, SalesInvoiceHeaderL);
    //             end;
    //         }
    //         action("GST Expense Invoice")
    //         {
    //             Caption = 'GST Expense Invoice';
    //             Image = Invoice;
    //             Promoted = true;

    //             trigger OnAction()
    //             var
    //                 SalesInvoiceHeaderL: Record "Sales Invoice Header";
    //             begin
    //                 SalesInvoiceHeaderL.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50012, TRUE, FALSE, SalesInvoiceHeaderL);
    //             end;
    //         }
    //         action("<Action1000000013>")
    //         {
    //             Caption = 'GST Sales Invoice Export & SEZ';
    //             Promoted = true;

    //             trigger OnAction()
    //             var
    //                 SalesInvoiceHeaderL: Record "Sales Invoice Header";
    //             begin
    //                 SalesInvoiceHeaderL.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50004, TRUE, FALSE, SalesInvoiceHeaderL);
    //             end;
    //         }
    //     }
    // }

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CompanyInformation: Record "Company Information";
        BankTypeSelectionVisible: Boolean;


    trigger OnOpenPage()
    begin
        CompanyInformation.GET();
        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN
            BankTypeSelectionVisible := TRUE;
    end;
}

