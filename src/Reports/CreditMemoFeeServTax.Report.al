report 50017 "Credit Memo Fee Serv. Tax"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CreditMemoFeeServTax.rdlc';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            column(Document_No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(Posting_Date; FORMAT("Sales Cr.Memo Header"."Posting Date"))
            {
            }
            column(ExtDocNo; "Sales Cr.Memo Header"."External Document No.")
            {
            }
            column(Customer_No; "Sales Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(Customer_Name; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(Customer_Add; "Sales Cr.Memo Header"."Bill-to Address")
            {
            }
            column(Customer_Add_2; "Sales Cr.Memo Header"."Bill-to Address 2")
            {
            }
            column(Customer_City; "Sales Cr.Memo Header"."Bill-to City")
            {
            }
            column(Customer_PostCode; "Sales Cr.Memo Header"."Bill-to Post Code")
            {
            }
            column(Customer_Country; "Sales Cr.Memo Header"."Bill-to Country/Region Code")
            {
            }
            column(Remarks_Header; "Sales Cr.Memo Header".Remarks)
            {
            }
            column(Work_Order_No; "Sales Cr.Memo Header"."Work Order No.")
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
            column(Comp_FaxNo; CompanyInformation."Fax No.")
            {
            }
            column(Comp_PostCode; CompanyInformation."Post Code")
            {
            }
            column(Comp_PAN; CompanyInformation."P.A.N. No.")
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
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING (Document No., Line No.);
                column(LOB_Line; "Sales Cr.Memo Header".LOB)
                {
                }
                column(Segment_Line; "Sales Cr.Memo Header".Segment)
                {
                }
                column(Scope1_Line; "Sales Cr.Memo Line".Scope1)
                {
                }
                column(Scope2_Line; "Sales Cr.Memo Line".Scope2)
                {
                }
                column(Scope3_Line; "Sales Cr.Memo Line".Scope3)
                {
                }
                column(Scope4_Line; "Sales Cr.Memo Line".Scope4)
                {
                }
                column(Line_Amount; "Sales Cr.Memo Line"."Line Amount")
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
                column(ServTaxRegRec_Description; ServTaxRegRec.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ServTaxRegRec.GET(CompanyInformation."Service Tax Registration No.") THEN;

                    ServiceTax += "Service Tax Amount";
                    SBTax += "Service Tax SBC Amount";
                    KKCTax += "KK Cess Amount";
                    SubTotal += "Line Amount";
                    GrandTotal += "Line Amount" + "Service Tax Amount" + "Service Tax SBC Amount" + "KK Cess Amount";
                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(AmountInWords, GrandTotal, "Sales Cr.Memo Header"."Currency Code");

                    IF IsRent = TRUE THEN
                        CatofSer := 'RENTAL INCOME ON IMMOVABLE PROPERTIES'
                    ELSE
                        CatofSer := CompanyInformation."Industrial Classification";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Customer.GET("Bill-to Customer No.");
                BankDetails;

                IF "Sales Cr.Memo Header"."Currency Code" = '' THEN
                    CurrencyCode := 'INR'
                ELSE
                    CurrencyCode := "Currency Code"
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
                }
                field(IsDuplicate; IsDuplicate)
                {
                    Caption = 'Duplicate';
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
        CompanyInformation.GET;


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
        ReportCheck: Report Check;
        AmountInWords: array[2] of Text[80];
        CatofSer: Text;
        IsRent: Boolean;
        ServTaxRegRec: Record "Service Tax Registration Nos.";
        VarText: array[10] of Text;
        IsDuplicate: Boolean;
        DuplicateCap: Text;
        CurrencyCode: Code[10];
        GetSalesInvoiceHeader: Code[20];

    local procedure BankDetails()
    begin

        IF CompanyInformation.Name = 'PKF SRIDHAR & SANTHANAM LLP' THEN BEGIN
            IF "Sales Cr.Memo Header"."Customer Posting Group" = 'DOMESTIC' THEN BEGIN
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
            ELSE BEGIN
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
        END;

        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN BEGIN
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
    end;

    [Scope('Internal')]
    procedure SetRecordsVar(SetSalesInvoiceHeader: Code[20])
    begin
        GetSalesInvoiceHeader := SetSalesInvoiceHeader;
    end;
}

