// report 50018 "Credit Memo Expense GST"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './CreditMemoExpenseGST.rdlc';

//     dataset
//     {
//         dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
//         {
//             RequestFilterFields = "No.";
//             column(Document_No; "Sales Cr.Memo Header"."No.")
//             {
//             }
//             column(Posting_Date; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 1))
//             {
//             }
//             column(Customer_No; "Sales Cr.Memo Header"."Bill-to Customer No.")
//             {
//             }
//             column(Customer_Name; "Sales Cr.Memo Header"."Bill-to Name")
//             {
//             }
//             column(Customer_Add; "Sales Cr.Memo Header"."Bill-to Address")
//             {
//             }
//             column(Customer_Add_2; "Sales Cr.Memo Header"."Bill-to Address 2")
//             {
//             }
//             column(Customer_City; "Sales Cr.Memo Header"."Bill-to City")
//             {
//             }
//             column(Customer_PostCode; "Sales Cr.Memo Header"."Bill-to Post Code")
//             {
//             }
//             column(Customer_Country; CountryName)
//             {
//             }
//             column(Remarks_Header; "Sales Cr.Memo Header".Remarks)
//             {
//             }
//             column(Work_Order_No; "Sales Cr.Memo Header"."Work Order No.")
//             {
//             }
//             column(Customer_Contact; Customer.Contact)
//             {
//             }
//             column(Customer_Contact_Mobile; Customer."Contact Person Mob. No.")
//             {
//             }
//             column(Comp_Name; CompanyInformation.Name)
//             {
//             }
//             column(Comp_Add; CompanyInformation.Address)
//             {
//             }
//             column(Comp_Add_2; CompanyInformation."Address 2")
//             {
//             }
//             column(Comp_City; CompanyInformation.City)
//             {
//             }
//             column(Comp_PhoneNo; CompanyInformation."Phone No.")
//             {
//             }
//             column(Comp_FaxNo; CompanyInformation."Fax No.")
//             {
//             }
//             column(Comp_PostCode; CompanyInformation."Post Code")
//             {
//             }
//             column(Comp_PAN; CompanyInformation."P.A.N. No.")
//             {
//             }
//             column(Comp_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(RecLoc_Name; RecLocation.Name)
//             {
//             }
//             column(RecLoc_Add; RecLocation.Address)
//             {
//             }
//             column(RecLoc_Add2; RecLocation."Address 2")
//             {
//             }
//             column(RecLoc_City; RecLocation.City)
//             {
//             }
//             column(RecLoc_Phone; RecPhone)
//             {
//             }
//             column(RecLoc_Fax; RecFax)
//             {
//             }
//             column(RecLoc_PostCode; RecLocation."Post Code")
//             {
//             }
//             column(Currency_Code; CurrencyCode)
//             {
//             }
//             column(VarText_1; VarText[1])
//             {
//             }
//             column(VarText_2; VarText[2])
//             {
//             }
//             column(VarText_3; VarText[3])
//             {
//             }
//             column(VarText_4; VarText[4])
//             {
//             }
//             column(VarText_5; VarText[5])
//             {
//             }
//             column(VarText_6; VarText[6])
//             {
//             }
//             column(VarText_7; VarText[7])
//             {
//             }
//             column(VarText_8; VarText[8])
//             {
//             }
//             column(VarText_9; VarText[9])
//             {
//             }
//             column(VarText_10; VarText[10])
//             {
//             }
//             column(Duplicate_Cap; DuplicateCap)
//             {
//             }
//             column(ServTaxRegRec_Description; LocGstNo)
//             {
//             }
//             column(Cus_GST_No; Customer."GST Registration No.")
//             {
//             }
//             column(BilltoCustomerState_SalesInvoiceHeader; "Sales Cr.Memo Header"."Bill to Customer State")
//             {
//             }
//             column(MSMENo; MSMENo)
//             {
//             }
//             column(MSMEText; MSMEText)
//             {
//             }
//             column(StateName; StateName)
//             {
//             }
//             column(IRN; "IRN Hash")
//             {
//             }
//             column(QRCode; "QR Code")
//             {
//             }
//             dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
//             {
//                 DataItemLink = Document No.=FIELD(No.);
//                 DataItemTableView = SORTING (Document No., Line No.);
//                 column(LOB_Line; "Sales Cr.Memo Header".LOB)
//                 {
//                 }
//                 column(Segment_Line; "Sales Cr.Memo Header".Segment)
//                 {
//                 }
//                 column(Scope1_Line; "Sales Cr.Memo Line".Scope1)
//                 {
//                 }
//                 column(Scope2_Line; "Sales Cr.Memo Line".Scope2)
//                 {
//                 }
//                 column(Scope3_Line; "Sales Cr.Memo Line".Scope3)
//                 {
//                 }
//                 column(Scope4_Line; "Sales Cr.Memo Line".Scope4)
//                 {
//                 }
//                 column(Line_Amount; "Sales Cr.Memo Line"."Line Amount")
//                 {
//                 }
//                 column(Description; "Sales Cr.Memo Line".Description)
//                 {
//                 }
//                 column(Sub_Total; SubTotal)
//                 {
//                 }
//                 column(Service_Tax; ServiceTax)
//                 {
//                 }
//                 column(SB_Tax; SBTax)
//                 {
//                 }
//                 column(KKC_Tax; KKCTax)
//                 {
//                 }
//                 column(AmountInWords_1; AmountInWords[1])
//                 {
//                 }
//                 column(AmountInWords_2; AmountInWords[2])
//                 {
//                 }
//                 column(Grand_Total; ROUND(GrandTotal, 1))
//                 {
//                 }
//                 column(Catof_Ser; CatofSer)
//                 {
//                 }
//                 column(HSNSACCode_SalesInvoiceLine; "Sales Cr.Memo Line"."HSN/SAC Code")
//                 {
//                 }
//                 column(CGST_Rate; CGST_Rate)
//                 {
//                 }
//                 column(CGST_Amt; CGST_Amt)
//                 {
//                 }
//                 column(IGST_Rate; IGST_Rate)
//                 {
//                 }
//                 column(IGST_Amt; IGST_Amt)
//                 {
//                 }
//                 column(SGST_Rate; SGST_Rate)
//                 {
//                 }
//                 column(SGST_Amt; SGST_Amt)
//                 {
//                 }
//                 column(CR; FORMAT(CGST_Rate))
//                 {
//                 }
//                 column(SR; FORMAT(SGST_Rate))
//                 {
//                 }
//                 column(IR; FORMAT(IGST_Rate))
//                 {
//                 }
//                 column(TotCGST; TotCGST)
//                 {
//                 }
//                 column(TotSGST; TotSGST)
//                 {
//                 }
//                 column(TotIGST; TotIGST)
//                 {
//                 }
//                 column(SAC_Desc; GetHsnDesc("GST Group Code", "HSN/SAC Code"))
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//                 begin
//                     IF ServTaxRegRec.GET(CompanyInformation."Service Tax Registration No.") THEN;

