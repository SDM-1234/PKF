pageextension 50031 PostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
    }
    // actions
    // {


    //     //Unsupported feature: Code Insertion (VariableCollection) on ""&Email"(Action 11).OnAction".

    //     //trigger (Variable: SalesCreditMemoHeader)()
    //     //Parameters and return type have not been exported.
    //     //begin
    //     /*
    //     */
    //     //end;
    //     addafter(Print)
    //     {
    //         action("<Action1000000011>")
    //         {
    //             Caption = 'Serv. Tax Fee Credit Memo';
    //             Image = "Credit Memo";
    //             Promoted = true;
    //             PromotedCategory = New;

    //             trigger OnAction()
    //             var
    //                 SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
    //             begin
    //                 SalesCreditMemoHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50017, TRUE, FALSE, SalesCreditMemoHeader);
    //             end;
    //         }
    //         action("Serv. Tax Expense Credit Memo")
    //         {
    //             Caption = 'Serv. Tax Expense Credit Memo';
    //             Image = "Credit Memo";
    //             Promoted = true;

    //             trigger OnAction()
    //             var
    //                 SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
    //             begin
    //                 SalesCreditMemoHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50019, TRUE, FALSE, SalesCreditMemoHeader);
    //             end;
    //         }
    //         action("<Action1000000010>")
    //         {
    //             Caption = 'GST Fee Credit Memo';
    //             Image = CreditMemo;
    //             Promoted = true;
    //             PromotedCategory = New;

    //             trigger OnAction()
    //             var
    //                 SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
    //             begin
    //                 SalesCreditMemoHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50016, TRUE, FALSE, SalesCreditMemoHeader);
    //             end;
    //         }
    //         action("GST Expense Credit Memo")
    //         {
    //             Caption = 'GST Expense Credit Memo';
    //             Image = "Credit Memo";
    //             Promoted = true;

    //             trigger OnAction()
    //             var
    //                 SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
    //             begin
    //                 SalesCreditMemoHeader.SETRANGE("No.", "No.");
    //                 REPORT.RUNMODAL(50018, TRUE, FALSE, SalesCreditMemoHeader);
    //             end;
    //         }
    //     }
    //     addafter("Import Json File")
    //     {
    //         action("Generate E-Invoice")
    //         {
    //             Image = ElectronicCollectedTax;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //         }
    //     }
    // }

    var
        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
}

