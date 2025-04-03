namespace PKF.PKF;

using Microsoft.Finance.GeneralLedger.Journal;
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
        LineNo: Integer;

    begin
        OnBeforeCreateCMSHeader(IsHandled);
        if IsHandled then
            exit;
        //LineNo := 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Debit Ac No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Beneficiary Ac No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Beneficiary Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment Mode', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IFSC', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn('Employee Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        OnAfterCreateCMSHeader();

    end;

    local procedure CreateCMSDetails(var GenJnlLine: Record "Gen. Journal Line")
    var
        BankAccount: Record "Bank Account";
        Beneficiary: Record Beneficiary;
        BeneficiaryGenJnlLine: Record "Gen. Journal Line";
        IsHandled: Boolean;
        Executed: Boolean;
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

        If CalculateTotalGenJnlLineAmount(GenJnlLine) <> 0 then begin
            TempExcelBuffer.NewRow();
            TempExcelBuffer.AddColumn(BankAccount."Bank Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary A/C No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Format(CalculateTotalGenJnlLineAmount(GenJnlLine)), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            if Beneficiary."Beneficiary Bank Name" = 'ICICI BANK' then
                TempExcelBuffer.AddColumn('I', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
            else
                TempExcelBuffer.AddColumn('N', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Format(BeneficiaryGenJnlLine."Posting Date"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(Beneficiary."Beneficiary IFS Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            //TempExcelBuffer.AddColumn(GenJnlLine."Employee Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
        OnAfterCreateCMSDetails();
    end;



    local procedure CMSFileExport(GenJnlLine: Record "Gen. Journal Line")
    var
        DetailGenJnlLine: Record "Gen. Journal Line";
        TempBlob: Codeunit "Temp Blob";
        CSVInStream: InStream;
        CSVOutStream: OutStream;
        LineNo: Integer;
        EmpName: Text;
        FileName: Text;
        DocNo: COde[20];
    begin
        TempExcelBuffer.DeleteAll();

        CreateCMSHeader();

        DetailGenJnlLine.SetCurrentKey("Employee Name");
        DetailGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        DetailGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        DetailGenJnlLine.SetRange("Account Type", DetailGenJnlLine."Account Type"::"G/L Account");
        if DetailGenJnlLine.FindSet() then
            repeat
                if (EmpName <> DetailGenJnlLine."Shortcut Dimension 1 Code") //OR  
                    then begin

                    CreateCMSDetails(DetailGenJnlLine);
                    EmpName := DetailGenJnlLine."Shortcut Dimension 1 Code";
                    DocNo := DetailGenJnlLine."Document No.";
                end else if (DocNo <> '') and (DocNo <> DetailGenJnlLine."Document No.") then begin
                    CreateCMSDetails(DetailGenJnlLine);
                    DocNo := DetailGenJnlLine."Document No.";
                end;
            until DetailGenJnlLine.Next() = 0;
        FileName := 'cms-' + GenJnlLine."Journal Batch Name" + '-' + Format(Today, 6, '<Day,2><Month,2><Year,2>') + '.xls';

        TempExcelBuffer.CreateNewBook('CMS');
        TempExcelBuffer.WriteSheet('CMS', CompanyName, UserId);
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(CSVOutStream);
        TempExcelBuffer.SaveToStream(CSVOutStream, false);

        TempBlob.CreateInStream(CSVInStream);
        DownloadFromStream(CSVInStream, '', '', '', FileName)
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
        //if GenJnlLine."Shortcut Dimension 1 Code" <> '' then
        GenJnlLineRec.SetRange("Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 1 Code");
        //If GenJnlLine."Document No."<>''
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