//                     ServiceTax += "Service Tax Amount";
//                     SBTax += "Service Tax SBC Amount";
//                     KKCTax += "KK Cess Amount";
//                     SubTotal += "Line Amount";
//                     GrandTotal += "Sales Cr.Memo Line"."Amount To Customer";
//                     ReportCheck.InitTextVariable;
//                     ReportCheck.FormatNoText(AmountInWords, ROUND(GrandTotal, 1), "Sales Cr.Memo Header"."Currency Code");

//                     IF IsRent = TRUE THEN
//                         CatofSer := 'RENTAL INCOME ON IMMOVABLE PROPERTIES'
//                     ELSE
//                         CatofSer := CompanyInformation."Industrial Classification";

//                     //GST
//                     CGST_Rate := 0;
//                     CGST_Amt := 0;
//                     SGST_Rate := 0;
//                     SGST_Amt := 0;
//                     IGST_Rate := 0;
//                     IGST_Amt := 0;

//                     DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
//                     DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
//                     DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
//                     DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
//                     DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
//                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
//                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                         CGST_Rate := DetailedGSTLedgerEntry."GST %";
//                         CGST_Amt := DetailedGSTLedgerEntry."GST Amount";
//                     END;

//                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
//                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                         IGST_Rate := DetailedGSTLedgerEntry."GST %";
//                         IGST_Amt := DetailedGSTLedgerEntry."GST Amount";
//                     END;

