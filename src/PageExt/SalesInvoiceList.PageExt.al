pageextension 50151 SalesInvoiceList extends "Sales Invoice List"
{
    layout
    {
        addlast(Control1)
        {
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
            }
            field("Tax Amount"; GetTaxAmount())
            {
                ApplicationArea = All;
            }
            field("Amount to Customer"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Invoice type as GST Laws.';
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of the customer. For example, Registered/Unregistered/Export etc..';
            }

        }
    }
    actions
    {
        addafter(Statistics)
        {
            action(BulkStatistics)
            {
                ApplicationArea = All;
                Caption = 'BUlk Statistics';
                Image = Statistics;
                ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
                    SalesStat: Page "Sales Statistics";
                    SessionSettings: SessionSettings;
                begin
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    if SalesHeader.FindSet() then
                        repeat
                            Commit();
                            Clear(SalesStat);
                            Rec.PrepareOpeningDocumentStatistics();
                            SalesStat.Run();
                            SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                        until SalesHeader.Next() = 0;
                    SessionSettings.Init();
                    SessionSettings.RequestSessionUpdate(false);
                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                PrePostValidations();
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                PrePostValidations();
            end;
        }
        // addafter("P&osting")
        // {
        //     group(Print)
        //     {
        //         Caption = 'Print';
        //         action("<Action1000000014>")
        //         {
        //             Caption = 'GST Sales Invoice';
        //             Image = Invoice;
        //             Promoted = true;
        //             PromotedCategory = Category9;
        //             PromotedIsBig = false;

        //             trigger OnAction()
        //             var
        //                 SalesHeaderL: Record "Sales Header";
        //             begin
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //                 IF ("Posting No." <> "No.") THEN BEGIN
        //                     ERROR('Invoice No. & Posting No. are not same');
        //                 END
        //                 ELSE BEGIN
        //                     SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                     SalesHeaderL.SETRANGE("No.", "No.");
        //                     REPORT.RUNMODAL(50011, TRUE, FALSE, SalesHeaderL)
        //                 END;
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //             end;
        //         }
        //         action("<Action1000000015>")
        //         {
        //             Caption = 'GST Expense Invoice';
        //             Image = Invoice;
        //             Promoted = true;
        //             PromotedCategory = Category9;
        //             PromotedIsBig = false;

        //             trigger OnAction()
        //             var
        //                 SalesHeaderL: Record "Sales Header";
        //             begin
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //                 IF ("Posting No." <> "No.") THEN BEGIN
        //                     ERROR('Invoice No. & Posting No. are not same');
        //                 END
        //                 ELSE BEGIN
        //                     SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                     SalesHeaderL.SETRANGE("No.", "No.");
        //                     REPORT.RUNMODAL(50013, TRUE, FALSE, SalesHeaderL);
        //                 END;
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //             end;
        //         }
        //         action("<Action1000000016>")
        //         {
        //             Caption = 'GST Sales Invoice SEZ';
        //             Image = Invoice;
        //             Promoted = true;
        //             PromotedCategory = Category9;
        //             PromotedIsBig = false;

        //             trigger OnAction()
        //             var
        //                 SalesHeaderL: Record "Sales Header";
        //             begin
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //                 IF ("Posting No." <> "No.") THEN BEGIN
        //                     ERROR('Invoice No. & Posting No. are not same');
        //                 END
        //                 ELSE BEGIN
        //                     SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                     SalesHeaderL.SETRANGE("No.", "No.");
        //                     REPORT.RUNMODAL(50006, TRUE, FALSE, SalesHeaderL)
        //                 END;
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //             end;
        //         }
        //         action("<Action1000000017>")
        //         {
        //             Caption = 'GST Sales Invoice Export';
        //             Image = Invoice;
        //             Promoted = true;
        //             PromotedCategory = Category10;
        //             PromotedIsBig = false;

        //             trigger OnAction()
        //             var
        //                 SalesHeaderL: Record "Sales Header";
        //             begin
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //                 IF ("Posting No." <> "No.") THEN BEGIN
        //                     ERROR('Invoice No. & Posting No. are not same');
        //                 END
        //                 ELSE BEGIN
        //                     SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                     SalesHeaderL.SETRANGE("No.", "No.");
        //                     REPORT.RUNMODAL(50014, TRUE, FALSE, SalesHeaderL)
        //                 END;
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //             end;
        //         }
        //         action("<Action1000000010>")
        //         {
        //             Caption = 'GST Expense Invoice Export';
        //             Image = Invoice;
        //             Promoted = true;
        //             PromotedCategory = Category10;
        //             PromotedIsBig = false;

        //             trigger OnAction()
        //             var
        //                 SalesHeaderL: Record "Sales Header";
        //             begin
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //                 IF ("Posting No." <> "No.") THEN BEGIN
        //                     ERROR('Invoice No. & Posting No. are not same');
        //                 END
        //                 ELSE BEGIN
        //                     SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                     SalesHeaderL.SETRANGE("No.", "No.");
        //                     REPORT.RUNMODAL(50015, TRUE, FALSE, SalesHeaderL)
        //                 END;
        //                 //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //             end;
        //         }
        //     }
        // }
    }
    local procedure PrePostValidations()
    BEGIN
        IF NOT ((Rec."Sales Currency" IN [Rec."Sales Currency"::INR, Rec."Sales Currency"::" "]) OR (Rec."Currency Code" IN ['INR', ''])) THEN
            IF NOT (Rec."Currency Code" = FORMAT(Rec."Sales Currency")) THEN
                ERROR('Curreny Code Should be same as Sales Currency');

        IF Rec."Posting No." = '' THEN
            ERROR('Please take print out');
    End;

    local procedure GetTaxAmount() Return: Decimal
    var
        TaxTrnasactionValue: Record "Tax Transaction Value";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet() then
            repeat
                TaxTrnasactionValue.Reset();
                TaxTrnasactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
                TaxTrnasactionValue.SetRange("Tax Type", 'GST');
                TaxTrnasactionValue.SetRange("Value Type", TaxTrnasactionValue."Value Type"::COMPONENT);
                TaxTrnasactionValue.setfilter("Value ID", '2|3|5|6');
                if TaxTrnasactionValue.FindFirst() then
                    Return += TaxTrnasactionValue.Amount;
            until SalesLine.Next() = 0;

    end;
}

