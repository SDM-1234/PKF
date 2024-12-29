report 50090 "Sales Register Extraction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesRegisterExtraction.rdlc';
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "Posting Date", "Location Code", "Shortcut Dimension 1 Code", "Invoice Types", LOB, Segment;
            column(Posting_Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Customer_No; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(Document_No; "Sales Invoice Header"."No.")
            {
            }
            column(Branch_Code; "Sales Invoice Header"."Shortcut Dimension 2 Code")
            {
            }
            column(MONTHNAME_WITHYEAR; MONTHNAMEWITHYEAR)
            {
            }
            column(Invoice_Types; "Sales Invoice Header"."Invoice Types")
            {
            }
            column(SalesInvoiceHeader_LOB; "Sales Invoice Header".LOB)
            {
            }
            column(VarPatner_Name; VarPatnerName)
            {
            }
            column(SalesInvoiceHeader_Segment; "Sales Invoice Header".Segment)
            {
            }
            column(SalesInvoiceHeader_Remarks; "Sales Invoice Header".Remarks)
            {
            }
            column(SalesInvoiceHeader_Amount; RecAMT)
            {
            }
            column(VarAmt_6; VarAmt6)
            {
            }
            column(Amountto_Customer; RecCustAmt)
            {
            }
            column(NATUREOF_SERVICE; NATUREOFSERVICE)
            {
            }
            column(SalesInvoiceHeader_RespName; "Sales Invoice Header"."Resp. Name")
            {
            }
            column(VarR_CTSTS; VarRCTSTS)
            {
            }
            column(Var_Amt2; VarAmt2)
            {
            }
            column(VarBALE_Text; VarBALEText)
            {
            }
            column(VarCRENOT_Text; VarCRENOTText)
            {
            }
            column(Var_CreNo; VarCreNo)
            {
            }
            column(Cre_Basamt; CreBasamt)
            {
            }
            column(Var_Amt7; VarAmt7)
            {
            }
            column(Var_Amt4; VarAmt4)
            {
            }
            column(Var_Amt8; VarAmt8)
            {
            }
            column(Var_Amt9; VarAmt9)
            {
            }
            column(Var_Amt10; VarAmt10)
            {
            }
            column(CGST; VarCGST)
            {
            }
            column(SGST; VarSGST)
            {
            }
            column(IGST; VarIGST)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Amount);
                CALCFIELDS("Amount to Customer");

                IF "Sales Invoice Header"."Currency Factor" = 0 THEN BEGIN
                    RecAMT := "Sales Invoice Header".Amount;
                    RecCustAmt := "Sales Invoice Header"."Amount to Customer";
                END
                ELSE BEGIN
                    RecExchRate := 1 / "Sales Invoice Header"."Currency Factor";
                    RecAMT := "Sales Invoice Header".Amount * ROUND(RecExchRate, 0.001);
                    RecCustAmt := "Sales Invoice Header"."Amount to Customer" * ROUND(RecExchRate, 0.001);
                END;

                RecCommentsheet.RESET;
                RecEmplop.RESET;
                RecCommentsheet.SETRANGE(RecCommentsheet."No.", "Sales Invoice Header"."No.");
                IF RecCommentsheet.FINDSET THEN BEGIN
                    RecCommentsheet.SETRANGE(RecCommentsheet.Type, RecCommentsheet.Type::Partner);
                    RecEmplop.SETRANGE(RecEmplop."Emp No.", RecCommentsheet."Type Code");
                    IF RecEmplop.FINDSET THEN BEGIN
                        VarPatnerName
                         := RecEmplop."Emp Name";
                    END;
                END;

                CLEAR(VarScope);
                "RecSales Invoice Line".RESET;
                "RecSales Invoice Line".SETRANGE("RecSales Invoice Line"."Document No.", "Sales Invoice Header"."No.");
                IF "RecSales Invoice Line".FIND('-') THEN BEGIN
                    IF VarScope = '' THEN BEGIN
                        VarScope := INSSTR(VarScope, "RecSales Invoice Line".Scope1, MAXSTRLEN(VarScope));
                    END;
                END;

                MONTHNAMEWITHYEAR := '';
                NATUREOFSERVICE := '';

                VarText := FORMAT("Posting Date");
                VarText1 := COPYSTR(VarText, 4, 2);
                VarText2 := COPYSTR(VarText, 7, 4);

                IF VarText1 = '01' THEN
                    VarText3 := 'JAN-'
                ELSE
                    IF VarText1 = '02' THEN
                        VarText3 := 'FEB-'
                    ELSE
                        IF VarText1 = '03' THEN
                            VarText3 := 'MAR-'
                        ELSE
                            IF VarText1 = '04' THEN
                                VarText3 := 'APR-'
                            ELSE
                                IF VarText1 = '05' THEN
                                    VarText3 := 'MAY-'
                                ELSE
                                    IF VarText1 = '06' THEN
                                        VarText3 := 'JUN-'
                                    ELSE
                                        IF VarText1 = '07' THEN
                                            VarText3 := 'JUL-'
                                        ELSE
                                            IF VarText1 = '08' THEN
                                                VarText3 := 'AUG-'
                                            ELSE
                                                IF VarText1 = '09' THEN
                                                    VarText3 := 'SEP-'
                                                ELSE
                                                    IF VarText1 = '10' THEN
                                                        VarText3 := 'OCT-'
                                                    ELSE
                                                        IF VarText1 = '11' THEN
                                                            VarText3 := 'NOV-'
                                                        ELSE
                                                            IF VarText1 = '12' THEN
                                                                VarText3 := 'DEC-';

                MONTHNAMEWITHYEAR := VarText3 + VarText2;

                VarAmt := 0;
                VarAmt1 := 0;
                VarAmt2 := 0;
                VarAmt3 := 0;
                VarAmt4 := 0;
                VarAmt5 := 0;
                VarAmt6 := 0;
                VarAmt7 := 0;
                VarAmt8 := 0;
                VarAmt9 := 0;
                VarAmt10 := 0;
                VarRCTSTS := '';
                VarBALEText := '';
                VarBALEText1 := '';
                VarCRENOTText := '';
                VarCreNo := '';
                CreBasamt := 0;
                CLE.RESET;
                CLE.SETRANGE(CLE."Document No.", "No.");
                IF CLE.FINDFIRST THEN BEGIN

                    DCLE.RESET;
                    DCLE.SETRANGE(DCLE."Entry Type", 1);
                    DCLE.SETRANGE(DCLE."Document Type", 2);
                    DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", CLE."Entry No.");
                    IF DCLE.FINDFIRST THEN
                        VarAmt := DCLE."Amount (LCY)";

                    DCLE.RESET;
                    DCLE.SETRANGE(DCLE."Entry Type", 2);
                    DCLE.SETRANGE(DCLE."Document Type", 1);
                    DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", CLE."Entry No.");
                    IF DCLE.FINDFIRST THEN
                        REPEAT
                            VarAmt1 += DCLE."Amount (LCY)";
                            BALE.RESET;
                            BALE.SETRANGE(BALE."Document No.", DCLE."Document No.");
                            IF BALE.FINDFIRST THEN
                                VarBALEText += ' Cheque No.: '
                                + BALE."Cheque No." + ' Dt:' + FORMAT(BALE."Posting Date") + ' Amt: ' + FORMAT(BALE."Amount (LCY)");
                            intI += 1;
                        UNTIL DCLE.NEXT = 0;

                    DCLE.RESET;
                    DCLE.SETRANGE(DCLE."Entry Type", 2);
                    DCLE.SETRANGE(DCLE."Document Type", 3);
                    DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", CLE."Entry No.");
                    IF DCLE.FINDFIRST THEN
                        REPEAT
                            VarAmt3 += DCLE."Amount (LCY)";
                            CLE1.RESET;
                            CLE1.SETRANGE(CLE1."Entry No.", DCLE."Applied Cust. Ledger Entry No.");
                            IF CLE1.FINDFIRST THEN
                                DCLE1.RESET;
                            DCLE1.SETRANGE(DCLE1."Entry Type", 1);
                            DCLE1.SETRANGE(DCLE1."Document Type", 3);
                            DCLE1.SETRANGE(DCLE1."Cust. Ledger Entry No.", CLE1."Entry No.");
                            IF DCLE1.FINDFIRST THEN
                                REPEAT
                                    VarAmt4 := ABS(DCLE1."Amount (LCY)");
                                    IF DCLE1."Posting Date" < 010717D THEN BEGIN
                                        VarCRENOTText += 'CN No.: ' + CLE1."Document No." + ' Amt: ' + FORMAT(ABS(CLE1."Sales (LCY)"))
                                        + ' Service Tax Amt: ' + FORMAT(VarAmt4 + CLE1."Sales (LCY)") +
                                        ' Amt to Customer: ' + FORMAT(VarAmt4);
                                    END ELSE BEGIN
                                        VarCRENOTText += 'CN No.: ' + CLE1."Document No." + ' Amt: ' + FORMAT(ABS(CLE1."Sales (LCY)"))
                                        + ' GST Amt: ' + FORMAT(VarAmt4 + CLE1."Sales (LCY)") +
                                        ' Amt to Customer: ' + FORMAT(VarAmt4);
                                    END;
                                    VarAmt5 += ABS(CLE1."Sales (LCY)");
                                    CreBasamt := ABS(CLE1."Sales (LCY)");
                                    VarCreNo := CLE1."Document No.";
                                    VarAmt7 := VarAmt4 + CLE1."Sales (LCY)";
                                UNTIL DCLE1.NEXT = 0
 UNTIL DCLE.NEXT = 0;

                    VarAmt2 := VarAmt + VarAmt1 + VarAmt3;

                    IF VarAmt2 = VarAmt THEN
                        VarRCTSTS := 'NOT RECEIVED' ELSE
                        IF VarAmt2 = 0 THEN
                            VarRCTSTS := 'FULL RECEIPT'
                        ELSE
                            IF (VarAmt > VarAmt2) AND (VarAmt2 > 0) THEN
                                VarRCTSTS := 'PARTIAL RECEIPT';
                END;

                IF ABS(VarAmt3) = VarAmt THEN
                    CurrReport.SHOWOUTPUT(FALSE);

                IF ("Sales Invoice Header"."Amount to Customer"
                 - "Sales Invoice Header".Amount) <> 0 THEN BEGIN
                    NATUREOFSERVICE := 'TAXABLE SERVICE'
                END
                ELSE BEGIN
                    IF "Sales Invoice Header"."Customer Posting Group" = 'DOMESTIC' THEN
                        NATUREOFSERVICE := 'EXEMPTED SERVICE'
                    ELSE
                        NATUREOFSERVICE := 'EXPORT SERVICE';
                END;

                IF "Posting Date" < 010717D THEN BEGIN
                    VarAmt6 := "Amount to Customer" - Amount;
                END;

                VarAmt8 := RecAMT - VarAmt5;

                VarAmt9 := RecCustAmt - RecAMT - VarAmt7;

                VarAmt10 := RecCustAmt - VarAmt4;

                VarCGST := 0;
                VarSGST := 0;
                VarIGST := 0;

                RecGST.RESET;
                RecGST.SETRANGE(RecGST."Document No.", "No.");
                RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                RecGST.SETRANGE(RecGST."GST Component Code", 'SGST');
                IF RecGST.FINDSET THEN
                    VarSGST := -RecGST."GST Amount";

                RecGST.RESET;
                RecGST.SETRANGE(RecGST."Document No.", "No.");
                RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                RecGST.SETRANGE(RecGST."GST Component Code", 'CGST');
                IF RecGST.FINDSET THEN
                    VarCGST := -RecGST."GST Amount";

                RecGST.RESET;
                RecGST.SETRANGE(RecGST."Document No.", "No.");
                RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                RecGST.SETRANGE(RecGST."GST Component Code", 'IGST');
                IF RecGST.FINDSET THEN
                    VarIGST := -RecGST."GST Amount";
            end;

            trigger OnPreDataItem()
            begin
                RecAMT := 0;
                RecCustAmt := 0;
                RecExchRate := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        "RecSales Invoice Line": Record "Sales Invoice Line";
        VarScope: Text[1024];
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        MONTHNAMEWITHYEAR: Text[30];
        VarText: Text[30];
        VarText1: Text[30];
        VarText2: Text[30];
        VarText3: Text[30];
        CLE: Record "Cust. Ledger Entry";
        CLE1: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
        DCLE1: Record "Detailed Cust. Ledg. Entry";
        VarAmt: Decimal;
        VarAmt1: Decimal;
        VarAmt2: Decimal;
        VarRCTSTS: Text[30];
        BALE: Record "Bank Account Ledger Entry";
        VarBALEText: Text[600];
        VarAmt3: Decimal;
        VarAmt4: Decimal;
        VarAmt5: Decimal;
        VarCRENOTText: Text[600];
        NATUREOFSERVICE: Text[30];
        VarAmt6: Decimal;
        VarAmt7: Decimal;
        VarAmt8: Decimal;
        VarAmt9: Decimal;
        VarAmt10: Decimal;
        VarCreNo: Text[20];
        CreBasamt: Decimal;
        VarPatnerName: Text[30];
        RecEmplop: Record "Employee LOB";
        RecCommentsheet: Record "Sales Comment Line";
        RecSalesInvoiceHeader: Record "Sales Invoice Header";
        intI: Integer;
        VarBALEText1: Text[600];
        VarCGST: Decimal;
        VarSGST: Decimal;
        VarIGST: Decimal;
        RecGST: Record "GST Ledger Entry";
        RecAMT: Decimal;
        RecCustAmt: Decimal;
        RecExchRate: Decimal;
}

