pageextension 50031 pageextension50031 extends "Posted Sales Credit Memo"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 53)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address"(Control 55)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address 2"(Control 57)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 22)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address"(Control 24)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address 2"(Control 26)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 34)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 36)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address 2"(Control 38)".

        modify("E-Inv. Cancelled Date")
        {
            Visible = false;
        }
        addafter("Return Order No.")
        {
            field(Remarks; Remarks)
            {
            }
        }
        addafter("QR Code")
        {
            field("E-Inv. Cancelled Date"; "E-Inv. Cancelled Date")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on ""&Email"(Action 11).OnAction".

        //trigger (Variable: SalesCreditMemoHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;
        addafter(Print)
        {
            action("<Action1000000011>")
            {
                Caption = 'Serv. Tax Fee Credit Memo';
                Image = "Credit Memo";
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50017, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
            action("Serv. Tax Expense Credit Memo")
            {
                Caption = 'Serv. Tax Expense Credit Memo';
                Image = "Credit Memo";
                Promoted = true;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50019, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
            action("<Action1000000010>")
            {
                Caption = 'GST Fee Credit Memo';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50016, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
            action("GST Expense Credit Memo")
            {
                Caption = 'GST Expense Credit Memo';
                Image = "Credit Memo";
                Promoted = true;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCreditMemoHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50018, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
        }
        addafter("Import Json File")
        {
            action("Generate E-Invoice")
            {
                Image = ElectronicCollectedTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }

    var
        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
}

