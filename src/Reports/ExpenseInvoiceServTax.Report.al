report 50002 "Expense Invoice Serv. Tax"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ExpenseInvoiceServTax.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Document_No; "Sales Invoice Header"."No.")
            {
            }
            column(Posting_Date; FORMAT("Sales Invoice Header"."Posting Date"))
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
            column(Customer_Country; "Sales Invoice Header"."Bill-to Country/Region Code")
            {
            }
            column(Remarks_Header; "Sales Invoice Header".Remarks)
            {
            }
            column(Work_Order_No; "Sales Invoice Header"."Work Order No.")
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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING (Document No., Line No.);
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
                column(Description; "Sales Invoice Line".Description)
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
                    ReportCheck.FormatNoText(AmountInWords, GrandTotal, "Sales Invoice Header"."Currency Code");

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
                IF "Sales Invoice Header"."Currency Code" = '' THEN
                    CurrencyCode := 'INR'
                ELSE
                    CurrencyCode := "Currency Code"
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

    local procedure BankDetails()
    begin

        IF CompanyInformation.Name = 'PKF SRIDHAR & SANTHANAM LLP' THEN BEGIN
            IF "Sales Invoice Header"."Customer Posting Group" = 'DOMESTIC' THEN BEGIN
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
}

