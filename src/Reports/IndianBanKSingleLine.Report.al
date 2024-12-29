report 50065 "Indian BanK - Single Line"
{
    // Edited By : Jayakumar
    // Date : 14-Aug-2013
    // Purpose : Allignment Problem
    DefaultLayout = RDLC;
    RDLCLayout = './IndianBanKSingleLine.rdlc';

    Permissions =;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING (Journal Template Name, Journal Batch Name, Posting Date, Document No.) ORDER(Ascending);
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
            column(RecGen__Journal_Line__Remarks; "RecGen. Journal Line"."Payee Name")
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
                DataItemLink = Applies-to ID=FIELD(Document No.);
                DataItemTableView = SORTING (Document No.) ORDER(Ascending) WHERE (Document Type=FILTER(Invoice));
                MaxIteration = 10;

                trigger OnAfterGetRecord()
                begin
                    TDSValue := 0;
                    VarnetAmt := 0;
                    TDSEntry.RESET;
                    TDSEntry.SETRANGE(TDSEntry."Document No.","Vendor Ledger Entry"."Document No.");
                    IF TDSEntry.FIND('-') THEN
                      TDSValue := TDSEntry."TDS Amount";

                    VarnetAmt := ABS("Vendor Ledger Entry"."Original Amount") + TDSValue ;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                "RecGen. Journal Line".RESET;
                "RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Document No.","Gen. Journal Line"."Document No.");
                //"RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Account Type","RecGen. Journal Line"."Account Type"::Vendor);
                IF "RecGen. Journal Line".FIND('-') THEN
                  IF ("RecGen. Journal Line"."Account Type" = "RecGen. Journal Line"."Account Type"::Vendor) THEN
                  BEGIN
                  PayName  := "RecGen. Journal Line".Description;
                  RecVendor.RESET;
                  RecVendor.SETRANGE(RecVendor."No.","RecGen. Journal Line"."Account No.");
                  IF RecVendor.FINDFIRST THEN
                  BEGIN
                   FirmName := RecVendor."Name 2";
                   Address  := RecVendor.Address;
                   Address2 := RecVendor."Address 2";
                   PostCode := RecVendor."Post Code";
                   City     := RecVendor.City;
                   Pin      := 'Pin Code';
                  END
                  END
                ELSE
                  IF ("RecGen. Journal Line"."Account Type" = "RecGen. Journal Line"."Account Type"::"G/L Account") THEN
                  BEGIN
                  PayName  := "RecGen. Journal Line"."Payee Name";
                  FirmName := '';
                  Address  := '';
                  Address2 := '';
                  PostCode := '';
                  City     := '';
                  Pin      := '';
                  END
                ELSE
                  BEGIN
                  IF ("RecGen. Journal Line"."Account Type" = "RecGen. Journal Line"."Account Type"::"Bank Account") THEN
                  PayName  := '';
                  FirmName := '';
                  Address  := '';
                  Address2 := '';
                  PostCode := '';
                  City     := '';
                  Pin      := '';
                  END;


                CLEAR(BankName);
                CLEAR(BankAccNo);
                "RecGen. Journal Line".RESET;
                "RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Document No.","Gen. Journal Line"."Document No.");
                IF "RecGen. Journal Line".COUNT >1 THEN
                BEGIN
                "RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Account Type","Gen. Journal Line"."Account Type"::"Bank Account");
                IF "RecGen. Journal Line".FIND('-') THEN
                  BEGIN
                  RecBankAccount.RESET;
                  RecBankAccount.SETRANGE(RecBankAccount."No.","RecGen. Journal Line"."Account No.");
                   IF RecBankAccount.FIND('-') THEN
                     BEGIN
                      BankName:=RecBankAccount.Name;
                      BankAccNo:=RecBankAccount."Bank Account No.";
                     END;

                     Amt:="RecGen. Journal Line"."Credit Amount";
                     CheckReport.InitTextVariable;
                     CheckReport.FormatNoText(NumberText,Amt,'');

                   IF (Amt MOD 1 =0) THEN
                     BEGIN
                       NumberText[1] := COPYSTR(NumberText[1],1,(STRLEN(NumberText[1])));
                     END;
                  END
                ELSE
                  BEGIN
                    RecBankAccount.RESET;
                    RecBankAccount.SETRANGE(RecBankAccount."No.","Gen. Journal Line"."Bal. Account No.");
                     IF RecBankAccount.FIND('-') THEN
                       BEGIN
                         BankName:=RecBankAccount.Name;
                         BankAccNo:=RecBankAccount."Bank Account No.";
                       END;
                     Amt:="Gen. Journal Line"."Debit Amount";
                     CheckReport.InitTextVariable;
                     CheckReport.FormatNoText(NumberText,Amt,'');

                     IF (Amt MOD 1 =0) THEN
                       BEGIN
                         NumberText[1] := COPYSTR(NumberText[1],1,(STRLEN(NumberText[1])));
                       END;
                  END;
                END
                ELSE
                BEGIN
                  BEGIN
                    RecBankAccount.RESET;
                    RecBankAccount.SETRANGE(RecBankAccount."No.","Gen. Journal Line"."Bal. Account No.");
                     IF RecBankAccount.FIND('-') THEN
                       BEGIN
                         BankName:=RecBankAccount.Name;
                         BankAccNo:=RecBankAccount."Bank Account No.";
                       END;
                     Amt:="Gen. Journal Line"."Debit Amount";
                     CheckReport.InitTextVariable;
                     CheckReport.FormatNoText(NumberText,Amt,'');

                     IF (Amt MOD 1 =0) THEN
                       BEGIN
                         NumberText[1] := COPYSTR(NumberText[1],1,(STRLEN(NumberText[1])));
                       END;
                  END;

                END;

                IF BankAccNo = '' THEN
                  ERROR('There is no bank account in Bank Account Card');

                IF ("Gen. Journal Line"."Bal. Account No." = '') THEN
                BEGIN
                  "RecGen. Journal Line".RESET;
                  "RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Document No.","Gen. Journal Line"."Document No.");
                  "RecGen. Journal Line".SETRANGE("RecGen. Journal Line"."Account Type","RecGen. Journal Line"."Account Type"::"Bank Account");
                  IF "RecGen. Journal Line".FINDFIRST THEN
                   Amt := "RecGen. Journal Line"."Credit Amount";
                END
                ELSE
                BEGIN
                   Amt := "RecGen. Journal Line".Amount;
                END;

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText,Amt,'');
                NumberText[1] := COPYSTR(NumberText[1],1,(STRLEN(NumberText[1])));
            end;

            trigger OnPreDataItem()
            begin
                ComInfo.GET;
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
        NumberText: array [2] of Text[250];
        CheckReport: Report Check;
                         PayName: Text[50];
                         Add1: Text[50];
                         Add2: Text[50];
                         Add3: Text[50];
                         "RecGen. Journal Line": Record "Gen. Journal Line";
                         RecBankAccount: Record "Bank Account";
                         Amt: Decimal;
                         BankName: Text[100];
                         BankAccNo: Text[30];
                         ComInfo: Record "Company Information";
                         FirmName: Text[100];
                         Address: Text[50];
                         Address2: Text[50];
                         PostCode: Code[20];
                         City: Text[30];
                         Pin: Text[30];
                         RecVendor: Record Vendor;
                         TDSEntry: Record "TDS Entry";
                         TDSValue: Decimal;
                         VarnetAmt: Decimal;
                         EmptyStringCaptionLbl: Label '***';
}