//                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
//                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                         SGST_Rate := DetailedGSTLedgerEntry."GST %";
//                         SGST_Amt := DetailedGSTLedgerEntry."GST Amount";
//                     END;
//                     //GST

//                     //GST
//                     TotCGST += CGST_Amt;
//                     TotSGST += SGST_Amt;
//                     TotIGST += IGST_Amt;
//                     //GST
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     //GST
//                     TotCGST := 0;
//                     TotSGST := 0;
//                     TotIGST := 0;
//                     //GST
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 LocationL: Record Location;
//                 StateL: Record State;
//                 CountryL: Record "Country/Region";
//             begin
//                 RecLocation.GET("Location Code");
//                 Customer.GET("Bill-to Customer No.");
//                 BankDetails;

//                 IF RecLocation."Phone No." <> '' THEN
//                     RecPhone := 'Phone No.: ' + RecLocation."Phone No."
//                 ELSE
//                     RecPhone := '';

//                 IF RecLocation."Fax No." <> '' THEN
//                     RecFax := ', Fax No.: ' + RecLocation."Fax No."
//                 ELSE
//                     RecFax := '';

//                 IF "Sales Cr.Memo Header"."Currency Code" = '' THEN
//                     CurrencyCode := 'INR'
//                 ELSE
//                     CurrencyCode := "Currency Code";

//                 CLEAR(MSMENo);
//                 CLEAR(LocGstNo);
//                 IF "Sales Cr.Memo Header"."Location Code" <> '' THEN BEGIN
//                     IF LocationL.GET("Location Code") THEN BEGIN
//                         LocGstNo := LocationL."GST Registration No.";
//                         MSMENo := LocationL."MSME No.";
//                     END
//                     ELSE
//                         LocGstNo := CompanyInformation."GST Registration No.";
//                 END ELSE
//                     LocGstNo := CompanyInformation."GST Registration No.";

//                 IF MSMENo = '' THEN
//                     MSMEText := ''
//                 ELSE
//                     MSMEText := 'MSME No. :';

//                 IF StateL.GET("Sales Cr.Memo Header"."Bill to Customer State") THEN
//                     StateName := StateL.Description
//                 ELSE
//                     CLEAR(StateName);

//                 IF CountryL.GET("Bill-to Country/Region Code") THEN
//                     CountryName := CountryL.Name
//                 ELSE
//                     CLEAR(CountryName);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(IsRent; IsRent)
//                 {
//                     Caption = 'Rent';
//                 }
//                 field(IsDuplicate; IsDuplicate)
//                 {
//                     Caption = 'Duplicate';
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         CompanyInformation.GET;
//         CompanyInformation.CALCFIELDS(Picture);

//         IF IsDuplicate THEN
//             DuplicateCap := 'Duplicate'
//         ELSE
//             DuplicateCap := '';
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         Customer: Record Customer;
//         ServiceTax: Decimal;
//         SBTax: Decimal;
//         KKCTax: Decimal;
//         SubTotal: Decimal;
//         GrandTotal: Decimal;
//         ReportCheck: Report Check;
//         AmountInWords: array[2] of Text[80];
//         CatofSer: Text;
//         IsRent: Boolean;
//         ServTaxRegRec: Record "Service Tax Registration Nos.";
//         VarText: array[10] of Text;
//         IsDuplicate: Boolean;
//         DuplicateCap: Text;
//         CurrencyCode: Code[10];
//         LocGstNo: Code[20];
//         CGST_Rate: Decimal;
//         CGST_Amt: Decimal;
//         SGST_Rate: Decimal;
//         SGST_Amt: Decimal;
//         IGST_Rate: Decimal;
//         IGST_Amt: Decimal;
//         TotCGST: Decimal;
//         TotSGST: Decimal;
//         TotIGST: Decimal;
//         StateName: Text[50];
//         CountryName: Text[50];
//         RecLocation: Record Location;
//         MSMENo: Code[20];
//         MSMEText: Text[10];
//         RecPhone: Text[45];
//         RecFax: Text[45];

