/// <summary>
/// Report Indian BanK - Single Line (ID 50065).
/// Edited By : Jayakumar
/// Date : 14-Aug-2013
/// Purpose : Allignment Problem
/// </summary>
report 50065 "Indian BanK - Single Line"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/IndianBanKSingleLine.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Indian BanK - Single Line';


    Permissions =;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.") ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(Amt; Amt)
            {
            }
            column(Gen__Journal_Line__Posting_Date_; "Posting Date")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(RecGen__Journal_Line__Remarks; RecGenJournalLine."Payee Name")
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
            column(Gen__Journal_Line_Document_No_; "Document No.")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice));
                MaxIteration = 10;

                trigger OnAfterGetRecord()
                begin
                    //TDSValue := 0;
                    //TDSEntry.RESET();
                    //TDSEntry.SETRANGE(TDSEntry."Document No.", "Vendor Ledger Entry"."Document No.");
                    //IF TDSEntry.FindFirst() THEN
                    //  TDSValue := TDSEntry."TDS Amount";

                    //VarnetAmt := ABS("Vendor Ledger Entry"."Original Amount") + TDSValue;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                RecGenJournalLine.RESET();
                RecGenJournalLine.SETRANGE(RecGenJournalLine."Document No.", "Gen. Journal Line"."Document No.");
                //RecGenJournalLine.SETRANGE(RecGenJournalLine."Account Type",RecGenJournalLine."Account Type"::Vendor);
                IF RecGenJournalLine.FindFirst() THEN
                    IF (RecGenJournalLine."Account Type" = RecGenJournalLine."Account Type"::Vendor) THEN BEGIN
                        PayName := RecGenJournalLine.Description;
                        RecVendor.RESET();
                        RecVendor.SETRANGE(RecVendor."No.", RecGenJournalLine."Account No.");
                        IF RecVendor.FINDFIRST() THEN BEGIN
                            FirmName := RecVendor."Name 2";
                            Address := RecVendor.Address;
                            Address2 := RecVendor."Address 2";
                            //PostCode := RecVendor."Post Code";
                            City := RecVendor.City;
                            Pin := 'Pin Code';
                        END
                    END
                    ELSE
                        IF (RecGenJournalLine."Account Type" = RecGenJournalLine."Account Type"::"G/L Account") THEN BEGIN
                            PayName := RecGenJournalLine."Payee Name";
                            FirmName := '';
                            Address := '';
                            Address2 := '';
                            //PostCode := '';
                            City := '';
                            Pin := '';
                        END ELSE BEGIN
                            IF (RecGenJournalLine."Account Type" = RecGenJournalLine."Account Type"::"Bank Account") THEN
                                PayName := '';
                            FirmName := '';
                            Address := '';
                            Address2 := '';
                            //PostCode := '';
                            City := '';
                            Pin := '';
                        END;


                CLEAR(BankName);
                CLEAR(BankAccNo);
                RecGenJournalLine.RESET();
                RecGenJournalLine.SETRANGE(RecGenJournalLine."Document No.", "Gen. Journal Line"."Document No.");
                IF RecGenJournalLine.COUNT > 1 THEN BEGIN
                    RecGenJournalLine.SETRANGE(RecGenJournalLine."Account Type", "Gen. Journal Line"."Account Type"::"Bank Account");
                    IF RecGenJournalLine.FindFirst() THEN BEGIN
                        RecBankAccount.RESET();
                        RecBankAccount.SETRANGE(RecBankAccount."No.", RecGenJournalLine."Account No.");
                        IF RecBankAccount.FIND('-') THEN BEGIN
                            BankName := RecBankAccount.Name;
                            BankAccNo := RecBankAccount."Bank Account No.";
                        END;

                        Amt := RecGenJournalLine."Credit Amount";
                        CheckReport.InitTextVariable();
                        CheckReport.FormatNoText(NumberText, Amt, '');

                        IF (Amt MOD 1 = 0) THEN
#pragma warning disable AA0139
                            NumberText[1] := COPYSTR(this.NumberText[1], 1, (STRLEN(this.NumberText[1])));
#pragma warning restore AA0139

                    END
                    ELSE BEGIN
                        RecBankAccount.RESET();
                        RecBankAccount.SETRANGE(RecBankAccount."No.", "Gen. Journal Line"."Bal. Account No.");
                        IF RecBankAccount.FindFirst() THEN BEGIN
                            BankName := RecBankAccount.Name;
                            BankAccNo := RecBankAccount."Bank Account No.";
                        END;
                        Amt := "Gen. Journal Line"."Debit Amount";
                        CheckReport.InitTextVariable();
                        CheckReport.FormatNoText(NumberText, Amt, '');

                        IF (Amt MOD 1 = 0) THEN
                            NumberText[1] := COPYSTR(NumberText[1], 1, (STRLEN(NumberText[1])));

                    END;
                END
                ELSE BEGIN
                    RecBankAccount.RESET();
                    RecBankAccount.SETRANGE(RecBankAccount."No.", "Gen. Journal Line"."Bal. Account No.");
                    IF RecBankAccount.FIND('-') THEN BEGIN
                        BankName := RecBankAccount.Name;
                        BankAccNo := RecBankAccount."Bank Account No.";
                    END;
                    Amt := "Gen. Journal Line"."Debit Amount";
                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, Amt, '');

                    IF (Amt MOD 1 = 0) THEN
                        NumberText[1] := COPYSTR(NumberText[1], 1, (STRLEN(NumberText[1])));



                END;

                IF BankAccNo = '' THEN
                    ERROR('There is no bank account in Bank Account Card');

                IF ("Gen. Journal Line"."Bal. Account No." = '') THEN BEGIN
                    RecGenJournalLine.RESET();
                    RecGenJournalLine.SETRANGE(RecGenJournalLine."Document No.", "Gen. Journal Line"."Document No.");
                    RecGenJournalLine.SETRANGE(RecGenJournalLine."Account Type", RecGenJournalLine."Account Type"::"Bank Account");
                    IF RecGenJournalLine.FINDFIRST() THEN
                        Amt := RecGenJournalLine."Credit Amount";
                END
                ELSE
                    Amt := RecGenJournalLine.Amount;


                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amt, '');
                NumberText[1] := COPYSTR(NumberText[1], 1, (STRLEN(NumberText[1])));
            end;

            trigger OnPreDataItem()
            begin
                ComInfo.GET();
            end;
        }
    }


    var
        ComInfo: Record "Company Information";
        RecBankAccount: Record "Bank Account";
        RecGenJournalLine: Record "Gen. Journal Line";
        RecVendor: Record Vendor;
        CheckReport: Report "Check Report";
        Amt: Decimal;
        Address2: Text[50];
        Address: Text[100];
        BankAccNo: Text[30];
        BankName: Text[100];
        City: Text[30];
        FirmName: Text[100];
        NumberText: array[2] of Text[250];
        PayName: Text[100];
        Pin: Text[30];
        EmptyStringCaptionLbl: Label '***';
}

