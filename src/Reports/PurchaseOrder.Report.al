/// <summary>
/// Report Purchase Order (ID 50003).
/// </summary>
report 50003 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/PurchaseOrder.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Order';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(Document_No; "Purchase Header"."No.")
            {
            }
            column(Order_Date; FORMAT("Purchase Header"."Order Date", 0, 1))
            {
            }
            column(Vendor_No; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(Vendor_Name; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(Vendor_Add; "Purchase Header"."Buy-from Address")
            {
            }
            column(Vendor_Add_2; "Purchase Header"."Buy-from Address 2")
            {
            }
            column(Vendor_City; "Purchase Header"."Buy-from City")
            {
            }
            column(Vendor_PostCode; "Purchase Header"."Buy-from Post Code")
            {
            }
            column(Vendor_Country; CountryName)
            {
            }
            column(Remarks_Header; "Purchase Header".Remarks)
            {
            }
            column(PayCode; PayCode)
            {
            }
            column(PayTermsDesc; PayTermsDesc)
            {
            }
            column(PurchaseCode; PurchaseCode)
            {
            }
            column(PurPersonName; PurPersonName)
            {
            }
            column(Work_Order_No; "Purchase Header"."Vendor Order No.")
            {
            }
            column(Vendor_Contact; Vendor.Contact)
            {
            }
            column(Vendor_Contact_Mobile; Vendor."Phone No.")
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
            column(Duplicate_Cap; DuplicateCap)
            {
            }
            column(Ven_GST_No; Vendor."GST Registration No.")
            {
            }
            column(BuyfrmVendorState; "Purchase Header".State)
            {
            }
            column(StateName; StateName)
            {
            }
            column(ServTaxRegRec_Description; LocGstNo)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Description; "Purchase Line".Description + ' ' + "Purchase Line"."Description 2")
                {
                }
                column(Quantity; "Purchase Line".Quantity)
                {
                }
                column(Line_Amount; "Purchase Line"."Line Amount")
                {
                }
                column(Unit_Cost; "Purchase Line"."Unit Cost")
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
                column(AmountInWords_1; AmountInWords[1])
                {
                }
                column(AmountInWords_2; AmountInWords[2])
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
                column(TotCGST; TotCGST * -1)
                {
                }
                column(TotSGST; TotSGST * -1)
                {
                }
                column(TotIGST; TotIGST * -1)
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
                var
                    DetailedGSTLedgerEntry: Record "Detailed GST Entry Buffer";
                begin
                    SubTotal += "Line Amount";
                    DiscountAmt += "Line Discount Amount";
                    GrossTotal := SubTotal + DiscountAmt;
                    GrandTotal += "Amount Including VAT";
                    ReportCheck.InitTextVariable();
                    ReportCheck.FormatNoText(AmountInWords, ROUND(GrandTotal, 1), "Purchase Header"."Currency Code");

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

                    DetailedGSTLedgerEntry.RESET();
                    DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                    DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Order);
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
                    IF DetailedGSTLedgerEntry.FINDFIRST() THEN BEGIN
                        CGST_Rate := DetailedGSTLedgerEntry."GST %";
                        CGST_Amt := DetailedGSTLedgerEntry."GST Amount";
                    END;

                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
                    IF DetailedGSTLedgerEntry.FINDFIRST() THEN BEGIN
                        IGST_Rate := DetailedGSTLedgerEntry."GST %";
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
                Vendor.GET("Buy-from Vendor No.");
                Customer.GET("Sell-to Customer No.");

                IF RecLocation."Phone No." <> '' THEN
                    RecPhone := 'Phone No.: ' + RecLocation."Phone No."
                ELSE
                    RecPhone := '';

                IF RecLocation."Fax No." <> '' THEN
                    RecFax := ', Fax No.: ' + RecLocation."Fax No."
                ELSE
                    RecFax := '';

                IF "Purchase Header"."Currency Code" = '' THEN
                    CurrencyCode := 'INR'
                ELSE
                    CurrencyCode := "Currency Code";

                IF RecLocation."Fax No." <> '' THEN
                    LocFax := ', Fax No. '
                ELSE
                    LocFax := '';

                CLEAR(LocGstNo);
                IF "Location Code" <> '' THEN BEGIN
                    IF LocationL.GET("Location Code") THEN
                        LocGstNo := LocationL."GST Registration No."
                    ELSE
                        LocGstNo := CompanyInformation."GST Registration No.";
                END ELSE
                    LocGstNo := CompanyInformation."GST Registration No.";

                IF CompanyInformation.Name <> 'PKF SRIDHAR & SANTHANAM LLP' THEN
                    IF CompanyInformation.Name <> 'PKF CONSULTING SERVICES LLP' THEN
                        IF PurPerson.GET("Purchaser Code") THEN BEGIN
                            PayCode := 'Responsible Person: ';
                            PurPersonName := PurPerson.Name;
                        END
                        ELSE
                            CLEAR(PurPersonName);



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

                IF CountryL.GET("Buy-from Country/Region Code") THEN
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
                    ToolTip = 'Specifies the value of the Rent field.';
                    ApplicationArea = All;
                }
                field(IsDuplicate; IsDuplicate)
                {
                    Caption = 'Duplicate';
                    ToolTip = 'Specifies the value of the Duplicate field.';
                    ApplicationArea = All;
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
        Vendor: Record Vendor;
        Customer: Record Customer;
        ServiceTax: Decimal;
        SBTax: Decimal;
        KKCTax: Decimal;
        SubTotal: Decimal;
        GrandTotal: Decimal;
        ReportCheck: Report Check;
        AmountInWords: array[2] of Text[80];
        CatofSer: Text;
        IsRent: Boolean;
        //ServTaxRegRec: Record "Service Tax Registration Nos.";
        //VarText: array[10] of Text;
        IsDuplicate: Boolean;
        DuplicateCap: Text;
        CurrencyCode: Code[10];
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
        LocGstNo: Code[20];
        RecLocation: Record Location;
        PayTerms: Record "Payment Terms";
        PayTermsDesc: Text[100];
        PayCode: Code[20];
        PurPersonName: Text[50];
        PurPerson: Record "Salesperson/Purchaser";
        PurchaseCode: Text[20];
        LocFax: Text[30];
        DiscountAmt: Decimal;
        GrossTotal: Decimal;
        RecPhone: Text[45];
        RecFax: Text[45];

    local procedure GetHsnDesc(GstGroupCode: Code[20]; HsnCode: Code[20]): Text
    var
        HSNSAC: Record "HSN/SAC";
    begin
        IF HSNSAC.GET(GstGroupCode, HsnCode) THEN
            EXIT(HSNSAC.Description);
    end;
}