//     local procedure BankDetails()
//     begin

//         IF CompanyInformation.Name = 'PKF SRIDHAR & SANTHANAM LLP' THEN BEGIN
//             IF "Sales Cr.Memo Header"."Customer Posting Group" = 'DOMESTIC' THEN BEGIN
//                 VarText[10] := 'Bank Details:';
//                 VarText[1] := 'INDIAN BANK ACCOUNT NO: 6343272369';
//                 VarText[2] := 'Name: PKF SRIDHAR & SANTHANAM LLP';
//                 VarText[3] := 'Bank Address: NO: 123, JAMMI BUILDING ,V M STREET, Dr. Radhakrishnan';
//                 VarText[4] := 'salai, MYLAPORE CHENNAI-600 004, TAMIL NADU, INDIA.';
//                 VarText[5] := 'IFS Code(for RTGS): IDIB000 D035';
//                 VarText[6] := '';
//                 VarText[7] := '';
//                 VarText[8] := '';
//                 VarText[9] := '';
//             END
//             ELSE BEGIN
//                 VarText[10] := 'Bank Details:';
//                 VarText[1] := 'Bank Name: HDFC BANK LIMITED';
//                 VarText[2] := 'Beneficiary Account No. : 12842000001490';
//                 VarText[3] := 'Beneficiary Name and address: PKF SRIDHAR AND SANTHANAM LLP';
//                 VarText[4] := 'KRD GEE GEE Crystal, No. 91-92, 7th Floor, Dr. Radhakrishnan Salai,';
//                 VarText[5] := 'Mylapore, Chennai - 600 004';
//                 VarText[6] := 'Beneficiary Branch Address: HDFC BANK LIMITED, NO.5, Sait Colony,';
//                 VarText[7] := '1st Street, Egmore, Chennai - 600 008';
//                 VarText[8] := 'Beneficiary bank swift code: HDFCINBBCHE';
//                 VarText[9] := 'IFSC Code: HDFC 000 1284';
//             END;
//         END;

//         IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN BEGIN
//             IF "Sales Cr.Memo Header"."Location Code" = 'MUM' THEN BEGIN
//                 VarText[10] := 'Bank Details:';
//                 VarText[1] := 'Bank Account No. 003605001058';
//                 VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
//                 VarText[3] := 'Bank: ICICI Bank';
//                 VarText[4] := 'Branch: Maratha Mandir';
//                 VarText[5] := 'IFSC: ICIC0000036';
//                 VarText[6] := 'SWIFT Code: ICICNBBCTS';
//                 VarText[7] := '';
//                 VarText[8] := '';
//                 VarText[9] := '';
//             END ELSE
//                 IF "Sales Cr.Memo Header"."Location Code" = 'CHN' THEN BEGIN
//                     VarText[10] := 'Bank Details:';
//                     VarText[1] := 'Bank Account No. 000105006757';
//                     VarText[2] := 'A/c Name: PKF PROSERV PRIVATE LIMITED';
//                     VarText[3] := 'Bank: ICICI BANK';
//                     VarText[4] := 'Branch: CENOTAPH ROAD, CHENNAI';
//                     VarText[5] := 'IFSC: ICIC0000001';
//                     VarText[6] := 'SWIFT Code: ICICNBBCTS';
//                     VarText[7] := '';
//                     VarText[8] := '';
//                     VarText[9] := '';
//                 END
//         END;

