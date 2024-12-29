report 50005 "Responsible Person-wise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ResponsiblePersonwise.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = Salesperson Code=FIELD(No.);
                DataItemTableView = SORTING (Entry No.);
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

                    IF "Cust. Ledger Entry"."Due Date" > TODAY THEN BEGIN
                        CurrReport.SKIP;
                    END;
                    IF "Cust. Ledger Entry"."Remaining Amt. (LCY)" = 0 THEN BEGIN
                        CurrReport.SKIP;
                    END;

                    VarTlResName := '';
                    recCommendLine.RESET;
                    recCommendLine.SETRANGE(recCommendLine."No.", "Cust. Ledger Entry"."Document No.");
                    recCommendLine.SETRANGE(recCommendLine."Document Type", recCommendLine."Document Type"::"Posted Invoice");
                    recCommendLine.SETRANGE(recCommendLine.Type, recCommendLine.Type::Leader);
                    recCommendLine.SETRANGE(recCommendLine."Type Code", Employee."No.");
                    IF recCommendLine.FINDFIRST THEN BEGIN
                        VarTlResName := Employee."First Name";
                    END;

                    CustRec.GET("Cust. Ledger Entry"."Customer No.");

                    SerTxAMT := 0;
                    IF ("Posting Date" < 010717D) THEN BEGIN
                        SerTxAMT := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Sales (LCY)";
                    END;

                    Paid := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Remaining Amt. (LCY)";
                    VarInvoice := '';
                    RecSalesInvoiceLine.RESET;
                    RecSalesInvoiceLine.SETRANGE(RecSalesInvoiceLine."Document No.", "Cust. Ledger Entry"."Document No.");
                    IF RecSalesInvoiceLine.FIND('-') THEN
                        REPEAT
                            IF (RecSalesInvoiceLine.Scope1 <> '') THEN BEGIN
                                VarInvoice := INSSTR(VarInvoice, RecSalesInvoiceLine.Scope1, STRLEN(VarInvoice) + 1);
                                varSpace := '/';
                                VarInvoice := INSSTR(VarInvoice, varSpace, STRLEN(VarInvoice) + 1);
                            END;
                        UNTIL RecSalesInvoiceLine.NEXT = 0;

                    intMonth := DATE2DMY("Cust. Ledger Entry"."Posting Date", 2);
                    intYear := DATE2DMY("Cust. Ledger Entry"."Posting Date", 3);

                    CLEAR(txtYear);
                    IF "Cust. Ledger Entry"."Posting Date" < 010412D THEN
                        txtYear := 'Prior to 01.04.12'
                    ELSE BEGIN
                        IF intMonth > 3 THEN
                            txtYear := FORMAT(intYear) + ' - ' + FORMAT(intYear + 1)
                        ELSE
                            txtYear := FORMAT(intYear - 1) + ' - ' + FORMAT(intYear)
                    END;

                    MONTHNAMEWITHYEAR := '';


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

                    VarCGST := 0;
                    VarSGST := 0;
                    VarIGST := 0;

                    RecGST.RESET;
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'SGST');
                    IF RecGST.FINDSET THEN
                        VarSGST := -RecGST."GST Amount";

                    RecGST.RESET;
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'CGST');
                    IF RecGST.FINDSET THEN
                        VarCGST := -RecGST."GST Amount";

                    RecGST.RESET;
                    RecGST.SETRANGE(RecGST."Document No.", "Cust. Ledger Entry"."Document No.");
                    RecGST.SETRANGE(RecGST."Entry Type", RecGST."Entry Type"::"Initial Entry");
                    RecGST.SETRANGE(RecGST."GST Component Code", 'IGST');
                    IF RecGST.FINDSET THEN
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
        CustRec: Record Customer;
        Cust: Text[80];
        SalesInvRec: Record "Sales Invoice Header";
        EmpRec: Record Employee;
        UserRec: Record "User Setup";
        Paid: Decimal;
        LOB: Text[250];
        RecSalesInvL: Record "Sales Invoice Line";
        VarInvoice: Text[1024];
        varSpace: Text[20];
        RecSalesInvoiceLine: Record "Sales Invoice Line";
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer";
        MONTHNAMEWITHYEAR: Text[30];
        VarText: Text[30];
        VarText1: Text[30];
        VarText2: Text[30];
        VarText3: Text[30];
        recCommendLine: Record "Sales Comment Line";
        VarTlResName: Text[30];
        VarYear: Text[30];
        VarDate: Date;
        txtYear: Text[30];
        intYear: Integer;
        intMonth: Integer;
        GetEmployeeNo: Code[20];
        SerTxAMT: Decimal;
        RecGST: Record "GST Ledger Entry";
        VarCGST: Decimal;
        VarSGST: Decimal;
        VarIGST: Decimal;

    [Scope('Internal')]
    procedure SetRecordsVar(SetEmployeeNo: Code[20])
    begin
        GetEmployeeNo := SetEmployeeNo;
    end;
}

