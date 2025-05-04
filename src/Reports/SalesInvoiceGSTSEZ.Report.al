report 50004 "Sales Invoice GST SEZ"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/SalesInvoiceGSTSEZ.rdl';
    UseRequestPage = true;
    ApplicationArea = All;
    Caption = 'Sales Invoice GST SEZ';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    Permissions = tabledata "Sales Invoice Header" = RM;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Document_No; "Sales Invoice Header"."No.")
            {
            }
            column(ARNNo; LUTARNNo) { }
            column(Posting_Date; FORMAT("Sales Invoice Header"."Posting Date", 0, 1))
            {
            }
            column(Customer_No; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(Customer_Name; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(Customer_Add; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(Customer_Add_2; "Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(Customer_City; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(Customer_PostCode; "Sales Invoice Header"."Bill-to Post Code")
            {
            }
            column(Customer_Country; CountryName)
            {
            }
            column(Remarks_Header; "Sales Invoice Header".Remarks)
            {
            }
            column(Work_Order_No; "Sales Invoice Header"."Work Order No.")
            {
            }
            column(ReportCaption; ReportCaption)
            { }
            column(Customer_Contact; Customer.Contact)
            {
            }
            column(Customer_Contact_Mobile; Customer."Contact Person Mob. No.")
            {
            }
            column(Comp_Name; CompanyInformation.Name)
            {
            }
            column(Comp_Add; CompanyInformation.Address)
            {
            }
            column(Comp_Add_2; CompanyInformation."Address 2")
            {
            }
            column(Comp_City; CompanyInformation.City)
            {
            }
            column(Comp_PhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(Comp_FaxNo; CompanyInformation."Fax No.")
            {
            }
            column(Comp_PostCode; CompanyInformation."Post Code")
            {
            }
            column(Comp_PAN; CompanyInformation."P.A.N. No.")
            {
            }
            column(CompanyLogoVisible; CompanyLogoVisible) { }

            column(Comp_Picture; CompanyInformation.Picture)
            {
            }
            column(RecLoc_Name; RecLocation.Name)
            {
            }
            column(RecLoc_Add; RecLocation.Address)
            {
            }
            column(RecLoc_Add2; RecLocation."Address 2")
            {
            }
            column(RecLoc_City; RecLocation.City)
            {
            }
            column(RecLoc_PostCode; RecLocation."Post Code")
            {
            }
            column(RecLoc_Phone; RecPhone)
            {
            }
            column(RecLoc_Fax; RecFax)
            {
            }
            column(Currency_Code; CurrencyCode)
            {
            }
            column(VarText_1; VarText[1])
            {
            }
            column(VarText_2; VarText[2])
            {
            }
            column(VarText_3; VarText[3])
            {
            }
            column(VarText_4; VarText[4])
            {
            }
            column(VarText_5; VarText[5])
            {
            }
            column(VarText_6; VarText[6])
            {
            }
            column(VarText_7; VarText[7])
            {
            }
            column(VarText_8; VarText[8])
            {
            }
            column(VarText_9; VarText[9])
            {
            }
            column(VarText_10; VarText[10])
            {
            }
            column(Duplicate_Cap; DuplicateCap)
            {
            }
            column(ServTaxRegRec_Description; LocGstNo)
            {
            }
            column(MSMENo; MSMENo)
            {
            }
            column(MSMEText; MSMEText)
            {
            }
            column(Cus_GST_No; Customer."GST Registration No.")
            {
            }
            column(BilltoCustomerState_SalesInvoiceHeader; "Sales Invoice Header"."GST Bill-to State Code")
            {
            }
            column(StateName; StateName)
            {
            }
            column(IRN; "IRN Hash")
            {
            }
            column(QRCode; "QR Code")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LOB_Line; "Sales Invoice Header".LOB)
                {
                }
                column(Segment_Line; "Sales Invoice Header".Segment)
                {
                }
                column(Scope1_Line; "Sales Invoice Line".Scope1)
                {
                }
                column(Scope2_Line; "Sales Invoice Line".Scope2)
                {
                }
                column(Scope3_Line; "Sales Invoice Line".Scope3)
                {
                }
                column(Scope4_Line; "Sales Invoice Line".Scope4)
                {
                }
                column(Line_Amount; "Sales Invoice Line"."Line Amount")
                {
                }
                column(Sub_Total; SubTotal)
                {
                }
                column(Service_Tax; ServiceTax)
                {
                }
                column(SB_Tax; SBTax)
                {
                }
                column(KKC_Tax; KKCTax)
                {
                }
                column(AmountInWords_1; UpperCase(AmountInWords[1]))
                {
                }
                column(AmountInWords_2; UpperCase(AmountInWords[2]))
                {
                }
                column(Grand_Total; ROUND(GrandTotal, 1))
                {
                }
                column(Catof_Ser; CatofSer)
                {
                }
                column(HSNSACCode_SalesInvoiceLine; "HSN/SAC Code")
                {
                }
                column(CGST_Rate; CGST_Rate)
                {
                }
                column(CR; FORMAT(CGST_Rate))
                {
                }
                column(CGST_Amt; CGST_Amt * -1)
                {
                }
                column(IGST_Rate; IGST_Rate)
                {
                }
                column(IR; FORMAT(IGST_Rate))
                {
                }
                column(IGST_Amt; IGST_Amt * -1)
                {
                }
                column(SGST_Rate; SGST_Rate)
                {
                }
                column(SR; FORMAT(SGST_Rate))
                {
                }
                column(SGST_Amt; SGST_Amt * -1)
                {
                }
                column(TotCGST; TotCGST * -1)
                {
                }
                column(TotSGST; TotSGST * -1)
                {
                }
                column(TotIGST; TotIGST * -1)
                {
                }
                column(SAC_Desc; GetHsnDesc("GST Group Code", "HSN/SAC Code"))
                {
                }

                trigger OnAfterGetRecord()
                var
                    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
                begin
                    //IF ServTaxRegRec.GET(CompanyInformation."Service Tax Registration No.") THEN;

                    //ServiceTax += "Service Tax Amount";
                    //SBTax += "Service Tax SBC Amount";
                    //KKCTax += "KK Cess Amount";
                    SubTotal += "Line Amount";

                    IF IsRent = TRUE THEN
                        CatofSer := 'RENTAL INCOME ON IMMOVABLE PROPERTIES'
                    ELSE
                        CatofSer := CompanyInformation."Industrial Classification";

                    //GST
                    CGST_Rate := 0;
                    CGST_Amt := 0;
                    SGST_Rate := 0;
                    SGST_Amt := 0;
                    IGST_Rate := 0;
                    IGST_Amt := 0;

                    DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
                    IF DetailedGSTLedgerEntry.FINDFIRST() THEN BEGIN
                        CGST_Rate := DetailedGSTLedgerEntry."GST %";
                        CGST_Amt := DetailedGSTLedgerEntry."GST Amount";
                    END;

                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
                    IF DetailedGSTLedgerEntry.FINDFIRST() THEN BEGIN
                        //IGST_Rate := DetailedGSTLedgerEntry."GST %";
                        IGST_Rate := 0;
                        IGST_Amt := DetailedGSTLedgerEntry."GST Amount";
                    END;

                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
                    IF DetailedGSTLedgerEntry.FINDFIRST() THEN BEGIN
                        SGST_Rate := DetailedGSTLedgerEntry."GST %";
                        SGST_Amt := DetailedGSTLedgerEntry."GST Amount";
                    END;
                    //GST

                    //GST
                    TotCGST += CGST_Amt;
                    TotSGST += SGST_Amt;
                    TotIGST += IGST_Amt;
                    //GST
                    GrandTotal += "Line Amount" - CGST_Amt - SGST_Amt - IGST_Amt;
                    ReportCheck.InitTextVariable();
                    ReportCheck.FormatNoText(AmountInWords, ROUND(GrandTotal, 1), "Sales Invoice Header"."Currency Code");
                end;

                trigger OnPreDataItem()
                begin
                    //GST
                    TotCGST := 0;
                    TotSGST := 0;
                    TotIGST := 0;
                    //GST
                end;
            }

            trigger OnAfterGetRecord()
            var
                LocationL: Record Location;
                StateL: Record State;
                CountryL: Record "Country/Region";
                EInvoiceReq: Record "E-Invoicing Requests";
                QRGenerator: Codeunit "QR Generator";
                TempBlob: Codeunit "Temp Blob";
                RecRef: RecordRef;
            begin
                CalcFields("QR Code");
                if ("IRN Hash" <> '') and (not "QR Code".HasValue) then begin
                    EInvoiceReq.SetRange("Document Type", EInvoiceReq."Document Type"::"Sale Invoice");
                    EInvoiceReq.SetRange("Document No.", "No.");
                    if EInvoiceReq.FindFirst() then begin
                        RecRef.GetTable("Sales Invoice Header");
                        QRGenerator.GenerateQRCodeImage(EInvoiceReq."Signed QR Code" + EInvoiceReq."Signed QR Code2"
                                                        + EInvoiceReq."Signed QR Code3" + EInvoiceReq."Signed QR Code4", TempBlob);
                        TempBlob.ToRecordRef(RecRef, "Sales Invoice Header".FieldNo("QR Code"));
                        RecRef.SetTable("Sales Invoice Header");
                        "Sales Invoice Header".Modify();
                    end;
                end;
                LUTARNNo := LUTARN.GetARNNo("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Location Code");
                If "Invoice Types" = "Invoice Types"::Expenses then
                    ReportCaption := 'EXPENSE INVOICE'
                ELSE
                    ReportCaption := 'TAX INVOICE';

                RecLocation.GET("Location Code");
                Customer.GET("Bill-to Customer No.");
                BankDetails();



                IF RecLocation."Phone No." <> '' THEN
                    RecPhone := 'Phone No.: ' + RecLocation."Phone No."
                ELSE
                    RecPhone := '';


                If (CompanyInformation.Name <> 'PKF CONSULTING SERVICES LLP') OR (CompanyInformation.Name <> 'PKF PROSERV PVT. LTD.') THEN
                    IF RecLocation."Fax No." <> '' THEN
                        RecFax := ', Fax No.: ' + RecLocation."Fax No."
                    ELSE
                        RecFax := '';

                IF "Sales Invoice Header"."Currency Code" = '' THEN
                    CurrencyCode := 'INR'
                ELSE
                    CurrencyCode := "Currency Code";

                CLEAR(MSMENo);
                CLEAR(LocGstNo);
                IF "Sales Invoice Header"."Location Code" <> '' THEN BEGIN
                    IF LocationL.GET("Location Code") THEN BEGIN
                        LocGstNo := LocationL."GST Registration No.";
                        MSMENo := LocationL."MSME No.";
                    END
                    ELSE
                        LocGstNo := CompanyInformation."GST Registration No.";
                END ELSE
                    LocGstNo := CompanyInformation."GST Registration No.";

                IF MSMENo = '' THEN
                    MSMEText := ''
                ELSE
                    MSMEText := 'MSME No. :';

                IF CompanyInformation.Name <> 'PKF SRIDHAR & SANTHANAM LLP' THEN
                    IF CompanyInformation.Name <> 'PKF CONSULTING SERVICES LLP' THEN
                        IF SalesPerson.GET("Salesperson Code") THEN BEGIN
                            SalesCode := 'Responsible Person: ';
                            SalesPersonName := SalesPerson.Name;
                        END
                        ELSE
                            CLEAR(SalesPersonName);



                IF StateL.GET("Sales Invoice Header"."GST Bill-to State Code") THEN
                    StateName := StateL.Description
                ELSE
                    CLEAR(StateName);

                IF CountryL.GET("Bill-to Country/Region Code") THEN
                    CountryName := CountryL.Name
                ELSE
                    CLEAR(CountryName);
            end;

            trigger OnPreDataItem()
            begin
                IF GetSalesInvoiceHeader <> '' THEN
                    SETRANGE("No.", GetSalesInvoiceHeader);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(IsRent; IsRent)
                {
                    Caption = 'Rent';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rent field.';
                }
                field(IsDuplicate; IsDuplicate)
                {
                    Caption = 'Duplicate';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);

        IF IsDuplicate THEN
            DuplicateCap := 'Duplicate'
        ELSE
            DuplicateCap := '';
    end;

    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        ReportCheck: Codeunit AmountToWords;
        ServiceTax: Decimal;
        SBTax: Decimal;
        CompanyLogoVisible: Boolean;

        KKCTax: Decimal;
        SubTotal: Decimal;
        GrandTotal: Decimal;
        AmountInWords: array[2] of Text[80];
        CatofSer: Text;
        IsRent: Boolean;
        VarText: array[10] of Text;
        IsDuplicate: Boolean;
        DuplicateCap: Text;
        CurrencyCode: Code[10];
        GetSalesInvoiceHeader: Code[20];
        LUTARNNo: Code[50];
        LUTARN: Record "LUT / ARN Master";

        LocGstNo: Code[20];
        CGST_Rate: Decimal;
        CGST_Amt: Decimal;
        SGST_Rate: Decimal;
        SGST_Amt: Decimal;
        IGST_Rate: Decimal;
        IGST_Amt: Decimal;
        TotCGST: Decimal;
        TotSGST: Decimal;
        TotIGST: Decimal;
        StateName: Text[50];
        CountryName: Text[50];
        ReportCaption: Text[100];
        RecLocation: Record Location;
        MSMENo: Code[20];
        MSMEText: Text[10];
        RecPhone: Text[45];
        RecFax: Text[45];
        SalesPerson: Record "Salesperson/Purchaser";
        SalesCode: Code[100];
        SalesPersonName: Text[50];

    local procedure BankDetails()
    begin

        IF CompanyInformation.Name = 'PKF SRIDHAR & SANTHANAM LLP' THEN
            IF "Sales Invoice Header"."Customer Posting Group" = 'DOMESTIC' THEN BEGIN
                VarText[10] := 'Bank Details:';
                VarText[1] := 'INDIAN BANK ACCOUNT NO: 6343272369';
                VarText[2] := 'Name: PKF SRIDHAR & SANTHANAM LLP';
                VarText[3] := 'Bank Address: NO: 123, JAMMI BUILDING ,V M STREET, Dr. Radhakrishnan salai,';
                VarText[4] := 'MYLAPORE CHENNAI-600 004, TAMIL NADU, INDIA.';
                VarText[5] := 'IFS Code(for RTGS): IDIB000 D035';
                VarText[6] := '';
                VarText[7] := '';
                VarText[8] := '';
                VarText[9] := '';

            END

            //
            // DOOR NO 39, 23 1ST FLOOR, DR RADHAKRISHNAN SALAI, CHENNAI 600004
            //
            ELSE BEGIN
                VarText[10] := 'Bank Details:';
                VarText[1] := 'Bank Name: HDFC BANK LIMITED';
                VarText[2] := 'Beneficiary Account No. : 12842000001490';
                VarText[3] := 'Beneficiary Name and address: PKF SRIDHAR AND SANTHANAM LLP';
                VarText[4] := 'KRD GEE GEE Crystal, No. 91-92, 7th Floor, Dr. Radhakrishnan Salai,';
                VarText[5] := 'Mylapore, Chennai - 600 004';
                VarText[6] := 'Beneficiary Branch Address: HDFC BANK LIMITED, DOOR NO 39,';
                VarText[7] := ' 23 1ST FLOOR, DR RADHAKRISHNAN SALAI, Chennai - 600 004';
                VarText[8] := 'Beneficiary bank swift code: HDFCINBBCHE';
                VarText[9] := 'IFSC Code: HDFC 000 1097';
            END;


        if CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' then begin
            CompanyLogoVisible := True;
            IF "Sales Invoice Header"."Location Code" = 'MUM' THEN BEGIN
                VarText[10] := 'Bank Details:';
                VarText[1] := 'Bank Account No. 003605001058';
                VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                VarText[3] := 'Bank: ICICI Bank';
                VarText[4] := 'Branch: Maratha Mandir';
                VarText[5] := 'IFSC: ICIC0000036';
                VarText[6] := 'SWIFT Code: ICICNBBCTS';
                VarText[7] := '';
                VarText[8] := '';
                VarText[9] := '';
            end else
                if "Sales Invoice Header"."Location Code" = 'CHN' THEN BEGIN
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 000105006757';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: ICICI BANK';
                    VarText[4] := 'Branch: CENOTAPH ROAD, CHENNAI';
                    VarText[5] := 'IFSC: ICIC0000001';
                    VarText[6] := 'SWIFT Code: ICICNBBCTS';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                END;
        end;
        //ZOHO.RSF.1471[-]
        case "Sales Invoice Header"."Bank Selection For Report" of
            "Sales Invoice Header"."Bank Selection For Report"::ICICI2:
                begin
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 003605001058';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: ICICI Bank';
                    VarText[4] := 'Branch: Maratha Mandir';
                    VarText[5] := 'IFSC: ICIC0000036';
                    VarText[6] := 'SWIFT Code: ICICNBBCTS';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                END;
            "Sales Invoice Header"."Bank Selection For Report"::ICICI:
                BEGIN
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 000105006757';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: ICICI Bank';
                    VarText[4] := 'Branch: Cenotaph Road,Chennai 600018';
                    VarText[5] := 'IFSC: ICIC0000001';
                    VarText[6] := 'SWIFT Code: ICICINBBNRI';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                END;
            "Sales Invoice Header"."Bank Selection For Report"::INDIAN:
                begin
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 408084558';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: INDIAN Bank';
                    VarText[4] := 'Branch: RK Salai, Mylapore, Chennai-600004';
                    VarText[5] := 'IFSC: IDIB000D035';
                    VarText[6] := 'SWIFT Code: IDIBINBB';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                end;
            "Sales Invoice Header"."Bank Selection For Report"::HDFC:
                BEGIN
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 99900020122000';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: HDFC Bank';
                    VarText[4] := 'Branch: RK Salai, Mylapore, Chennai-600004';
                    VarText[5] := 'IFSC: HDFC0001097';
                    VarText[6] := 'SWIFT Code: HDFCINBBCHE';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                END;
            "Sales Invoice Header"."Bank Selection For Report"::HDFC2:
                BEGIN
                    VarText[10] := 'Bank Details:';
                    VarText[1] := 'Bank Account No. 50200080438699';
                    VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
                    VarText[3] := 'Bank: HDFC Bank';
                    VarText[4] := 'Branch: RK Salai, Mylapore, Chennai-600004';
                    VarText[5] := 'IFSC: HDFC0001097';
                    VarText[6] := 'SWIFT Code: HDFCINBBCHE';
                    VarText[7] := '';
                    VarText[8] := '';
                    VarText[9] := '';
                END;
        //ZOHO.RSF.1471[+]
        end;

        IF CompanyInformation.Name = 'PROBOTIQ SOLUTIONS PRIVATE LIMITED' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 6654304183';
            VarText[2] := 'A/c Name: PROBOTIQ SOLUTIONS PRIVATE LIMITED';
            VarText[3] := 'Bank: Indian Bank';
            VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
            VarText[5] := 'Address: Jammi Building, No.123, V.M. Street,';
            VarText[6] := 'Mylapore, Chennai - 600 004';
            VarText[7] := 'IFSC: IDIB000D035';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'SANDS CHEMBUR PROPERTIES PRIVATE LIMITED' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 6570927746';
            VarText[2] := 'A/c Name: SANDS CHEMBUR PROPERTIES PRIVATE LIMITED';
            VarText[3] := 'Bank: Indian Bank';
            VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
            VarText[5] := 'Address: Jammi Building, No.123, V.M. Street,';
            VarText[6] := 'Mylapore, Chennai - 600 004';
            VarText[7] := 'IFSC: IDIB000D035';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'SANDS BKC PROPERTIES PVT LTD' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 602205044134';
            VarText[2] := 'A/c Name: SANDS BKC PROPERTIES LIMITED';
            VarText[3] := 'Bank: ICICI Bank';
            VarText[4] := 'Branch Address: 200/1, R.H. Road,';
            VarText[5] := 'Mylapore, Chennai - 600 004';
            VarText[6] := 'IFSC: ICIC0006022';
            VarText[7] := '';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'PKF CONSULTING PRIVATE LIMITED' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 11000200090188';
            VarText[2] := 'A/c Name: PKF CONSULTING PRIVATE LIMITED';
            VarText[3] := 'Bank: The Federal Bank Limited';
            VarText[4] := 'Branch Address: Mount Road, Chennai - 600 002';
            VarText[5] := 'IFSC: FDRL0001100';
            VarText[6] := '';
            VarText[7] := '';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'CHANDRASEKHARA HOLDINGS (CHENNAI) PRIVATE LIMITED' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 000105009303';
            VarText[2] := 'A/c Name: CHANDRASHEKHARA HOLDINGS (CHENNAI) P LTD';
            VarText[3] := 'Bank: ICICI Bank';
            VarText[4] := 'Branch Address: No.1, Cenotaph Road,';
            VarText[5] := 'Chennai - 600 018';
            VarText[6] := 'IFSC: ICIC0000001';
            VarText[7] := '';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'SANDS BANGALORE PROPERTIES (P) LTD' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 602205045239';
            VarText[2] := 'A/c Name: SANDS BANGALORE PROPERTIES PRIVATE LIMITED';
            VarText[3] := 'Bank: ICICI Bank';
            VarText[4] := 'Branch Address: 200/1, R.H. Road,';
            VarText[5] := 'Mylapore, Chennai - 600 004';
            VarText[6] := 'IFSC: ICIC0006022';
            VarText[7] := '';
            VarText[8] := '';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'PKF CONSULTING SERVICES LLP' THEN BEGIN
            CompanyLogoVisible := true;
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 003605006317';
            VarText[2] := 'A/c Name: PKF CONSULTING SERVICES LLP';
            VarText[3] := 'Bank: ICICI Bank';
            VarText[4] := 'Branch Address: Maratha Mandir Annex,';
            VarText[5] := 'Dr. Anand Rao Nair Road,';
            VarText[6] := 'Opp. Mumbai Central Station,';
            VarText[7] := 'Mumbai - 400008';
            VarText[8] := 'IFSC: ICIC0000036';
            VarText[9] := '';
        END;

        IF CompanyInformation.Name = 'THREE D RESTRUCTRUING AND RESOLUTION SERVICES LLP' THEN BEGIN
            VarText[10] := 'Bank Details:';
            VarText[1] := 'Bank Account No. 6666058008';
            VarText[2] := 'A/c Name: THREE D RESTRUCTRUING AND RESOLUTION SERVICES LLP';
            VarText[3] := 'Bank: Indian Bank';
            VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
            VarText[5] := 'IFSC: IDIB000D035';
            VarText[6] := '';
            VarText[7] := '';
            VarText[8] := '';
            VarText[9] := '';
        END;
    end;

    procedure SetRecordsVar(SetSalesInvoiceHeader: Code[20])
    begin
        GetSalesInvoiceHeader := SetSalesInvoiceHeader;
    end;

    local procedure GetHsnDesc(GstGroupCode: Code[20]; HsnCode: Code[20]): Text
    var
        HSNSAC: Record "HSN/SAC";
    begin
        IF HSNSAC.GET(GstGroupCode, HsnCode) THEN
            EXIT(HSNSAC.Description);
    end;
}