//         IF CompanyInformation.Name = 'PROBOTIQ SOLUTIONS PRIVATE LIMITED' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 6654304183';
//             VarText[2] := 'A/c Name: PROBOTIQ SOLUTIONS PRIVATE LIMITED';
//             VarText[3] := 'Bank: Indian Bank';
//             VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
//             VarText[5] := 'Address: Jammi Building, No.123, V.M. Street,';
//             VarText[6] := 'Mylapore, Chennai - 600 004';
//             VarText[7] := 'IFSC: IDIB000D035';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'SANDS CHEMBUR PROPERTIES PRIVATE LIMITED' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 6570927746';
//             VarText[2] := 'A/c Name: SANDS CHEMBUR PROPERTIES PRIVATE LIMITED';
//             VarText[3] := 'Bank: Indian Bank';
//             VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
//             VarText[5] := 'Address: Jammi Building, No.123, V.M. Street,';
//             VarText[6] := 'Mylapore, Chennai - 600 004';
//             VarText[7] := 'IFSC: IDIB000D035';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'SANDS BKC PROPERTIES PVT LTD' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 602205044134';
//             VarText[2] := 'A/c Name: SANDS BKC PROPERTIES LIMITED';
//             VarText[3] := 'Bank: ICICI Bank';
//             VarText[4] := 'Branch Address: 200/1, R.H. Road,';
//             VarText[5] := 'Mylapore, Chennai - 600 004';
//             VarText[6] := 'IFSC: ICIC0006022';
//             VarText[7] := '';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'PKF CONSULTING PRIVATE LIMITED' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 11000200090188';
//             VarText[2] := 'A/c Name: PKF CONSULTING PRIVATE LIMITED';
//             VarText[3] := 'Bank: The Federal Bank Limited';
//             VarText[4] := 'Branch Address: Mount Road, Chennai - 600 002';
//             VarText[5] := 'IFSC: FDRL0001100';
//             VarText[6] := '';
//             VarText[7] := '';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'CHANDRASEKHARA HOLDINGS (CHENNAI) PRIVATE LIMITED' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 000105009303';
//             VarText[2] := 'A/c Name: CHANDRASHEKHARA HOLDINGS (CHENNAI) P LTD';
//             VarText[3] := 'Bank: ICICI Bank';
//             VarText[4] := 'Branch Address: No.1, Cenotaph Road,';
//             VarText[5] := 'Chennai - 600 018';
//             VarText[6] := 'IFSC: ICIC0000001';
//             VarText[7] := '';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'SANDS BANGALORE PROPERTIES (P) LTD' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 602205045239';
//             VarText[2] := 'A/c Name: SANDS BANGALORE PROPERTIES PRIVATE LIMITED';
//             VarText[3] := 'Bank: ICICI Bank';
//             VarText[4] := 'Branch Address: 200/1, R.H. Road,';
//             VarText[5] := 'Mylapore, Chennai - 600 004';
//             VarText[6] := 'IFSC: ICIC0006022';
//             VarText[7] := '';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'PKF CONSULTING SERVICES LLP' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 003605006317';
//             VarText[2] := 'A/c Name: PKF CONSULTING SERVICES LLP';
//             VarText[3] := 'Bank: ICICI Bank';
//             VarText[4] := 'Branch Address: Maratha Mandir Annex,';
//             VarText[5] := 'Dr. Anand Rao Nair Road,';
//             VarText[6] := 'Opp. Mumbai Central Station,';
//             VarText[7] := 'Mumbai - 400008';
//             VarText[8] := 'IFSC: ICIC0000036';
//             VarText[9] := '';
//         END;

//         IF CompanyInformation.Name = 'THREE D RESTRUCTRUING AND RESOLUTION SERVICES LLP' THEN BEGIN
//             VarText[10] := 'Bank Details:';
//             VarText[1] := 'Bank Account No. 6666058008';
//             VarText[2] := 'A/c Name: THREE D RESTRUCTRUING AND RESOLUTION SERVICES LLP';
//             VarText[3] := 'Bank: Indian Bank';
//             VarText[4] := 'Branch: Dr. Radhakrishnan Salai';
//             VarText[5] := 'IFSC: IDIB000D035';
//             VarText[6] := '';
//             VarText[7] := '';
//             VarText[8] := '';
//             VarText[9] := '';
//         END;
//     end;

//     local procedure GetHsnDesc(GstGroupCode: Code[20]; HsnCode: Code[20]): Text
//     var
//         HSNSAC: Record "HSN/SAC";
//     begin
//         IF HSNSAC.GET(GstGroupCode, HsnCode) THEN
//             EXIT(HSNSAC.Description);
//     end;
// }

