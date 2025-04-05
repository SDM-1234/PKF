namespace PKF.PKF;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.Bank.BankAccount;
using System.Utilities;
using System.IO;

codeunit 50006 CMSFileMgt
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        CMSFileExport(Rec);
    end;


    local procedure CreateCMSHeader()
    var
        IsHandled: Boolean;

    begin
        OnBeforeCreateCMSHeader(IsHandled);
        if IsHandled then
            exit;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Debit Ac No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Beneficiary Ac No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Beneficiary Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Pay Mod', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IFSC', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payable Location', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Print Location', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Mobile No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Email ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene add1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene add2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene add3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene add4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Add Details 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Add Details 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Add Details 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Add Details 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Add Details 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Remarks', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        OnAfterCreateCMSHeader();

    end;

    local procedure CreateCMSDetails(var GenJnlLine: Record "Gen. Journal Line")
    var
        BankAccount: Record "Bank Account";
        Beneficiary: Record Beneficiary;
        BeneficiaryGenJnlLine: Record "Gen. Journal Line";
        IsHandled: Boolean;
        Executed: Boolean;
        TotalAmount: Decimal;
    begin
        OnBeforeCreateCMSDetails(IsHandled);
        if IsHandled then
            exit;

        if Executed = false then begin
            BeneficiaryGenJnlLine.Reset();
            BeneficiaryGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
            BeneficiaryGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
            BeneficiaryGenJnlLine.SetRange("Account Type", BeneficiaryGenJnlLine."Account Type"::"Bank Account");
            if BeneficiaryGenJnlLine.FindFirst() then
                Executed := true;
            if BankAccount.Get(BeneficiaryGenJnlLine."Account No.") then;
        end;

        Beneficiary.Reset();
        if Beneficiary.Get(GenJnlLine."Beneficiary Code") then;

        TotalAmount := CalculateTotalGenJnlLineAmount(GenJnlLine);
        If TotalAmount <> 0 then begin
            TempExcelBuffer.NewRow();
            TempExcelBuffer.AddColumn(BankAccount."Bank Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary A/C No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Format(TotalAmount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            if Beneficiary."Beneficiary Bank Name" = 'ICICI BANK' then
                TempExcelBuffer.AddColumn('I', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
            else
                TempExcelBuffer.AddColumn('N', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(BeneficiaryGenJnlLine."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary IFS Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;

        OnAfterCreateCMSDetails();
    end;



    local procedure CMSFileExport(GenJnlLine: Record "Gen. Journal Line")
    var
        DetailGenJnlLine: Record "Gen. Journal Line";
        TempBlob: Codeunit "Temp Blob";
        CSVInStream: InStream;
        CSVOutStream: OutStream;
        EmpName: Text;
        FileName: Text;
        DocNo: COde[20];
        Month: Integer;
        Year: Text;
        MonthName: Text;
        Dimensionvalue: Record "Dimension Value";
        GeneralLedgSetup: Record "General Ledger Setup";
        FromChars: Text[50];
        ToChars: Text[50];
        NewString: Text[50];
    begin
        TempExcelBuffer.DeleteAll();

        CreateCMSHeader();

        DetailGenJnlLine.SetCurrentKey("Employee Name");
        DetailGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        DetailGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        DetailGenJnlLine.SetRange("Account Type", DetailGenJnlLine."Account Type"::"G/L Account");
        if DetailGenJnlLine.FindSet() then
            repeat
                if (EmpName <> DetailGenJnlLine."Shortcut Dimension 1 Code") then begin
                    CreateCMSDetails(DetailGenJnlLine);
                    EmpName := DetailGenJnlLine."Shortcut Dimension 1 Code";
                    DocNo := DetailGenJnlLine."Document No.";
                end else if (DocNo <> '') and (DocNo <> DetailGenJnlLine."Document No.") then begin
                    CreateCMSDetails(DetailGenJnlLine);
                    DocNo := DetailGenJnlLine."Document No.";
                end;
            until DetailGenJnlLine.Next() = 0;

        GeneralLedgSetup.Get();
        if Dimensionvalue.Get(GeneralLedgSetup."Shortcut Dimension 2 Code", GenJnlLine."Shortcut Dimension 2 Code") then;
        NewString := ConvertToTitleCase(Dimensionvalue.Name);
        Month := Date2DMY(GenJnlLine."Posting Date", 2);
        Year := Format(Date2DMY(GenJnlLine."Posting Date", 3));
        Year := DelStr(Year, 1, 2);
        Case Month of
            1:
                MonthName := 'Jan';
            2:
                MonthName := 'Feb';
            3:
                MonthName := 'Mar';
            4:
                MonthName := 'Apr';
            5:
                MonthName := 'May';
            6:
                MonthName := 'Jun';
            7:
                MonthName := 'Jul';
            8:
                MonthName := 'Aug';
            9:
                MonthName := 'Sep';
            10:
                MonthName := 'Oct';
            11:
                MonthName := 'Nov';
            12:
                MonthName := 'Dec';
        End;

        FileName := 'Livepayment-file-' + NewString + '-' + MonthName + Format(Year) + '.xls';

        TempExcelBuffer.CreateNewBook('CMS');
        TempExcelBuffer.WriteSheet('CMS', CompanyName, UserId);
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(CSVOutStream);
        TempExcelBuffer.SaveToStream(CSVOutStream, false);

        TempBlob.CreateInStream(CSVInStream);
        DownloadFromStream(CSVInStream, '', '', '', FileName)
    end;

    procedure ConvertToTitleCase(InputString: Text[50]): Text[50]
    var
        TempString: Text[50];
        CurrentWord: Text[50];
        Result: Text[50];
        i: Integer;
        Position: Integer;
    begin
        TempString := InputString;
        Result := '';
        Position := StrPos(TempString, ' ');

        while Position > 0 do begin
            CurrentWord := CopyStr(TempString, 1, Position - 1); // Extract the word
            if StrLen(CurrentWord) > 0 then
                CurrentWord := UpperCase(CopyStr(CurrentWord, 1, 1)) + LowerCase(CopyStr(CurrentWord, 2)); // Title case

            Result := Result + CurrentWord + ' ';
            TempString := DelStr(TempString, 1, Position); // Remove the processed word
            Position := StrPos(TempString, ' ');
        end;

        // Process the last word
        if StrLen(TempString) > 0 then
            Result := Result + UpperCase(CopyStr(TempString, 1, 1)) + LowerCase(CopyStr(TempString, 2));

        exit(Result);
    end;


    local procedure CalculateTotalGenJnlLineAmount(GenJnlLine: Record "Gen. Journal Line"): Decimal
    var
        GenJnlLineRec: Record "Gen. Journal Line";
        TotalAmount: Decimal;

    begin
        Clear(TotalAmount);
        GenJnlLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
        GenJnlLineRec.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLineRec.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLineRec.SetRange("Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLineRec.SetRange("Document No.", GenJnlLine."Document No.");
        GenJnlLineRec.SetRange("Account Type", GenJnlLine."Account Type"::"G/L Account");
        If GenJnlLineRec.FindSet() then
            repeat
                TotalAmount += GenJnlLineRec.Amount;
            Until GenJnlLineRec.Next() = 0;
        Exit(TotalAmount);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateCMSHeader(var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateCMSHeader()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateCMSDetails(var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateCMSDetails()
    begin
    end;

}
