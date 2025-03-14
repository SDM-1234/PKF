/// <summary>
/// Report Responsible Person-wise (ID 50005).
/// </summary>
report 50005 "Responsible Person-wise"
{
    ApplicationArea = All;
    Caption = 'Responsible Person-wise';
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/ResponsiblePersonwise.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee; Employee)
        {
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code" = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                RequestFilterFields = "Date Filter";
                column(Employee_No; Employee."No.")
                {
                }
                column(Employee_FirstName; Employee."First Name")
                {
                }
                column(VarTlRes_Name; VarTlResName)
                {
                }
                column(GetCustomer_Name; CustRec.Name)
                {
                }
                column(LOB_Cust; LOB)
                {
                }
                column(Document_No; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Document_Date; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(txt_Year; txtYear)
                {
                }
                column(Invoice_Type; "Cust. Ledger Entry"."Invoice Types")
                {
                }
                column(MONTHNAMEWITH_YEAR; MONTHNAMEWITHYEAR)
                {
                }
                column(Branch_Code; "Cust. Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(Sales_Amt; "Cust. Ledger Entry"."Sales (LCY)")
                {
                }
                column(Service_Tax; SerTxAMT)
                {
                }
                column(SGST; VarSGST)
                {
                }
                column(CGST; VarCGST)
                {
                }
                column(IGST; VarIGST)
                {
                }
                column(Amount_Cust; "Cust. Ledger Entry"."Amount (LCY)")
                {
                }
                column(Remaining_Amt; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(Remarks_Cust; Remarks)
                {
                }
                column(GetCustomer_PrimaryIncharge; CustRec."Primary Incharge")
                {
                }
                column(GetCustomer_Group; CustRec.Group)
                {
                }
                column(Scope_Text; VarInvoice)
                {
                }
                column(Seg_Cust; "Cust. Ledger Entry".Segment)
                {
                }
                column(CLE_Doc_Type; "Cust. Ledger Entry"."Document Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Remarks);
                    CALCFIELDS(LOB);
                    CALCFIELDS("Invoice Types");
                    CALCFIELDS("Amount (LCY)");
                    CALCFIELDS("Remaining Amt. (LCY)");
                    CALCFIELDS(Segment);

                    IF ("Cust. Ledger Entry"."Due Date" > TODAY) OR ("Cust. Ledger Entry"."Remaining Amt. (LCY)" = 0) THEN
                        CurrReport.SKIP();


                    VarTlResName := '';
                    recCommendLine.RESET();
                    recCommendLine.SETRANGE(recCommendLine."No.", "Cust. Ledger Entry"."Document No.");
                    recCommendLine.SETRANGE(recCommendLine."Document Type", recCommendLine."Document Type"::"Posted Invoice");
                    recCommendLine.SETRANGE(recCommendLine.Type, recCommendLine.Type::Leader);
                    recCommendLine.SETRANGE(recCommendLine."Type Code", Employee."No.");
                    IF recCommendLine.FINDFIRST() THEN
                        VarTlResName := Employee."First Name";


                    CustRec.GET("Cust. Ledger Entry"."Customer No.");

                    SerTxAMT := 0;
                    IF ("Posting Date" < 20170107D) THEN
                        SerTxAMT := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Sales (LCY)";


                    //Paid := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Remaining Amt. (LCY)";
                    VarInvoice := '';
                    RecSalesInvoiceLine.RESET();
                    RecSalesInvoiceLine.SETRANGE(RecSalesInvoiceLine."Document No.", "Cust. Ledger Entry"."Document No.");
                    IF RecSalesInvoiceLine.FindSet() THEN
                        REPEAT
                            IF (RecSalesInvoiceLine.Scope1 <> '') THEN BEGIN
                                VarInvoice := INSSTR(VarInvoice, RecSalesInvoiceLine.Scope1, STRLEN(VarInvoice) + 1);
                                varSpace := '/';
                                VarInvoice := INSSTR(VarInvoice, varSpace, STRLEN(VarInvoice) + 1);
                            END;
                        UNTIL RecSalesInvoiceLine.NEXT() = 0;

                    intMonth := DATE2DMY("Cust. Ledger Entry"."Posting Date", 2);
                    intYear := DATE2DMY("Cust. Ledger Entry"."Posting Date", 3);

                    CLEAR(txtYear);
                    IF "Cust. Ledger Entry"."Posting Date" < 20120104D THEN
                        txtYear := 'Prior to 01.04.12'
                    ELSE
                        IF intMonth > 3 THEN
                            txtYear := FORMAT(intYear) + ' - ' + FORMAT(intYear + 1)
                        ELSE
                            txtYear := FORMAT(intYear - 1) + ' - ' + FORMAT(intYear);


                    MONTHNAMEWITHYEAR := '';


                    VarText := FORMAT("Posting Date");
                    VarText1 := COPYSTR(VarText, 4, 2);
                    VarText2 := COPYSTR(VarText, 7, 4);

                    case VarText1 of
                        '01':
                            VarText3 := 'JAN-';
                        '02':
                            VarText3 := 'FEB-';
                        '03':
                            VarText3 := 'MAR-';
                        '04':
                            VarText3 := 'APR-';
                        '05':
                            VarText3 := 'MAY-';
                        '06':
                            VarText3 := 'JUN-';
                        '07':
                            VarText3 := 'JUL-';
                        '08':
                            VarText3 := 'AUG-';
                        '09':
                            VarText3 := 'SEP-';
                        '10':
                            VarText3 := 'OCT-';
                        '11':
                            VarText3 := 'NOV-';
                        '12':
                            VarText3 := 'DEC-';
                    end;

                    MONTHNAMEWITHYEAR := VarText3 + VarText2;

                    VarCGST := 0;
                    VarSGST := 0;
                    VarIGST := 0;

                    RecGST.RESET();
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'SGST');
                    IF RecGST.FINDSET() THEN
                        VarSGST := -RecGST."GST Amount";

                    RecGST.RESET();
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'CGST');
                    IF RecGST.FINDSET() THEN
                        VarCGST := -RecGST."GST Amount";

                    RecGST.RESET();
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'IGST');
                    IF RecGST.FINDSET() THEN
                        VarIGST := -RecGST."GST Amount";
                end;
            }

            trigger OnPreDataItem()
            begin
                IF GetEmployeeNo <> '' THEN
                    SETRANGE(Employee."No.", GetEmployeeNo);
            end;
        }
    }

    var
        CustRec: Record Customer;
        recCommendLine: Record "Sales Comment Line";
        RecGST: Record "GST Ledger Entry";
        RecSalesInvoiceLine: Record "Sales Invoice Line";
        GetEmployeeNo: Code[20];
        SerTxAMT: Decimal;
        VarCGST: Decimal;
        VarIGST: Decimal;
        VarSGST: Decimal;
        intMonth: Integer;
        intYear: Integer;
        MONTHNAMEWITHYEAR: Text[30];
        txtYear: Text[30];
        VarInvoice: Text[1024];
        varSpace: Text[20];
        VarText1: Text[30];
        VarText2: Text[30];
        VarText3: Text[30];
        VarText: Text[30];
        VarTlResName: Text[30];


    procedure SetRecordsVar(SetEmployeeNo: Code[20])
    begin
        GetEmployeeNo := SetEmployeeNo;
    end;

}

