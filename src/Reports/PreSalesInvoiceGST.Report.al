report 50011 "Pre Sales Invoice GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/PreSalesInvoiceGST.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Document_No; "Sales Header"."Posting No.")
            {
            }
            column(LUTARNNo; LUTARNNo)
            {

            }
            column(Posting_Date; FORMAT("Sales Header"."Posting Date", 0, 1))
            {
            }
            column(Customer_No; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(Customer_Name; "Sales Header"."Bill-to Name")
            {
            }
            column(Customer_Add; "Sales Header"."Bill-to Address")
            {
            }
            column(Customer_Add_2; "Sales Header"."Bill-to Address 2")
            {
            }
            column(Customer_City; "Sales Header"."Bill-to City")
            {
            }
            column(Customer_PostCode; "Sales Header"."Bill-to Post Code")
            {
            }
            column(Customer_Country; CountryName)
            {
            }
            column(Remarks_Header; "Sales Header".Remarks)
            {
            }
            column(PayCode; PayCode)
            {
            }
            column(PayTermsDesc; PayTermsDesc)
            {
            }
            column(SalesCode; SalesCode)
            {
            }
            column(SalesPersonName; SalesPersonName)
            {
            }
            column(Work_Order_No; "Sales Header"."Work Order No.")
            {
            }
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
            column(CompanyLogoVisible; CompanyLogoVisible) { }

            column(Comp_FaxNo; CompanyInformation."Fax No.")
            {
            }
            column(Comp_PostCode; CompanyInformation."Post Code")
            {
            }
            column(Comp_PAN; CompanyInformation."P.A.N. No.")
            {
            }
            column(Comp_Picture; CompanyInformation.Picture)
            {
            }
            column(Currency_Code; CurrencyCode)
            {
            }
            column(RecLoc_Name; RecLocation.Name)
            {
            }
            column(RecLoc_Add; RecLocation.Address)
            {
            }
            column(RecLoc_Add_2; RecLocation."Address 2")
            {
            }
            column(RecLoc_Add2; RecLocation."Address 2")
            { }
            column(RecLoc_City; RecLocation.City)
            {
            }
            column(RecLoc_Phone; RecPhone)
            {
            }
            column(LocFax; LocFax)
            {
            }
            column(RecLoc_Fax; RecFax)
            {
            }
            column(RecLoc_PostCode; RecLocation."Post Code")
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
            column(Cus_GST_No; Customer."GST Registration No.")
            {
            }
            column(BilltoCustomerState; "Sales Header"."GST Bill-to State Code")
            {
            }
            column(MSMENo; MSMENo)
            {
            }
            column(MSMEText; MSMEText)
            {
            }
            column(StateName; StateName)
            {
            }
            column(ServTaxRegRec_Description; LocGstNo)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LOB_Line; "Sales Header".LOB)
                {
                }
                column(Segment_Line; "Sales Header".Segment)
                {
                }
                column(Description; "Sales Line".Description) { }
                column(Scope1_Line; "Sales Line".Scope1)
                {
                }
                column(Scope2_Line; "Sales Line".Scope2)
                {
                }
                column(Scope3_Line; "Sales Line".Scope3)
                {
                }
                column(Scope4_Line; "Sales Line".Scope4)
                {
                }
                column(Line_Amount; "Sales Line"."Line Amount")
                {
                }
                column(Unit_Price; "Sales Line"."Unit Price")
                {
                }
                column(Sub_Total; SubTotal)
                {
                }
                column(GrossTotal; GrossTotal)
                {
                }
                column(DiscountAmt; DiscountAmt)
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
                column(CGST_Rate; 'CGST')
                {
                }
                column(IGST_Rate; 'IGST')
                {
                }
                column(SGST_Rate; 'SGST')
                {
                }
                column(TotCGST; GSTCompAmount[2])
                {
                }
                column(TotSGST; GSTCompAmount[6])
                {
                }

                column(GSTComponentCode; GSTComponentCode[GSTCompNo])
                {
                }

                column(TotIGST; GSTCompAmount[3])
                {
                }
                column(CGST_Rate_1; CGST_Rate)
                {
                }
                column(IGST_Rate_1; IGST_Rate)
                {
                }
                column(SGST_Rate_1; SGST_Rate)
                {
                }
                column(CR; FORMAT(CGST_Rate))
                {
                }
                column(IR; FORMAT(IGST_Rate))
                {
                }
                column(SR; FORMAT(SGST_Rate))
                {
                }
                column(HSNSACCode_SalesLine; "HSN/SAC Code")
                {
                }
                column(SAC_Desc; GetHsnDesc("GST Group Code", "HSN/SAC Code"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SubTotal += "Line Amount";
                    DiscountAmt += "Line Discount Amount";
                    GrossTotal := SubTotal + DiscountAmt;


                    //[-]
                    CGST_Rate := 9;
                    SGST_Rate := 9;
                    IGST_Rate := 18;

                    If TotGSTAmt = 0 then begin
                        SalesLine1.SetRange("Document No.", "Sales Header"."No.");
                        SalesLine1.SetRange("Document Type", "Sales Header"."Document Type");
                        if SalesLine1.FindSet() then
                            repeat
                                GSTCompNo := 1;
                                TaxTrnasactionValue.Reset();
                                TaxTrnasactionValue.SetRange("Tax Record ID", SalesLine1.RecordId);
                                TaxTrnasactionValue.SetRange("Tax Type", 'GST');
                                TaxTrnasactionValue.SetRange("Value Type", TaxTrnasactionValue."Value Type"::COMPONENT);
                                TaxTrnasactionValue.SetFilter(Percent, '<>%1', 0);
                                if TaxTrnasactionValue.FindSet() then
                                    repeat
                                        GSTCompNo := TaxTrnasactionValue."Value ID";
                                        GSTComponentCode[GSTCompNo] := TaxTrnasactionValue."Value ID";
                                        TaxTrnasactionValue1.Reset();
                                        TaxTrnasactionValue1.SetRange("Tax Record ID", SalesLine1.RecordId);
                                        TaxTrnasactionValue1.SetRange("Tax Type", 'GST');
                                        TaxTrnasactionValue1.SetRange("Value Type", TaxTrnasactionValue1."Value Type"::COMPONENT);
                                        TaxTrnasactionValue1.SetRange("Value ID", GSTComponentCode[GSTCompNo]);
                                        if TaxTrnasactionValue1.FindSet() then begin
                                            repeat
                                                GSTCompAmount[GSTCompNo] += TaxTrnasactionValue1."Amount";
                                                TotGSTAmt += TaxTrnasactionValue1.Amount;
                                            until TaxTrnasactionValue1.Next() = 0;
                                            GSTCompNo += 1;
                                        end;
                                    until TaxTrnasactionValue.Next() = 0;
                            until SalesLine1.Next() = 0;
                    end;
                    //[+]
                    IF IsRent = TRUE THEN
                        CatofSer := 'RENTAL INCOME ON IMMOVABLE PROPERTIES'
                    ELSE
                        CatofSer := CompanyInformation."Industrial Classification";

                    LUTARNNo := LUTARN.GetARNNo("Sales Header"."Posting Date", "Sales Header"."Location Code");


                    GrandTotal := SubTotal + TotGSTAmt - TotIGST - TotSGST - TotCGST;
                    ReportCheck.InitTextVariable();
                    ReportCheck.FormatNoText(AmountInWords, ROUND(GrandTotal, 1), "Sales Header"."Currency Code");
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
                CountryL: Record "Country/Region";
                LocationL: Record Location;
                StateL: Record State;
            begin
                RecLocation.GET("Location Code");
                Customer.GET("Bill-to Customer No.");
                BankDetails();

                IF RecLocation."Phone No." <> '' THEN
                    RecPhone := 'Phone No.: ' + RecLocation."Phone No."
                ELSE
                    RecPhone := '';

                IF RecLocation."Fax No." <> '' THEN
                    RecFax := ', Fax No.: ' + RecLocation."Fax No."
                ELSE
                    RecFax := '';

                IF "Sales Header"."Currency Code" = '' THEN
                    CurrencyCode := 'INR'
                ELSE
                    CurrencyCode := "Currency Code";

                IF RecLocation."Fax No." <> '' THEN
                    LocFax := ', Fax No. '
                ELSE
                    LocFax := '';

                CLEAR(MSMENo);
                CLEAR(LocGstNo);
                IF "Location Code" <> '' THEN BEGIN
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
                    IF SalesPerson.GET("Salesperson Code") THEN BEGIN
                        SalesCode := 'Responsible Person: ';
                        SalesPersonName := SalesPerson.Name;
                    END ELSE
                        CLEAR(SalesPersonName);


                IF PayTerms.GET("Payment Terms Code") THEN BEGIN
                    PayCode := 'Payment Terms: ';
                    PayTermsDesc := PayTerms.Description;
                END
                ELSE
                    CLEAR(PayTermsDesc);

                IF StateL.GET(State) THEN
                    StateName := StateL.Description
                ELSE
                    CLEAR(StateName);

                IF CountryL.GET("Bill-to Country/Region Code") THEN
                    CountryName := CountryL.Name
                ELSE
                    CLEAR(CountryName);
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
        ServiceTax: Decimal;
        SBTax: Decimal;
        KKCTax: Decimal;
        SubTotal: Decimal;
        GrandTotal: Decimal;
        ReportCheck: Codeunit AmountToWords;
        AmountInWords: array[2] of Text[80];
        CatofSer: Text;
        IsRent: Boolean;
        //ServTaxRegRec: Record "Service Tax Registration Nos.";
        VarText: array[10] of Text;
        IsDuplicate: Boolean;
        DuplicateCap: Text;
        CurrencyCode: Code[10];
        CGST_Rate: Decimal;
        CGST_Amt: Decimal;
        SGST_Rate: Decimal;
        SGST_Amt: Decimal;
        TaxTrnasactionValue: Record "Tax Transaction Value";
        TaxTrnasactionValue1: Record "Tax Transaction Value";
        SalesLine1: Record "Sales Line";
        GSTComponentCodeName: array[20] of Code[20];
        GSTCompAmount: array[20] of Decimal;
        GSTComponentCode: array[20] of Integer;
        GSTCompNo, j : Integer;
        TotGSTAmt: Decimal;

        IGST_Rate: Decimal;
        IGST_Amt: Decimal;
        TotCGST: Decimal;
        TotSGST: Decimal;
        TotIGST: Decimal;
        StateName: Text[50];
        CountryName: Text[50];
        LocGstNo: Code[20];
        RecLocation: Record Location;
        PayTerms: Record "Payment Terms";
        PayTermsDesc: Text[100];
        LUTARNNo: Code[50];
        LUTARN: Record "LUT / ARN Master";
        CompanyLogoVisible: Boolean;

        PayCode: Text[20];
        SalesPersonName: Text[50];
        SalesPerson: Record "Salesperson/Purchaser";
        SalesCode: Text[20];
        LocFax: Text[30];
        DiscountAmt: Decimal;
        GrossTotal: Decimal;
        MSMENo: Code[20];
        MSMEText: Text[10];
        RecPhone: Text[45];
        RecFax: Text[45];

    local procedure BankDetails()
    begin

        IF CompanyInformation.Name = 'PKF SRIDHAR & SANTHANAM LLP' THEN
            IF "Sales Header"."Customer Posting Group" = 'DOMESTIC' THEN BEGIN
                VarText[10] := 'Bank Details:';
                VarText[1] := 'INDIAN BANK ACCOUNT NO: 6343272369';
                VarText[2] := 'Name: PKF SRIDHAR & SANTHANAM LLP';
                VarText[3] := 'Bank Address: NO: 123, JAMMI BUILDING ,V M STREET, Dr. Radhakrishnan';
                VarText[4] := 'salai, MYLAPORE CHENNAI-600 004, TAMIL NADU, INDIA.';
                VarText[5] := 'IFS Code(for RTGS): IDIB000 D035';
                VarText[6] := '';
                VarText[7] := '';
                VarText[8] := '';
                VarText[9] := '';

            END ELSE BEGIN
                VarText[10] := 'Bank Details:';
                VarText[1] := 'Bank Name: HDFC BANK LIMITED';
                VarText[2] := 'Beneficiary Account No. : 12842000001490';
                VarText[3] := 'Beneficiary Name and address: PKF SRIDHAR AND SANTHANAM LLP';
                VarText[4] := 'KRD GEE GEE Crystal, No. 91-92, 7th Floor, Dr. Radhakrishnan Salai,';
                VarText[5] := 'Mylapore, Chennai - 600 004';
                VarText[6] := 'Beneficiary Branch Address: HDFC BANK LIMITED, NO.5, Sait Colony,';
                VarText[7] := '1st Street, Egmore, Chennai - 600 008';
                VarText[8] := 'Beneficiary bank swift code: HDFCINBBCHE';
                VarText[9] := 'IFSC Code: HDFC 000 1284';
            END;


        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' then begin
            CompanyLogoVisible := True;
            IF "Sales Header"."Location Code" = 'MUM' THEN BEGIN
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
            END ELSE IF "Sales Header"."Location Code" = 'CHN' THEN BEGIN
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
        //RSF.ZOHO-1471[-]

        Case "Sales Header"."Bank Selection For Report" of
            "Sales Header"."Bank Selection For Report"::ICICI2:
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
                end;
            "Sales Header"."Bank Selection For Report"::ICICI:
                begin
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
                end;
            "Sales Header"."Bank Selection For Report"::INDIAN:
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
            "Sales Header"."Bank Selection For Report"::HDFC:
                Begin
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
                End;
            "Sales Header"."Bank Selection For Report"::HDFC2:
                begin
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
                end;
        End;
        //RSF.ZOHO-1471[+]

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
            CompanyLogoVisible := True;
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

    local procedure GetHsnDesc(GstGroupCode: Code[20]; HsnCode: Code[20]): Text
    var
        HSNSAC: Record "HSN/SAC";
    begin
        IF HSNSAC.GET(GstGroupCode, HsnCode) THEN
            EXIT(HSNSAC.Description);
    end;
}

