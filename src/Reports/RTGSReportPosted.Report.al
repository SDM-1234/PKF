report 50021 "RTGS Report Posted"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RTGSReportPosted.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING (Document No., Posting Date) ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(Cheque; Cheque)
            {
            }
            column(CheckDate; FORMAT(CheckDate))
            {
            }
            column(DocumentNo_GenJnlLine; "G/L Entry"."Document No.")
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(BankLogo; CompanyInformation."Bank Logo")
            {
            }
            column(PayeeName; PayeeName)
            {
            }
            column(Narrations_Val; VarNarration)
            {
            }
            column(BankAccount_No; BankAccountNo)
            {
            }
            column(BankAccount_Name; BankAccountName)
            {
            }
            column(BankAccAdress2; BankAccAdress2)
            {
            }
            column(Check_No; CheckNo)
            {
            }
            column(Check_Date; FORMAT(CheckDate))
            {
            }
            column(Bank_Amount; BankAmount)
            {
            }
            column(TotalAmountInwords_1; TotalAmountInwords[1])
            {
            }
            column(TotalAmountInwords_2; TotalAmountInwords[2])
            {
            }
            column(TotalNet_Amount; TotalNetAmount)
            {
            }
            column(CheckNo; CheckNo)
            {
            }
            column(ChequeDateFormat; ChequeDateFormat)
            {
            }
            column(StoreDate_1; StoreDate[1])
            {
            }
            column(StoreDate_2; StoreDate[2])
            {
            }
            column(StoreDate_3; StoreDate[3])
            {
            }
            column(StoreDate_4; StoreDate[4])
            {
            }
            column(StoreDate_5; StoreDate[5])
            {
            }
            column(StoreDate_6; StoreDate[6])
            {
            }
            column(StoreDate_7; StoreDate[7])
            {
            }
            column(StoreDate_8; StoreDate[8])
            {
            }
            column(VendInfo_1; VendInfo[1])
            {
            }
            column(VendInfo_2; VendInfo[2])
            {
            }
            column(VendInfo_4; VendInfo[4])
            {
            }
            column(VendInfo_3; VendInfo[3])
            {
            }
            column(VendInfo_5; VendInfo[5])
            {
            }
            column(Posting_Date; FORMAT(RecGenJounLine."Posting Date"))
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Account_No; "G/L Entry"."G/L Account No.")
            {
            }
            column(Description_Val; Description)
            {
            }
            column(Debit_Amount; DebitAmount)
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(LineNo_GenJournalLine; "G/L Entry"."Entry No.")
            {
            }
            column(PANNo_1; PANNO[1])
            {
            }
            column(PANNo_2; PANNO[2])
            {
            }
            column(PANNo_3; PANNO[3])
            {
            }
            column(PANNo_4; PANNO[4])
            {
            }
            column(PANNo_5; PANNO[5])
            {
            }
            column(PANNo_6; PANNO[6])
            {
            }
            column(PANNo_7; PANNO[7])
            {
            }
            column(PANNo_8; PANNO[8])
            {
            }
            column(PANNo_9; PANNO[9])
            {
            }
            column(PANNo_10; PANNO[10])
            {
            }
            column(RemitterName_1; RemitterName[1])
            {
            }
            column(RemitterName_2; RemitterName[2])
            {
            }
            column(RemitterName_3; RemitterName[3])
            {
            }
            column(RemitterName_4; RemitterName[4])
            {
            }
            column(RemitterName_5; RemitterName[5])
            {
            }
            column(RemitterName_6; RemitterName[6])
            {
            }
            column(RemitterName_7; RemitterName[7])
            {
            }
            column(RemitterName_8; RemitterName[8])
            {
            }
            column(RemitterName_9; RemitterName[9])
            {
            }
            column(RemitterName_10; RemitterName[10])
            {
            }
            column(RemitterName_11; RemitterName[11])
            {
            }
            column(RemitterName_12; RemitterName[12])
            {
            }
            column(RemitterName_13; RemitterName[13])
            {
            }
            column(RemitterName_14; RemitterName[14])
            {
            }
            column(RemitterName_15; RemitterName[15])
            {
            }
            column(RemitterName_16; RemitterName[16])
            {
            }
            column(RemitterName_17; RemitterName[17])
            {
            }
            column(RemitterName_18; RemitterName[18])
            {
            }
            column(RemitterName_19; RemitterName[19])
            {
            }
            column(RemitterName_20; RemitterName[20])
            {
            }
            column(RemitterName_21; RemitterName[21])
            {
            }
            column(RemitterName_22; RemitterName[22])
            {
            }
            column(RemitterName_23; RemitterName[23])
            {
            }
            column(RemitterName_24; RemitterName[24])
            {
            }
            column(RemitterName_25; RemitterName[25])
            {
            }
            column(RemitterName_26; RemitterName[26])
            {
            }
            column(RemitterName_27; RemitterName[27])
            {
            }
            column(RemitterName_28; RemitterName[28])
            {
            }
            column(CompAddress_1; CompAddress[1])
            {
            }
            column(CompAddress_2; CompAddress[2])
            {
            }
            column(CompAddress_3; CompAddress[3])
            {
            }
            column(CompAddress_4; CompAddress[4])
            {
            }
            column(CompAddress_5; CompAddress[5])
            {
            }
            column(CompAddress_6; CompAddress[6])
            {
            }
            column(CompAddress_7; CompAddress[7])
            {
            }
            column(CompAddress_8; CompAddress[8])
            {
            }
            column(CompAddress_9; CompAddress[9])
            {
            }
            column(CompAddress_10; CompAddress[10])
            {
            }
            column(CompAddress_11; CompAddress[11])
            {
            }
            column(CompAddress_12; CompAddress[12])
            {
            }
            column(CompAddress_13; CompAddress[13])
            {
            }
            column(CompAddress_14; CompAddress[14])
            {
            }
            column(CompAddress_15; CompAddress[15])
            {
            }
            column(CompAddress_16; CompAddress[16])
            {
            }
            column(CompAddress_17; CompAddress[17])
            {
            }
            column(CompAddress_18; CompAddress[18])
            {
            }
            column(CompAddress_19; CompAddress[19])
            {
            }
            column(CompAddress_20; CompAddress[20])
            {
            }
            column(CompAddress_21; CompAddress[21])
            {
            }
            column(CompAddress_22; CompAddress[22])
            {
            }
            column(CompAddress_23; CompAddress[23])
            {
            }
            column(CompAddress_24; CompAddress[24])
            {
            }
            column(CompAddress_25; CompAddress[25])
            {
            }
            column(CompAddress_26; CompAddress[26])
            {
            }
            column(CompAddress_27; CompAddress[27])
            {
            }
            column(CompAddress_28; CompAddress[28])
            {
            }
            column(CompAddress_29; CompAddress[29])
            {
            }
            column(CompAddress_30; CompAddress[30])
            {
            }
            column(CompAddress_31; CompAddress[31])
            {
            }
            column(CompAddress_32; CompAddress[32])
            {
            }
            column(CompAddress_33; CompAddress[33])
            {
            }
            column(CompAddress_34; CompAddress[34])
            {
            }
            column(CompAddress_35; CompAddress[35])
            {
            }
            column(CompAddress_36; CompAddress[36])
            {
            }
            column(CompAddress_37; CompAddress[37])
            {
            }
            column(CompAddress_38; CompAddress[38])
            {
            }
            column(CompAddress_39; CompAddress[39])
            {
            }
            column(CompAddress_40; CompAddress[40])
            {
            }
            column(CompAddress_41; CompAddress[41])
            {
            }
            column(CompAddress_42; CompAddress[42])
            {
            }
            column(CompAddress_43; CompAddress[43])
            {
            }
            column(CompAddress_44; CompAddress[44])
            {
            }
            column(CompAddress_45; CompAddress[45])
            {
            }
            column(CompAddress_46; CompAddress[46])
            {
            }
            column(CompAddress_47; CompAddress[47])
            {
            }
            column(CompAddress_48; CompAddress[48])
            {
            }
            column(CompAddress_49; CompAddress[49])
            {
            }
            column(CompAddress_50; CompAddress[50])
            {
            }
            column(StoreApplicantAccNo_1; StoreApplicantAccNo[1])
            {
            }
            column(StoreApplicantAccNo_2; StoreApplicantAccNo[2])
            {
            }
            column(StoreApplicantAccNo_3; StoreApplicantAccNo[3])
            {
            }
            column(StoreApplicantAccNo_4; StoreApplicantAccNo[4])
            {
            }
            column(StoreApplicantAccNo_5; StoreApplicantAccNo[5])
            {
            }
            column(StoreApplicantAccNo_6; StoreApplicantAccNo[6])
            {
            }
            column(StoreApplicantAccNo_7; StoreApplicantAccNo[7])
            {
            }
            column(StoreApplicantAccNo_8; StoreApplicantAccNo[8])
            {
            }
            column(StoreApplicantAccNo_9; StoreApplicantAccNo[9])
            {
            }
            column(StoreApplicantAccNo_10; StoreApplicantAccNo[10])
            {
            }
            column(StoreApplicantAccNo_11; StoreApplicantAccNo[11])
            {
            }
            column(StoreApplicantAccNo_12; StoreApplicantAccNo[12])
            {
            }
            column(StoreApplicantAccNo_13; StoreApplicantAccNo[13])
            {
            }
            column(StoreApplicantAccNo_14; StoreApplicantAccNo[14])
            {
            }
            column(StoreApplicantAccNo_15; StoreApplicantAccNo[15])
            {
            }
            column(StoreApplicantAccNo_16; StoreApplicantAccNo[16])
            {
            }
            column(StoreCheckNo_1; StoreCheckNo[1])
            {
            }
            column(StoreCheckNo_2; StoreCheckNo[2])
            {
            }
            column(StoreCheckNo_3; StoreCheckNo[3])
            {
            }
            column(StoreCheckNo_4; StoreCheckNo[4])
            {
            }
            column(StoreCheckNo_5; StoreCheckNo[5])
            {
            }
            column(StoreCheckNo_6; StoreCheckNo[6])
            {
            }
            column(StoreCheckNo_7; StoreCheckNo[7])
            {
            }
            column(StoreCheckNo_8; StoreCheckNo[8])
            {
            }
            column(StoreCheckNo_9; StoreCheckNo[9])
            {
            }
            column(StoreCheckNo_10; StoreCheckNo[10])
            {
            }
            column(BeneficiaryAcNo_1; BeneficiaryAcNo[1])
            {
            }
            column(BeneficiaryAcNo_2; BeneficiaryAcNo[2])
            {
            }
            column(BeneficiaryAcNo_3; BeneficiaryAcNo[3])
            {
            }
            column(BeneficiaryAcNo_4; BeneficiaryAcNo[4])
            {
            }
            column(BeneficiaryAcNo_5; BeneficiaryAcNo[5])
            {
            }
            column(BeneficiaryAcNo_6; BeneficiaryAcNo[6])
            {
            }
            column(BeneficiaryAcNo_7; BeneficiaryAcNo[7])
            {
            }
            column(BeneficiaryAcNo_8; BeneficiaryAcNo[8])
            {
            }
            column(BeneficiaryAcNo_9; BeneficiaryAcNo[9])
            {
            }
            column(BeneficiaryAcNo_10; BeneficiaryAcNo[10])
            {
            }
            column(BeneficiaryAcNo_11; BeneficiaryAcNo[11])
            {
            }
            column(BeneficiaryAcNo_12; BeneficiaryAcNo[12])
            {
            }
            column(BeneficiaryAcNo_13; BeneficiaryAcNo[13])
            {
            }
            column(BeneficiaryAcNo_14; BeneficiaryAcNo[14])
            {
            }
            column(BeneficiaryAcNo_15; BeneficiaryAcNo[15])
            {
            }
            column(BeneficiaryAcNo_16; BeneficiaryAcNo[16])
            {
            }
            column(BeneficiaryAcNo_17; BeneficiaryAcNo[17])
            {
            }
            column(BeneficiaryAcNo_18; BeneficiaryAcNo[18])
            {
            }
            column(BeneficiaryAcNo_19; BeneficiaryAcNo[19])
            {
            }
            column(BeneficiaryAcNo_20; BeneficiaryAcNo[20])
            {
            }
            column(BeneficiaryAcNo_21; BeneficiaryAcNo[21])
            {
            }
            column(BeneficiaryName_1; BeneficiaryName[1])
            {
            }
            column(BeneficiaryName_2; BeneficiaryName[2])
            {
            }
            column(BeneficiaryName_3; BeneficiaryName[3])
            {
            }
            column(BeneficiaryName_4; BeneficiaryName[4])
            {
            }
            column(BeneficiaryName_5; BeneficiaryName[5])
            {
            }
            column(BeneficiaryName_6; BeneficiaryName[6])
            {
            }
            column(BeneficiaryName_7; BeneficiaryName[7])
            {
            }
            column(BeneficiaryName_8; BeneficiaryName[8])
            {
            }
            column(BeneficiaryName_9; BeneficiaryName[9])
            {
            }
            column(BeneficiaryName_10; BeneficiaryName[10])
            {
            }
            column(BeneficiaryName_11; BeneficiaryName[11])
            {
            }
            column(BeneficiaryName_12; BeneficiaryName[12])
            {
            }
            column(BeneficiaryName_13; BeneficiaryName[13])
            {
            }
            column(BeneficiaryName_14; BeneficiaryName[14])
            {
            }
            column(BeneficiaryName_15; BeneficiaryName[15])
            {
            }
            column(BeneficiaryName_16; BeneficiaryName[16])
            {
            }
            column(BeneficiaryName_17; BeneficiaryName[17])
            {
            }
            column(BeneficiaryName_18; BeneficiaryName[18])
            {
            }
            column(BeneficiaryName_19; BeneficiaryName[19])
            {
            }
            column(BeneficiaryName_20; BeneficiaryName[20])
            {
            }
            column(BeneficiaryName_21; BeneficiaryName[21])
            {
            }
            column(BeneficiaryName_22; BeneficiaryName[22])
            {
            }
            column(BeneficiaryName_23; BeneficiaryName[23])
            {
            }
            column(BeneficiaryName_24; BeneficiaryName[24])
            {
            }
            column(BeneficiaryName_25; BeneficiaryName[25])
            {
            }
            column(BeneficiaryName_26; BeneficiaryName[26])
            {
            }
            column(BeneficiaryName_27; BeneficiaryName[27])
            {
            }
            column(BeneficiaryName_28; BeneficiaryName[28])
            {
            }
            column(BeneficiaryName_29; BeneficiaryName[29])
            {
            }
            column(BeneficiaryName_30; BeneficiaryName[30])
            {
            }
            column(BeneficiaryName_31; BeneficiaryName[31])
            {
            }
            column(BeneficiaryName_32; BeneficiaryName[32])
            {
            }
            column(BeneficiaryName_33; BeneficiaryName[33])
            {
            }
            column(BeneficiaryName_34; BeneficiaryName[34])
            {
            }
            column(BeneficiaryName_35; BeneficiaryName[35])
            {
            }
            column(BeneficiaryName_36; BeneficiaryName[36])
            {
            }
            column(BeneficiaryName_37; BeneficiaryName[37])
            {
            }
            column(BeneficiaryName_38; BeneficiaryName[38])
            {
            }
            column(BeneficiaryName_39; BeneficiaryName[39])
            {
            }
            column(BeneficiaryName_40; BeneficiaryName[40])
            {
            }
            column(BeneficiaryName_41; BeneficiaryName[41])
            {
            }
            column(BeneficiaryName_42; BeneficiaryName[42])
            {
            }
            column(BeneficiaryName_43; BeneficiaryName[43])
            {
            }
            column(BeneficiaryName_44; BeneficiaryName[44])
            {
            }
            column(BeneficiaryName_45; BeneficiaryName[45])
            {
            }
            column(BeneficiaryName_46; BeneficiaryName[46])
            {
            }
            column(BeneficiaryName_47; BeneficiaryName[47])
            {
            }
            column(BeneficiaryName_48; BeneficiaryName[48])
            {
            }
            column(BeneficiaryName_49; BeneficiaryName[49])
            {
            }
            column(BeneficiaryName_50; BeneficiaryName[50])
            {
            }
            column(BeneficiaryBankName_1; BeneficiaryBankName[1])
            {
            }
            column(BeneficiaryBankName_2; BeneficiaryBankName[2])
            {
            }
            column(BeneficiaryBankName_3; BeneficiaryBankName[3])
            {
            }
            column(BeneficiaryBankName_4; BeneficiaryBankName[4])
            {
            }
            column(BeneficiaryBankName_5; BeneficiaryBankName[5])
            {
            }
            column(BeneficiaryBankName_6; BeneficiaryBankName[6])
            {
            }
            column(BeneficiaryBankName_7; BeneficiaryBankName[7])
            {
            }
            column(BeneficiaryBankName_8; BeneficiaryBankName[8])
            {
            }
            column(BeneficiaryBankName_9; BeneficiaryBankName[9])
            {
            }
            column(BeneficiaryBankName_10; BeneficiaryBankName[10])
            {
            }
            column(BeneficiaryBankName_11; BeneficiaryBankName[11])
            {
            }
            column(BeneficiaryBankName_12; BeneficiaryBankName[12])
            {
            }
            column(BeneficiaryBankName_13; BeneficiaryBankName[13])
            {
            }
            column(BeneficiaryBankName_14; BeneficiaryBankName[14])
            {
            }
            column(BeneficiaryBankName_15; BeneficiaryBankName[15])
            {
            }
            column(BeneficiaryBankName_16; BeneficiaryBankName[16])
            {
            }
            column(BeneficiaryBankName_17; BeneficiaryBankName[17])
            {
            }
            column(BeneficiaryBankName_18; BeneficiaryBankName[18])
            {
            }
            column(BeneficiaryBankName_19; BeneficiaryBankName[19])
            {
            }
            column(BeneficiaryBankName_20; BeneficiaryBankName[20])
            {
            }
            column(BeneficiaryIFSC_1; BeneficiaryIFSC[1])
            {
            }
            column(BeneficiaryIFSC_2; BeneficiaryIFSC[2])
            {
            }
            column(BeneficiaryIFSC_3; BeneficiaryIFSC[3])
            {
            }
            column(BeneficiaryIFSC_4; BeneficiaryIFSC[4])
            {
            }
            column(BeneficiaryIFSC_5; BeneficiaryIFSC[5])
            {
            }
            column(BeneficiaryIFSC_6; BeneficiaryIFSC[6])
            {
            }
            column(BeneficiaryIFSC_7; BeneficiaryIFSC[7])
            {
            }
            column(BeneficiaryIFSC_8; BeneficiaryIFSC[8])
            {
            }
            column(BeneficiaryIFSC_9; BeneficiaryIFSC[9])
            {
            }
            column(BeneficiaryIFSC_10; BeneficiaryIFSC[10])
            {
            }
            column(BeneficiaryIFSC_11; BeneficiaryIFSC[11])
            {
            }
            column(BeneficiaryAddr_1; BeneficiaryAddr[1])
            {
            }
            column(BeneficiaryAddr_2; BeneficiaryAddr[2])
            {
            }
            column(BeneficiaryAddr_3; BeneficiaryAddr[3])
            {
            }
            column(BeneficiaryAddr_4; BeneficiaryAddr[4])
            {
            }
            column(BeneficiaryAddr_5; BeneficiaryAddr[5])
            {
            }
            column(BeneficiaryAddr_6; BeneficiaryAddr[6])
            {
            }
            column(BeneficiaryAddr_7; BeneficiaryAddr[7])
            {
            }
            column(BeneficiaryAddr_8; BeneficiaryAddr[8])
            {
            }
            column(BeneficiaryAddr_9; BeneficiaryAddr[9])
            {
            }
            column(BeneficiaryAddr_10; BeneficiaryAddr[10])
            {
            }
            column(BeneficiaryAddr_11; BeneficiaryAddr[11])
            {
            }
            column(BeneficiaryAddr_12; BeneficiaryAddr[12])
            {
            }
            column(BeneficiaryAddr_13; BeneficiaryAddr[13])
            {
            }
            column(BeneficiaryAddr_14; BeneficiaryAddr[14])
            {
            }
            column(BeneficiaryAddr_15; BeneficiaryAddr[15])
            {
            }
            column(BeneficiaryAddr_16; BeneficiaryAddr[16])
            {
            }
            column(BeneficiaryAddr_17; BeneficiaryAddr[17])
            {
            }
            column(BeneficiaryAddr_18; BeneficiaryAddr[18])
            {
            }
            column(BeneficiaryAddr_19; BeneficiaryAddr[19])
            {
            }
            column(BeneficiaryAddr_20; BeneficiaryAddr[20])
            {
            }
            column(BeneficiaryAddr_21; BeneficiaryAddr[21])
            {
            }
            column(BeneficiaryAddr_22; BeneficiaryAddr[22])
            {
            }
            column(BeneficiaryAddr_23; BeneficiaryAddr[23])
            {
            }
            column(BeneficiaryAddr_24; BeneficiaryAddr[24])
            {
            }
            column(BeneficiaryAddr_25; BeneficiaryAddr[25])
            {
            }
            column(BeneficiaryAddr_26; BeneficiaryAddr[24])
            {
            }
            column(BeneficiaryAddr_27; BeneficiaryAddr[25])
            {
            }

            trigger OnAfterGetRecord()
            begin
                Cheque := TRUE;
                IF DocumentNo <> "G/L Entry"."Document No." THEN BEGIN

                    BankAccountNo := '';
                    BankAccountName := '';
                    CheckNo := '';
                    CheckDate := 0D;
                    CLEAR(DebitAmount);

                    ChequeDateFormat := '';
                    PostingDateFormat := '';

                    CLEAR(StoreDate);
                    CLEAR(StoreApplicantAccNo);


                    CLEAR(RTGSDebAmt);
                    CLEAR(RTGSCreAmt);

                    CLEAR(BeneficiaryAcNoLength);
                    CLEAR(BeneficiaryNameLength);
                    CLEAR(BeneficiaryBankNameLength);
                    CLEAR(BeneficiaryIFSCLength);
                    CLEAR(BeneficiaryAddrLenth);
                    CLEAR(BeneficiaryAcNo);
                    CLEAR(BeneficiaryName);
                    CLEAR(BeneficiaryBankName);
                    CLEAR(BeneficiaryIFSC);
                    CLEAR(BeneficiaryAddr);

                    RecGenJounLine.RESET;
                    RecGenJounLine.SETRANGE("Document No.", "Document No.");
                    IF RecGenJounLine.FINDFIRST THEN
                        REPEAT

                            // Calculating amount [-]
                            IF GLAcc.GET(RecGenJounLine."G/L Account No.") THEN
                                IF GLAcc."RTGS Deb. Amt. Control" = TRUE THEN
                                    RTGSDebAmt += RecGenJounLine."Debit Amount";

                            IF GLAcc.GET(RecGenJounLine."G/L Account No.") THEN
                                IF GLAcc."RTGS Cre. Amt. Control" = TRUE THEN
                                    RTGSCreAmt += RecGenJounLine."Credit Amount";

                            DebitAmount += RecGenJounLine."Debit Amount";
                            // Calculating amount [+]

                            IF RecGenJounLine."Source Type" = RecGenJounLine."Source Type"::"Bank Account" THEN BEGIN

                                IF BankAccount.GET(RecGenJounLine."Source No.") THEN
                                    BankAccountNo := BankAccount."Bank Account No.";
                                BankAccAdress2 := BankAccount."Address 2";

                                // Store Applicant Details [-]
                                ApplicantLength := STRLEN(BankAccountNo);
                                FOR l := 1 TO ApplicantLength DO BEGIN
                                    StoreApplicantAccNo[l] := COPYSTR(BankAccountNo, l, 1);
                                END;
                                //Store Applicant Details[+]

                            END;
                            IF RecGenJounLine."Payee Name" <> '' THEN
                                PayeeName := RecGenJounLine."Payee Name";
                            // Storing Check No. [-]
                            CheckNo := RecGenJounLine."External Document No.";
                            CheckNoLengh := STRLEN(CheckNo);
                            FOR m := 1 TO CheckNoLengh DO BEGIN
                                StoreCheckNo[m] := COPYSTR(CheckNo, m, 1);
                            END;
                            // Storing Check No. [+]

                            // Storing Check Date[-]
                            CheckDate := RecGenJounLine."Document Date";
                            ChequeDateFormat := FORMAT(RecGenJounLine."Document Date", 0, '<Day,2><Month,2><Year4>');
                            PostingDateFormat := FORMAT(RecGenJounLine."Posting Date", 0, '<Day,2><Month,2><Year4>');
                            FOR n := 1 TO 8 DO BEGIN
                                StoreDate[n] := COPYSTR(PostingDateFormat, n, 1);
                                ChequeDate[n] := COPYSTR(ChequeDateFormat, n, 1)
                            END;
                            // Storing Check Date[+]

                            //Storing Beneficiary Details [-]
                            IF RecBeneficiary.GET(RecGenJounLine."Beneficiary Code") THEN BEGIN

                                BeneficiaryAcNoLength := STRLEN(RecBeneficiary."Beneficiary A/C No.");
                                BeneficiaryAcNumber := RecBeneficiary."Beneficiary A/C No.";
                                FOR o := 1 TO BeneficiaryAcNoLength DO BEGIN
                                    BeneficiaryAcNo[o] := COPYSTR(BeneficiaryAcNumber, o, 1);
                                END;

                                BeneficiaryNameLength := STRLEN(RecBeneficiary."Beneficiary Name");
                                VarBeneficiaryName := RecBeneficiary."Beneficiary Name";
                                FOR p := 1 TO BeneficiaryNameLength DO BEGIN
                                    BeneficiaryName[p] := COPYSTR(VarBeneficiaryName, p, 1);
                                END;

                                BeneficiaryBankNameLength := STRLEN(RecBeneficiary."Beneficiary Bank Name");
                                VarBeneficiaryBankName := RecBeneficiary."Beneficiary Bank Name";
                                FOR q := 1 TO BeneficiaryBankNameLength DO BEGIN
                                    BeneficiaryBankName[q] := COPYSTR(VarBeneficiaryBankName, q, 1);
                                END;

                                BeneficiaryIFSCLength := STRLEN(RecBeneficiary."Beneficiary IFS Code");
                                VarBeneficiaryIFSC := RecBeneficiary."Beneficiary IFS Code";
                                FOR r := 1 TO BeneficiaryIFSCLength DO BEGIN
                                    BeneficiaryIFSC[r] := COPYSTR(VarBeneficiaryIFSC, r, 1);
                                END;

                                BeneficiaryAddrLenth := STRLEN(RecBeneficiary."Beneficiary Branch Address");
                                VarBeneficiaryAddr := RecBeneficiary."Beneficiary Branch Address";
                                FOR s := 1 TO BeneficiaryAddrLenth DO BEGIN
                                    BeneficiaryAddr[s] := COPYSTR(VarBeneficiaryAddr, s, 1);
                                END;

                            END;
                            //Storing Beneficiary Details [+]
                        UNTIL RecGenJounLine.NEXT = 0;

                    TotalNetAmount := DebitAmount - RTGSDebAmt - RTGSCreAmt;

                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(TotalAmountInwords, TotalNetAmount, '');

                    DocumentNo := "G/L Entry"."Document No.";
                END;
                //CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                TotalNetAmount := 0;
                CLEAR(DocumentNo);
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
        CLEAR(CompAddress);
        CLEAR(RemitterName);
        CLEAR(PANNO);
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS("Bank Logo");
        //PAN :=CompanyInformation."P.A.N. No."; Santosh removed as per instructions from customer on 27-12-2017
        PAN := '';
        FOR i := 1 TO 10 DO BEGIN
            PANNO[i] := COPYSTR(PAN, i, 1);
        END;

        CompanyNameLength := STRLEN(CompanyInformation.Name);
        FOR j := 1 TO CompanyNameLength DO BEGIN
            RemitterName[j] := COPYSTR(CompanyInformation.Name, j, 1)
        END;

        CompAddLength := STRLEN(CompanyInformation.Address);
        FOR k := 1 TO CompanyNameLength DO BEGIN
            CompAddress[k] := COPYSTR(CompanyInformation.Address, k, 1)
        END;
    end;

    var
        CompanyInformation: Record "Company Information";
        PayName: Text[100];
        BankAccount: Record "Bank Account";
        BankAccountNo: Code[20];
        BankAccountName: Text;
        CheckNo: Code[10];
        CheckDate: Date;
        BankAmount: Decimal;
        ReportCheck: Report Check;
        TempDocumentNo: Code[20];
        TotalNetAmount: Decimal;
        TotalAmountInwords: array[2] of Text[80];
        StoreDate: array[20] of Text;
        ChequeDate: array[8] of Text;
        ChequeDateFormat: Text;
        Counter: Integer;
        VendInfo: array[10] of Text;
        GetVendor: Record Vendor;
        State: Record State;
        CountryRegion: Record "Country/Region";
        RecGenJounLine: Record "G/L Entry";
        VarNarration: Text[150];
        PAN: Code[10];
        PANNO: array[10] of Text;
        CheckNoLengh: Integer;
        StoreCheckNo: array[20] of Text;
        i: Integer;
        j: Integer;
        k: Integer;
        l: Integer;
        m: Integer;
        n: Integer;
        o: Integer;
        p: Integer;
        q: Integer;
        r: Integer;
        s: Integer;
        ApplicantLength: Integer;
        StoreApplicantAccNo: array[16] of Text;
        RecBeneficiary: Record Beneficiary;
        RemitterName: array[50] of Text;
        CompanyNameLength: Integer;
        CompAddLength: Integer;
        CompAddress: array[50] of Text;
        DebitAmount: Decimal;
        GLAcc: Record "G/L Account";
        BeneficiaryAcNumber: Text;
        BeneficiaryAcNoLength: Integer;
        BeneficiaryAcNo: array[21] of Text;
        VarBeneficiaryName: Text;
        BeneficiaryNameLength: Integer;
        BeneficiaryName: array[50] of Text;
        BeneficiaryBankNameLength: Integer;
        VarBeneficiaryBankName: Text;
        BeneficiaryBankName: array[25] of Text;
        BeneficiaryIFSCLength: Integer;
        VarBeneficiaryIFSC: Text;
        BeneficiaryIFSC: array[11] of Text;
        BeneficiaryAddrLenth: Integer;
        VarBeneficiaryAddr: Text;
        BeneficiaryAddr: array[50] of Text;
        BankAccAdress2: Text[100];
        RTGSDebAmt: Decimal;
        RTGSCreAmt: Decimal;
        PostingDateFormat: Text;
        Cheque: Boolean;
        DocumentNo: Code[20];
        PayeeName: Text[50];
}

