report 50022 "Challan Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/ChallanBook.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Challan Book';


    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(BalAccountNo_GenJournalLine; "Gen. Journal Line"."Bal. Account No.")
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(AccountNo_GenJournalLine; "Gen. Journal Line"."Account No.")
            {
            }
            column(ChequeDate_GenJournalLine; "Gen. Journal Line"."Cheque Date")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_PhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyInformationE_Mail; CompanyInformation."E-Mail")
            {
            }
            column(GenJnlLine_CheqNo; "Gen. Journal Line"."External Document No.")
            {
            }
            column(AccNo1; AccountNo[1])
            {
            }
            column(AccNo2; AccountNo[2])
            {
            }
            column(AccNo3; AccountNo[3])
            {
            }
            column(AccNo4; AccountNo[4])
            {
            }
            column(AccNo5; AccountNo[5])
            {
            }
            column(AccNo6; AccountNo[6])
            {
            }
            column(AccNo7; AccountNo[7])
            {
            }
            column(AccNo8; AccountNo[8])
            {
            }
            column(AccNo9; AccountNo[9])
            {
            }
            column(AccNo10; AccountNo[10])
            {
            }
            column(AccNo11; AccountNo[11])
            {
            }
            column(AccNo12; AccountNo[12])
            {
            }
            column(AccNo13; AccountNo[13])
            {
            }
            column(AccNo14; AccountNo[14])
            {
            }
            column(AccNo15; AccountNo[15])
            {
            }
            column(AccNo16; AccountNo[16])
            {
            }
            column(AccNo17; AccountNo[17])
            {
            }
            column(AccNo18; AccountNo[18])
            {
            }
            column(AccNo19; AccountNo[19])
            {
            }
            column(AccNo20; AccountNo[20])
            {
            }
            column(PostDt1; PostingDT[1])
            {
            }
            column(PostDt2; PostingDT[2])
            {
            }
            column(PostDt3; PostingDT[3])
            {
            }
            column(PostDt4; PostingDT[4])
            {
            }
            column(PostDt5; PostingDT[5])
            {
            }
            column(PostDt6; PostingDT[6])
            {
            }
            column(PostDt7; PostingDT[7])
            {
            }
            column(PostDt8; PostingDT[8])
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line".Amount)
            {
            }
            column(Words1; TotalAmountInwords[1])
            {
            }
            column(Words2; TotalAmountInwords[2])
            {
            }
            column(DecimalPart; DecimalPart)
            {
            }
            column(Branch; Branch)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SegmentLength);
                CLEAR(i);
                CLEAR(j);

                IF BankAccount.GET("Account No.") THEN
                    AccNo := BankAccount."Bank Account No.";
                Branch := BankAccount.Address;
                SegmentLength := STRLEN(AccNo);
                FOR i := 1 TO SegmentLength DO
                    AccountNo[i] := COPYSTR(AccNo, i, 1);




                // Storing Check Date[-]
                //PosDate := "Gen. Journal Line"."Posting Date";
                ChequeDateFormat := FORMAT("Cheque Date", 0, '<Day,2><Month,2><Year4>');
                PosDateFormat := FORMAT("Posting Date", 0, '<Day,2><Month,2><Year4>');
                FOR j := 1 TO 8 DO BEGIN
                    PostingDT[j] := COPYSTR(PosDateFormat, j, 1);
                    ChequeDate[j] := COPYSTR(ChequeDateFormat, j, 1)
                END;
                // Storing Check Date[+]

                ReportCheck.InitTextVariable();
                ReportCheck.FormatNoText(TotalAmountInwords, Amount, '');


                DecimalPart := Amount MOD 1;
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

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
    end;

    var
        BankAccount: Record "Bank Account";
        CompanyInformation: Record "Company Information";
        ReportCheck: Codeunit AmountToWords;
        AccNo: Code[30];
        AccountNo: array[20] of Code[10];
        DecimalPart: Decimal;
        i: Integer;
        j: Integer;
        SegmentLength: Integer;
        Branch: Text;
        ChequeDate: array[12] of Text;
        ChequeDateFormat: Text;
        PosDateFormat: Text;
        PostingDT: array[12] of Text;
        TotalAmountInwords: array[2] of Text;
}

