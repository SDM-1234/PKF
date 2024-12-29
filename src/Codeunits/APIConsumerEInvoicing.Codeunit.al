codeunit 50001 "API Consumer E-Invoicing"
{

    trigger OnRun()
    begin
    end;

    var
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
        CompanyInformation: Record "Company Information";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        FileManagement: Codeunit "File Management";
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        StringReader: DotNet StringReader;
        Json: DotNet String;
        JsonTextWriter: DotNet JsonTextWriter;
        JsonTextReader: DotNet JsonTextReader;
        StreamWriter: DotNet StreamWriter;
        StreamReader: DotNet StreamReader;
        Encoding: DotNet Encoding;
        RequestStr: DotNet Stream;
        MessageText: Text;
        SetupFound: Boolean;
        Text90000: Label 'Invoice Cancelled';
        OwnerId: Text;
        LocGstRegNo: Text;

    local procedure SetINIT()
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
    end;

    [Scope('Internal')]
    procedure StartJson()
    begin
        SetINIT;
        JsonTextWriter.WriteStartObject;
    end;

    local procedure AddToJson(Variablename: Text; Variable: Variant)
    begin
        JsonTextWriter.WritePropertyName(Variablename);
        JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
    end;

    [Scope('Internal')]
    procedure EndJson()
    begin
        JsonTextWriter.WriteEndObject;
    end;

    local procedure GetJson()
    begin
        Json := StringBuilder.ToString;
    end;

    local procedure GetClientFile(): Text
    var
        ClientAppFile: DotNet Path;
    begin
        EXIT(ClientAppFile.GetTempPath);
    end;

    [Scope('Internal')]
    procedure GetAccessToken(): Text
    var
        DataExch: Record "Data Exch. Field";
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
        TempBlob: Record TempBlob;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        FL: File;
        ResponseText: Text;
        JString: Text;
        Validity: Text;
        ValidSec: Integer;
    begin
        EInvIntegrationSetup.GET;
        IF CURRENTDATETIME > EInvIntegrationSetup."Access Token Validity" THEN BEGIN
            StartJson;
            AddToJson('username', EInvIntegrationSetup."User Name");
            AddToJson('password', EInvIntegrationSetup.Password);
            AddToJson('client_id', EInvIntegrationSetup."Client ID");
            AddToJson('client_secret', EInvIntegrationSetup."Client Secret");
            AddToJson('grant_type', 'password');
            EndJson;
            GetJson;
            IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                ERASE(GetClientFile + 'J.txt');
            FL.CREATE(GetClientFile + 'J.txt');
            FL.CREATEOUTSTREAM(OutStrm);
            OutStrm.WRITETEXT(FORMAT(Json));
            FL.CLOSE;
            HttpWebRequestMgt.Initialize(EInvIntegrationSetup."Access Token URL");
            HttpWebRequestMgt.DisableUI;
            HttpWebRequestMgt.SetMethod('POST');
            HttpWebRequestMgt.SetReturnType('application/json');
            HttpWebRequestMgt.SetContentType('application/json');
            HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
            TempBlob.INIT;
            TempBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
            IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                ResponseInStream_L.READ(ResponseText);
                Json := ResponseText;
                // ReadJSon(Json,DataExch);
                DataExch.RESET;
                DataExch.SETRANGE("Node ID", 'access_token');
                IF DataExch.FINDFIRST THEN
                    MessageText := DataExch.Value;
                DataExch.RESET;
                DataExch.SETRANGE("Node ID", 'expires_in');
                IF DataExch.FINDFIRST THEN
                    Validity := DataExch.Value;
                EVALUATE(ValidSec, Validity);
                EInvIntegrationSetup."Access Token" := MessageText;
                EInvIntegrationSetup."Access Token Validity" := CURRENTDATETIME + (ValidSec * 1000);
                EInvIntegrationSetup.MODIFY;
                EXIT(MessageText);
            END;
        END ELSE
            EXIT(EInvIntegrationSetup."Access Token");
    end;

    [Scope('Internal')]
    procedure GenerateEInvoice(JsonString: Text; var ResponseText: Text; Cancel: Boolean)
    var
        TempBlob: Record TempBlob;
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        JString: Text;
        FL: File;
        ServicePointManager: DotNet ServicePointManager;
        SecurityProtocolType: DotNet SecurityProtocolType;
        FilePath: Text;
    begin
        GetEInvSetup;
        GetJson;
        IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FilePath := GetClientFile + 'J.txt';
        FL.CREATE(FilePath);
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE;
        IF GUIALLOWED THEN // To avoid error while Background Posting
            IF CONFIRM('Do you want view the JSON') THEN
                MESSAGE('%1', Json);
        GetEInvSetup;
        IF NOT Cancel THEN
            HttpWebRequestMgt.Initialize(EInvIntegrationSetup."Generate E-Invoice URL")
        ELSE
            HttpWebRequestMgt.Initialize(EInvIntegrationSetup."Cancel E-Invoice URL");
        //ServicePointManager.Expect100Continue := TRUE;
        //ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.AddHeader('X-Cleartax-Auth-Token', EInvIntegrationSetup."Access Token");
        HttpWebRequestMgt.AddHeader('owner_id', OwnerId);
        HttpWebRequestMgt.AddHeader('gstin', LocGstRegNo);
        HttpWebRequestMgt.AddHeader('x-cleartax-product', 'EInvoice');
        HttpWebRequestMgt.SetReturnType('application/json');
        HttpWebRequestMgt.SetContentType('application/json');
        //HttpWebRequestMgt.AddBody(FilePath);
        TempBlob.INIT;
        TempBlob.WriteAsText(Json, TEXTENCODING::UTF8);
        HttpWebRequestMgt.AddBodyBlob(TempBlob);
        TempBlob.INIT;
        TempBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN
            ResponseInStream_L.READ(ResponseText);
    end;

    [Scope('Internal')]
    procedure ReadJSon(var String: DotNet String; var TempDataExchField: Record "Data Exch. Field" temporary)
    var
        JsonToken: DotNet JsonToken;
        PrefixArray: DotNet Array;
        PrefixString: DotNet String;
        PropertyName: Text;
        ColumnNo: Integer;
        InArray: array[1000] of Boolean;
    begin
        PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 250);
        StringReader := StringReader.StringReader(String);
        JsonTextReader := JsonTextReader.JsonTextReader(StringReader);

        TempDataExchField.DELETEALL;
        //new code for delete all data from temp table

        WHILE JsonTextReader.Read DO
            CASE TRUE OF
                JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
                    BEGIN
                        InArray[JsonTextReader.Depth + 1] := TRUE;
                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
                    BEGIN
                        PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
                        IF JsonTextReader.Depth > 1 THEN BEGIN
                            PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
                            IF PrefixString.Length > 0 THEN
                                PropertyName := PrefixString.ToString + '.' + FORMAT(JsonTextReader.Value, 0, 9)
                            ELSE
                                PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                        END ELSE
                            PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
                    BEGIN
                        TempDataExchField.INIT;
                        TempDataExchField."Data Exch. No." := JsonTextReader.Depth;
                        TempDataExchField."Line No." := JsonTextReader.LineNumber;

                        TempDataExchField."Column No." := ColumnNo;
                        TempDataExchField."Node ID" := PropertyName;
                        IF (STRLEN(FORMAT(JsonTextReader.Value, 0, 9)) > 250) AND (TempDataExchField."Node ID" <> 'results.message.SignedInvoice') THEN BEGIN
                            TempDataExchField.Value := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 1, 250);
                            TempDataExchField.Value2 := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 251, 250);
                            TempDataExchField.Value3 := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 501, 250);
                            TempDataExchField.Value4 := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 751, 250);
                        END ELSE
                            TempDataExchField.Value := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 1, 250);
                        TempDataExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
                        TempDataExchField.INSERT;
                        COMMIT;

                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
                    InArray[JsonTextReader.Depth + 1] := FALSE;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
                    IF JsonTextReader.Depth > 0 THEN
                        IF InArray[JsonTextReader.Depth] THEN ColumnNo += 1;
            END;
    end;

    local procedure GetJsonNodeValue(NodeId: Text[30]): Text[1024]
    var
        DataExch: Record "Data Exch. Field";
    begin
        CLEAR(MessageText);
        DataExch.SETRANGE("Node ID", NodeId);
        IF DataExch.FINDFIRST THEN
            MessageText := DataExch.Value + DataExch.Value2 + DataExch.Value3 + DataExch.Value4;
        EXIT(MessageText);
    end;

    local procedure GetCompanyInfo()
    begin
        CompanyInformation.GET;
    end;

    local procedure GetStateCode(StateCode: Code[20]): Text
    var
        StateL: Record State;
    begin
        IF StateL.GET(StateCode) THEN
            EXIT(UPPERCASE(StateL."State Code (GST Reg. No.)"));
        EXIT('');
    end;

    local procedure GetStateCode_POS(StateCode: Code[20]): Text
    var
        StateL: Record State;
    begin
        IF StateL.GET(StateCode) THEN
            EXIT(UPPERCASE(StateL."State Code (GST Reg. No.)"));
        EXIT('');
    end;

    local procedure GetGSTAmount(DocNo: Code[20]; CompCode: Code[10]): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
    begin
        DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        DetailedGSTLedgerEntry.CALCSUMS("GST Amount");
        EXIT(ABS(DetailedGSTLedgerEntry."GST Amount"));
    end;

    local procedure GetGSTAmountLineWise(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
    begin
        DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        DetailedGSTLedgerEntry.CALCSUMS("GST Amount");
        EXIT(ABS(DetailedGSTLedgerEntry."GST Amount"));
    end;

    local procedure CheckGST(DocNo: Code[20]): Boolean
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure GetGSTRate(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            EXIT(ROUND(DetailedGSTLedgerEntry."GST %", 0.01));
        EXIT(0);
    end;

    local procedure GetTaxableAmountSalesInvoice(DocNo: Code[20]): Decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETRANGE("Document No.", DocNo);
        SalesInvoiceLine.CALCSUMS("GST Base Amount");
        IF SalesInvoiceLine."GST Base Amount" <> 0 THEN
            EXIT(SalesInvoiceLine."GST Base Amount");

        SalesInvoiceLine.CALCSUMS(Amount);
        EXIT(SalesInvoiceLine.Amount);
    end;

    local procedure GetTaxableAmountTransfer(DocNo: Code[20]): Decimal
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
    begin
        TransferShipmentLine.SETRANGE("Document No.", DocNo);
        TransferShipmentLine.CALCSUMS("GST Base Amount");
        IF TransferShipmentLine."GST Base Amount" <> 0 THEN
            EXIT(TransferShipmentLine."GST Base Amount");

        TransferShipmentLine.CALCSUMS(Amount);
        EXIT(TransferShipmentLine.Amount);
    end;

    local procedure GetTaxableAmountSCrMemo(DocNo: Code[20]): Decimal
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SETRANGE("Document No.", DocNo);
        SalesCrMemoLine.CALCSUMS("GST Base Amount");
        IF SalesCrMemoLine."GST Base Amount" <> 0 THEN
            EXIT(SalesCrMemoLine."GST Base Amount");

        SalesCrMemoLine.CALCSUMS(Amount);
        EXIT(SalesCrMemoLine.Amount);
    end;

    local procedure GetDateFormated(Originaldate: Date): Text
    var
        Day: Text[2];
        mnth: Text[2];
    begin
        IF Originaldate <> 0D THEN BEGIN
            IF DATE2DMY(Originaldate, 2) > 9 THEN
                mnth := FORMAT(DATE2DMY(Originaldate, 2))
            ELSE
                mnth := '0' + FORMAT(DATE2DMY(Originaldate, 2));

            IF DATE2DMY(Originaldate, 1) > 9 THEN
                Day := FORMAT(DATE2DMY(Originaldate, 1))
            ELSE
                Day := '0' + FORMAT(DATE2DMY(Originaldate, 1));

            EXIT(Day + '/' + mnth + '/' + FORMAT(DATE2DMY(Originaldate, 3)));
        END;
    end;

    local procedure GetGSTIN(LocCode: Code[20]): Text
    var
        Location: Record Location;
        CompanyInformation: Record "Company Information";
    begin
        IF Location.GET(LocCode) THEN BEGIN
            Location.TESTFIELD("GST Registration No.");
            EXIT(Location."GST Registration No.");
        END;
        CompanyInformation.GET;
        EXIT(CompanyInformation."GST Registration No.");
    end;

    local procedure GetRoundingGL(CustPostingGrp: Code[10]; var GstRoundingGL: Code[20]; var InvRoundingGL: Code[20]; var PITRoundingGL: Code[20])
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        GeneralLedgerSetup.GET;
        GstRoundingGL := GeneralLedgerSetup."GST Inv. Rounding Account";

        IF CustomerPostingGroup.GET(CustPostingGrp) THEN BEGIN
            InvRoundingGL := CustomerPostingGroup."Invoice Rounding Account";
            PITRoundingGL := CustomerPostingGroup."PIT Difference Acc.";
        END;
    end;

    local procedure InsertResponse(RequestId: Text[250]; DocumentNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; AckNo: Text; AckDt: Text; Irn: Text; SignedQRCode: Text; StatusP: Text; ErrorMessage: Text; DocDate: Date; QRCodeURL: Text; EInvoicePDFURL: Text; InfoDetails: Text)
    var
        EInvoicingRequests: Record "E-Invoicing Requests";
        EInvoicingRequests2: Record "E-Invoicing Requests";
    begin
        EInvoicingRequests2.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
        EInvoicingRequests2.SETRANGE("Document Type", DocType);
        EInvoicingRequests2.SETRANGE("Document No.", DocumentNo);
        IF EInvoicingRequests2.FINDFIRST THEN BEGIN
            WITH EInvoicingRequests2 DO BEGIN
                "Acknowledgement No." := AckNo;
                "Acknowledgement Date" := AckDt;
                "IRN No." := Irn;
                IF STRLEN(SignedQRCode) > 250 THEN BEGIN
                    "Signed QR Code" := COPYSTR(SignedQRCode, 1, 250);
                    "Signed QR Code2" := COPYSTR(SignedQRCode, 251, 250);
                    "Signed QR Code3" := COPYSTR(SignedQRCode, 501, 250);
                    "Signed QR Code4" := COPYSTR(SignedQRCode, 751, 250);
                END ELSE
                    "Signed QR Code" := (SignedQRCode);

                IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                    "Error Message" := COPYSTR(ErrorMessage, 1, 250);
                    "Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                    "Error Message3" := COPYSTR(ErrorMessage, 501, 250);
                END ELSE
                    "Error Message" := ErrorMessage;

                Status := StatusP;
                "Request ID" := RequestId;
                "Request Date" := WORKDATE;
                "Request Time" := TIME;
                "User Id" := USERID;
                //"QR Code URL":= QRCodeURL;
                //"E Invoice PDF URL":= EInvoicePDFURL;
                IF STRLEN(InfoDetails) > 250 THEN BEGIN
                    "Info Details" := COPYSTR(InfoDetails, 1, 250);
                    "Info Details2" := COPYSTR(InfoDetails, 251, 250);
                END ELSE
                    "Info Details" := InfoDetails;

                IF Irn <> '' THEN BEGIN
                    IF GUIALLOWED THEN // To avoid error while Background Posting
                        GenerateQRCode(EInvoicingRequests2);
                    "E-Invoice Generated" := TRUE;
                END;
                MODIFY;
            END;
        END ELSE BEGIN
            WITH EInvoicingRequests DO BEGIN
                "Entry No." := CREATEGUID;
                "Document Type" := DocType;
                "Document No." := DocumentNo;
                "Document Date" := DocDate;
                "Acknowledgement No." := AckNo;
                "Acknowledgement Date" := AckDt;
                "IRN No." := Irn;
                IF STRLEN(SignedQRCode) > 250 THEN BEGIN
                    "Signed QR Code" := COPYSTR(SignedQRCode, 1, 250);
                    "Signed QR Code2" := COPYSTR(SignedQRCode, 251, 250);
                    "Signed QR Code3" := COPYSTR(SignedQRCode, 501, 250);
                    "Signed QR Code4" := COPYSTR(SignedQRCode, 751, 250);
                END ELSE
                    "Signed QR Code" := (SignedQRCode);

                IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                    "Error Message" := COPYSTR(ErrorMessage, 1, 250);
                    "Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                    "Error Message3" := COPYSTR(ErrorMessage, 501, 250);
                END ELSE
                    "Error Message" := ErrorMessage;

                Status := StatusP;
                "Request ID" := RequestId;
                "Request Date" := WORKDATE;
                "Request Time" := TIME;
                "User Id" := USERID;
                //"QR Code URL":= QRCodeURL;
                //"E Invoice PDF URL":= EInvoicePDFURL;
                IF STRLEN(InfoDetails) > 250 THEN BEGIN
                    "Info Details" := COPYSTR(InfoDetails, 1, 250);
                    "Info Details2" := COPYSTR(InfoDetails, 251, 250);
                END ELSE
                    "Info Details" := InfoDetails;

                IF Irn <> '' THEN BEGIN
                    "E-Invoice Generated" := TRUE;
                    IF GUIALLOWED THEN // To avoid error while Background Posting
                        GenerateQRCode(EInvoicingRequests);//temp
                END;
                INSERT;
            END;
        END;
    end;

    local procedure InsertCancelResponse(DocumentNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; Irn: Text; StatusP: Text; ErrorMessage: Text; DocDate: Date; CancelDate: DateTime)
    var
        EInvoicingRequests: Record "E-Invoicing Requests";
        EInvoicingRequests2: Record "E-Invoicing Requests";
    begin
        EInvoicingRequests2.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Canceled");
        EInvoicingRequests2.SETRANGE("Document Type", DocType);
        EInvoicingRequests2.SETRANGE("Document No.", DocumentNo);
        IF EInvoicingRequests2.FINDFIRST THEN BEGIN
            WITH EInvoicingRequests2 DO BEGIN
                IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                    "Error Message" := COPYSTR(ErrorMessage, 1, 250);
                    "Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                    "Error Message3" := COPYSTR(ErrorMessage, 501, 250);
                END ELSE
                    "Error Message" := ErrorMessage;

                IF CancelDate <> 0DT THEN BEGIN
                    "Cancel Date" := DT2DATE(CancelDate);
                    "Cancel Time" := DT2TIME(CancelDate);
                    "Cancel User Id" := USERID;
                    "E-Invoice Canceled" := TRUE;
                END;
                MODIFY;
            END;
        END;
    end;

    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        IF ((UnitofMeasure.GET(UOMCode)) AND (UnitofMeasure."GST Reporting UQC" <> '')) THEN
            EXIT(UnitofMeasure."GST Reporting UQC");
    end;

    [Scope('Internal')]
    procedure CheckValidations_BeforePost(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] THEN BEGIN
            IF (SalesHeader."GST Customer Type" IN
                       [SalesHeader."GST Customer Type"::Export]) AND (SalesHeader."Nature of Supply" = SalesHeader."Nature of Supply"::B2B)
                    THEN BEGIN
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                IF SalesLine.FINDFIRST THEN
                    SalesHeader.TESTFIELD("Exit Point");
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    [Scope('Internal')]
    procedure CreateJSONSalesInvoice_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        GetEInvSetup;
        IF EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."Mode of E-Invoice - Sales"::"BackGround Posting" THEN
            EXIT;

        IF NOT SalesInvoiceHeader.GET(SalesInvHdrNo) THEN
            EXIT;
        CreateJson(SalesInvoiceHeader, 1);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterPostTransferDoc', '', false, false)]
    [Scope('Internal')]
    procedure CreateJSONTransferShipment_OnPost(var TransferHeader: Record "Transfer Header"; TransferShptHdrNo: Code[20])
    var
        TransferShipmentHeader: Record "Transfer Shipment Header";
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
    begin
        EInvIntegrationSetup.GET;
        IF EInvIntegrationSetup."Mode of E-Invoice - Transfer" = EInvIntegrationSetup."Mode of E-Invoice - Transfer"::"BackGround Posting" THEN
            EXIT;

        IF NOT TransferShipmentHeader.GET(TransferShptHdrNo) THEN
            EXIT;
        CreateJson(TransferShipmentHeader, 3);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    [Scope('Internal')]
    procedure CreateJSONSalesCrmemo_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
    begin
        EInvIntegrationSetup.GET;
        IF EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."Mode of E-Invoice - Sales"::"BackGround Posting" THEN
            EXIT;

        IF (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Credit Memo") AND (NOT SalesCrMemoHeader.GET(SalesCrMemoHdrNo)) THEN
            EXIT;
        CreateJson(SalesCrMemoHeader, 2);
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
    [Scope('Internal')]
    procedure CreateJSONSalesInvoice_OnPostedInvoice(var Rec: Record "Sales Invoice Header")
    begin
        CreateJson(Rec, 1);
    end;

    [EventSubscriber(ObjectType::Page, 5743, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
    [Scope('Internal')]
    procedure CreateJSONTransferShipment__OnPostedInvoice(var Rec: Record "Transfer Shipment Header")
    begin
        CreateJson(Rec, 3);
    end;

    [EventSubscriber(ObjectType::Page, 134, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
    [Scope('Internal')]
    procedure CreateJSONSalesCrmemo__OnPostedInvoice(var Rec: Record "Sales Cr.Memo Header")
    begin
        CreateJson(Rec, 2);
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'Cancel E-Invoice', false, false)]
    [Scope('Internal')]
    procedure CancelJSONSalesInvoice_OnPostedInvoice(var Rec: Record "Sales Invoice Header")
    begin
        CancelJSONSalesInvoice(Rec);
    end;

    local procedure CreateJson(RecVariant: Variant; DocumentType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer)
    var
        Text50000: Label 'AT365 EInvoice';
    begin
        CASE DocumentType OF
            DocumentType::"Sale Invoice":
                CreateJSONSalesInvoice(RecVariant);
            DocumentType::Transfer:
                CreateJSONTransferShipment(RecVariant);
            DocumentType::"Sale Cr. Memo":
                CreateJSONSalesCrmemo(RecVariant);
        END;
    end;

    local procedure CreateJSONSalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        Customer: Record Customer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        ShiptoAddress: Record "Ship-to Address";
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        DataExch: Record "Data Exch. Field";
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_rec: Record State;
        eCommerceMerchantId: Record "e-Commerce Merchant Id";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesInvoiceLine3: Record "Sales Invoice Line";
        PostedStructureOrderDetails: Record "Posted Structure Order Details";
        TempBlob: Record TempBlob;
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        FL: File;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        CustGstin: Code[15];
        State_Gst: Code[2];
        CustGstin2: Code[15];
        InvRoundingGL: Code[20];
        RefDocNo: Code[20];
        GstRoundingGL: Code[20];
        PITRoundingGL: Code[20];
        TknNo: Text[250];
        ResponseText: Text;
        JString: Text;
        AckNo: Text;
        AckDt: Text;
        Irn: Text;
        Mnth: Text[2];
        Day: Text[2];
        SignedQRCode: Text;
        SNo: Integer;
        LCYCurrency: Decimal;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
    begin
        WITH SalesInvoiceHeader DO BEGIN
            IF NOT CheckGST("No.") THEN
                EXIT;
            GetEInvSetup;
            IF (EInvIntegrationSetup."Activation Date" = 0D) OR (EInvIntegrationSetup."Activation Date" > "Posting Date") THEN
                EXIT;
            IF ("Nature of Supply" = "Nature of Supply"::B2C) THEN
                EXIT;

            CheckEInvoiceStatus("No.", 1, FALSE);

            GetCompanyInfo;
            //TknNo := GetAccessToken;
            TknNo := EInvIntegrationSetup."Access Token";
            Location.GET("Location Code");
            LocGstRegNo := Location."GST Registration No.";
            OwnerId := Location."Cleartax Owner ID";
            Customer.GET("Bill-to Customer No.");
            LCYCurrency := 1;
            StartJson;
            AddToJson('Version', '1.1');
            JsonTextWriter.WritePropertyName('TranDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('TaxSch', 'GST');
            CASE "GST Customer Type" OF
                "GST Customer Type"::Export:
                    BEGIN
                        IF "GST Without Payment of Duty" THEN
                            AddToJson('SupTyp', 'EXPWOP')
                        ELSE
                            AddToJson('SupTyp', 'EXPWP');
                    END;
                "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit":
                    BEGIN
                        IF "GST Without Payment of Duty" THEN
                            AddToJson('SupTyp', 'SEZWOP')
                        ELSE
                            AddToJson('SupTyp', 'SEZWP');
                    END;
                "GST Customer Type"::"Deemed Export":
                    AddToJson('SupTyp', 'DEXP');
                "GST Customer Type"::Registered, "GST Customer Type"::Exempted:
                    AddToJson('SupTyp', 'B2B');
            END;
            AddToJson('RegRev', 'N');
            IF "POS Out Of India" THEN
                AddToJson('IgstOnIntra', 'Y')
            ELSE
                AddToJson('IgstOnIntra', 'N');
            IF "e-Commerce Customer" <> '' THEN BEGIN
                IF eCommerceMerchantId.GET("e-Commerce Customer", "e-Commerce Merchant Id") THEN
                    AddToJson('EcmGstin', eCommerceMerchantId."Company GST Reg. No.");
            END;

            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('DocDtls');
            JsonTextWriter.WriteStartObject;
            IF "Invoice Type" = "Invoice Type"::Taxable THEN
                AddToJson('Typ', 'INV')
            ELSE
                IF ("Invoice Type" = "Invoice Type"::"Debit Note") OR
                  ("Invoice Type" = "Invoice Type"::Supplementary)
                THEN
                    AddToJson('Typ', 'DBN')
                ELSE
                    AddToJson('Typ', 'INV');
            AddToJson('No', "No.");
            AddToJson('Dt', GetDateFormated("Posting Date"));
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('SellerDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('Gstin', GetGSTIN("Location Code"));
            AddToJson('LglNm', Location.Name);
            AddToJson('Addr1', Location.Address);
            IF Location."Address 2" <> '' THEN
                AddToJson('Addr2', Location."Address 2");

            AddToJson('Loc', Location.City);
            AddToJson('Pin', Location."Post Code");
            AddToJson('Stcd', GetStateCode(Location."State Code"));
            AddToJson('Ph', Location."Phone No.");
            AddToJson('Em', Location."E-Mail");
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('BuyerDtls');
            JsonTextWriter.WriteStartObject;

            IF ("GST Customer Type" = "GST Customer Type"::Export) THEN
                AddToJson('Gstin', 'URP')
            ELSE
                AddToJson('Gstin', Customer."GST Registration No.");

            AddToJson('LglNm', "Bill-to Name");
            AddToJson('TrdNm', "Bill-to Name");
            AddToJson('Addr1', "Bill-to Address");
            IF "Bill-to Address 2" <> '' THEN
                AddToJson('Addr2', "Bill-to Address 2");

            AddToJson('Loc', "Bill-to City");
            IF "GST Customer Type" = "GST Customer Type"::Export THEN
                AddToJson('Pin', '999999')
            ELSE
                AddToJson('Pin', "Bill-to Post Code");
            SalesInvoiceLine3.SETRANGE("Document No.", "No.");
            SalesInvoiceLine3.SETFILTER("GST Place of Supply", '<>%1', SalesInvoiceLine3."GST Place of Supply"::" ");
            IF SalesInvoiceLine3.FINDFIRST THEN
                IF SalesInvoiceLine3."GST Place of Supply" = SalesInvoiceLine3."GST Place of Supply"::"Bill-to Address" THEN BEGIN
                    IF "GST Customer Type" IN ["GST Customer Type"::Export, "GST Customer Type"::"Deemed Export", "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                        AddToJson('Pos', '96')
                    ELSE
                        AddToJson('Pos', GetStateCode_POS("GST Bill-to State Code"));
                    IF "GST Customer Type" = "GST Customer Type"::Export THEN
                        AddToJson('Stcd', '96')
                    ELSE
                        AddToJson('Stcd', GetStateCode("GST Bill-to State Code"));
                END ELSE
                    IF SalesInvoiceLine3."GST Place of Supply" = SalesInvoiceLine3."GST Place of Supply"::"Ship-to Address" THEN BEGIN
                        IF "GST Customer Type" IN ["GST Customer Type"::Export, "GST Customer Type"::"Deemed Export", "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                            AddToJson('Pos', '96')
                        ELSE
                            AddToJson('Pos', GetStateCode_POS("GST Ship-to State Code"));
                        IF "GST Customer Type" = "GST Customer Type"::Export THEN
                            AddToJson('Stcd', '96')
                        ELSE
                            AddToJson('Stcd', GetStateCode("GST Ship-to State Code"));

                        IF ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
                            AddToJson('Ph', ShiptoAddress."Phone No.");
                            AddToJson('Em', ShiptoAddress."E-Mail");
                        END;
                    END;
            JsonTextWriter.WriteEndObject;

            IF ("Ship-to Code" <> '') AND (ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code")) THEN BEGIN
                CustGstin := ShiptoAddress."GST Registration No.";

                JsonTextWriter.WritePropertyName('ShipDtls');
                JsonTextWriter.WriteStartObject;
                IF "GST Customer Type" = "GST Customer Type"::Export THEN
                    AddToJson('gstin', 'URP')
                ELSE
                    AddToJson('Gstin', CustGstin);
                AddToJson('LglNm', "Ship-to Name");
                AddToJson('TrdNm', "Ship-to Name");
                AddToJson('Addr1', "Ship-to Address");
                IF "Ship-to Address 2" <> '' THEN
                    AddToJson('Addr2', "Ship-to Address 2");
                AddToJson('Loc', "Ship-to City");
                AddToJson('Pin', "Ship-to Post Code");
                IF "GST Customer Type" IN ["GST Customer Type"::Export, "GST Customer Type"::"Deemed Export", "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                    AddToJson('Stcd', '96')
                ELSE
                    AddToJson('Stcd', GetStateCode_POS("GST Bill-to State Code"));
                JsonTextWriter.WriteEndObject;
            END;
            IF "GST Customer Type" IN
                     ["GST Customer Type"::Export]
                  THEN BEGIN
                IF "Currency Factor" <> 0 THEN
                    LCYCurrency := (1 / "Currency Factor")
                ELSE
                    LCYCurrency := 1;
                JsonTextWriter.WritePropertyName('ExpDtls');
                JsonTextWriter.WriteStartObject;
                AddToJson('ShipBNo', "Bill Of Export No.");
                AddToJson('ShipBDt', GetDateFormated("Bill Of Export Date"));
                AddToJson('Port', "Exit Point");
                AddToJson('RefClm', 'N');
                AddToJson('ForCur', "Currency Code");
                AddToJson('CntCode', "Bill-to Country/Region Code");
                JsonTextWriter.WriteEndObject;
            END;

            IF ("Invoice Type" = "Invoice Type"::"Debit Note") OR
                ("Invoice Type" = "Invoice Type"::Supplementary)
              THEN BEGIN
                RefDocNo := GetRefInvNo(SalesInvoiceHeader."No.");
                IF RefDocNo = '' THEN
                    RefDocNo := SalesInvoiceHeader."Reference Invoice No.";
                IF SalesInvoiceHeader2.GET(RefDocNo) THEN BEGIN
                    JsonTextWriter.WritePropertyName('RefDtls');
                    JsonTextWriter.WriteStartObject;
                    AddToJson('InvRm', 'Sales Invoice');
                    JsonTextWriter.WritePropertyName('DocPerdDtls');
                    JsonTextWriter.WriteStartObject;
                    AddToJson('InvStDt', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
                    AddToJson('InvEndDt', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
                    JsonTextWriter.WriteEndObject;
                    JsonTextWriter.WritePropertyName('PrecDocDtls');
                    JsonTextWriter.WriteStartArray;
                    JsonTextWriter.WriteStartObject;
                    RefDocNo := SalesInvoiceHeader2."No.";

                    AddToJson('InvNo', RefDocNo);
                    AddToJson('InvDt', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
                    JsonTextWriter.WriteEndObject;
                    JsonTextWriter.WriteEndArray;
                    JsonTextWriter.WriteEndObject;
                END;
            END;

            JsonTextWriter.WritePropertyName('ValDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('AssVal', ROUND(GetTaxableAmountSalesInvoice("No.") * LCYCurrency, 0.01, '='));
            AddToJson('CgstVal', GetGSTAmount("No.", 'CGST'));
            AddToJson('SgstVal', GetGSTAmount("No.", 'SGST'));
            AddToJson('IgstVal', GetGSTAmount("No.", 'IGST'));
            AddToJson('CesVal', GetGSTAmount("No.", 'CESS'));

            SalesInvoiceLine2.SETRANGE("Document No.", "No.");
            SalesInvoiceLine2.CALCSUMS("Line Amount", "Inv. Discount Amount", "Total GST Amount", "TDS/TCS Amount");
            AddToJson('Discount', ROUND(SalesInvoiceLine2."Inv. Discount Amount" * LCYCurrency, 0.01, '='));
            //AddToJson('Discount',ROUND((SalesInvoiceLine2."Line Amount"+SalesInvoiceLine2."TDS/TCS Amount"+SalesInvoiceLine2."Total GST Amount"-SalesInvoiceLine2."Inv. Discount Amount") *LCYCurrency,0.01,'='));

            GetRoundingGL(Customer."Customer Posting Group", GstRoundingGL, InvRoundingGL, PITRoundingGL);
            SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine2.Type::"G/L Account");
            IF GstRoundingGL <> '' THEN
                SalesInvoiceLine2.SETFILTER("No.", '%1|%2|%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
            ELSE
                SalesInvoiceLine2.SETFILTER("No.", '%1|%2', InvRoundingGL, PITRoundingGL);
            SalesInvoiceLine2.CALCSUMS("Line Amount");
            AddToJson('RndOffAmt', ROUND(SalesInvoiceLine2."Line Amount" * LCYCurrency, 0.01, '='));
            //CALCFIELDS("Amount to Customer");
            //AddToJson('TotInvVal',ROUND("Amount to Customer"*LCYCurrency,0.01,'='));
            SalesInvoiceLine2.SETRANGE("No.");
            SalesInvoiceLine2.CALCSUMS("Line Amount", "Inv. Discount Amount", "Total GST Amount", "TDS/TCS Amount");
            AddToJson('TotInvVal', ROUND((SalesInvoiceLine2."Line Amount" + SalesInvoiceLine2."TDS/TCS Amount" + SalesInvoiceLine2."Total GST Amount" - SalesInvoiceLine2."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
            JsonTextWriter.WriteEndObject;

            CLEAR(SNo);
            SalesInvoiceLine.SETRANGE("Document No.", "No.");
            IF GstRoundingGL <> '' THEN
                SalesInvoiceLine.SETFILTER("No.", '<>%1&<>%2&<>%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
            ELSE
                SalesInvoiceLine.SETFILTER("No.", '<>%1&<>%2', InvRoundingGL, PITRoundingGL);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                JsonTextWriter.WritePropertyName('ItemList');
                JsonTextWriter.WriteStartArray;
                REPEAT
                    IF SalesInvoiceLine."Unit Price" > 0 THEN BEGIN
                        SNo += 1;
                        JsonTextWriter.WriteStartObject;
                        AddToJson('SlNo', SNo);
                        AddToJson('PrdDesc', SalesInvoiceLine.Description);
                        IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN
                            AddToJson('IsServc', 'Y')
                        ELSE
                            AddToJson('IsServc', 'N');
                        AddToJson('HsnCd', SalesInvoiceLine."HSN/SAC Code");
                        AddToJson('Qty', SalesInvoiceLine.Quantity);
                        IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN
                            AddToJson('Unit', 'OTH')
                        ELSE
                            AddToJson('Unit', GetUOM(SalesInvoiceLine."Unit of Measure Code"));
                        AddToJson('UnitPrice', ROUND(SalesInvoiceLine."Unit Price" * LCYCurrency, 0.01, '='));
                        AddToJson('TotAmt', ROUND((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * LCYCurrency, 0.01, '='));

                        PostedStructureOrderDetails.SETRANGE(Type, PostedStructureOrderDetails.Type::Sale);
                        PostedStructureOrderDetails.SETRANGE("Document Type", PostedStructureOrderDetails."Document Type"::Invoice);
                        PostedStructureOrderDetails.SETRANGE("No.", "No.");
                        PostedStructureOrderDetails.SETRANGE("Structure Code", Structure);
                        IF PostedStructureOrderDetails.FINDFIRST THEN BEGIN
                            IF (PostedStructureOrderDetails."Include Line Discount") AND (PostedStructureOrderDetails."Include Invoice Discount") THEN
                                AddToJson('Discount', ROUND((SalesInvoiceLine."Line Discount Amount" + SalesInvoiceLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
                            ELSE
                                IF (NOT PostedStructureOrderDetails."Include Line Discount") AND (PostedStructureOrderDetails."Include Invoice Discount") THEN
                                    AddToJson('Discount', ROUND((SalesInvoiceLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
                                ELSE
                                    IF (PostedStructureOrderDetails."Include Line Discount") AND (NOT PostedStructureOrderDetails."Include Invoice Discount") THEN
                                        AddToJson('Discount', ROUND((SalesInvoiceLine."Line Discount Amount") * LCYCurrency, 0.01, '='));
                        END;

                        AddToJson('AssAmt', ROUND(SalesInvoiceLine."GST Base Amount" * LCYCurrency, 0.01, '='));
                        IF SalesInvoiceLine."GST Jurisdiction Type" = SalesInvoiceLine."GST Jurisdiction Type"::Interstate THEN
                            AddToJson('GstRt', GetGSTRate(SalesInvoiceLine."Document No.", 'IGST', SalesInvoiceLine."Line No."))
                        ELSE
                            AddToJson('GstRt', GetGSTRate(SalesInvoiceLine."Document No.", 'CGST', SalesInvoiceLine."Line No.") * 2);
                        AddToJson('CgstAmt', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'CGST', SalesInvoiceLine."Line No."));
                        AddToJson('SgstAmt', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'SGST', SalesInvoiceLine."Line No."));
                        AddToJson('IgstAmt', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'IGST', SalesInvoiceLine."Line No."));
                        AddToJson('CesRt', GetGSTRate(SalesInvoiceLine."Document No.", 'CESS', SalesInvoiceLine."Line No."));
                        AddToJson('CesAmt', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'CESS', SalesInvoiceLine."Line No."));
                        AddToJson('OthChrg', ROUND((SalesInvoiceLine."TDS/TCS Amount") * LCYCurrency, 0.01, '='));
                        //AddToJson('TotItemVal',ROUND((SalesInvoiceLine."Line Amount"+SalesInvoiceLine."TDS/TCS Amount"+SalesInvoiceLine."Total GST Amount"-SalesInvoiceLine."Inv. Discount Amount")*LCYCurrency,0.01,'='));
                        AddToJson('TotItemVal', ROUND((SalesInvoiceLine."Amount Including Tax" + SalesInvoiceLine."Total GST Amount") * LCYCurrency, 0.01, '='));
                        JsonTextWriter.WriteEndObject;
                    END
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;
            JsonTextWriter.WriteEndArray;
            EndJson;


            GenerateEInvoice('', ResponseText, FALSE);

            Json := ResponseText;
            ReadJSon(Json, DataExch);

            AckNo := GetJsonNodeValue('AckNo');
            AckDt := GetJsonNodeValue('AckDt');
            Irn := GetJsonNodeValue('Irn');
            SignedQRCode := GetJsonNodeValue('SignedQRCode');
            InsertResponse('', "No.", 1, AckNo, AckDt, Irn,
                          SignedQRCode, GetJsonNodeValue('Status'), GetJsonNodeValue('ErrorDetails..error_message'), "Posting Date"
                    , '', GetJsonNodeValue('SignedInvoice'), GetJsonNodeValue('info..Desc'));
            IF Irn <> '' THEN
                ValidateIRNandImportDetails(
                          SalesInvoiceHeader,
                          Irn, AckNo, SignedQRCode, AckDt);
            COMMIT;
            IF GetJsonNodeValue('info..Desc') <> '' THEN
                MESSAGE(GetJsonNodeValue('info..Desc'))
            ELSE
                IF Irn <> '' THEN
                    MESSAGE(Text50000, "No.")
                ELSE
                    ERROR(Text50001, GetJsonNodeValue('ErrorDetails..error_message'), '');
        END;
    end;

    local procedure CreateJSONTransferShipment(TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        ShiptoAddress: Record "Ship-to Address";
        TransferShipmentHeader2: Record "Transfer Shipment Header";
        DataExch: Record "Data Exch. Field";
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_rec: Record State;
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
        eCommerceMerchantId: Record "e-Commerce Merchant Id";
        LocationTo: Record Location;
        TransferShipmentLine2: Record "Transfer Shipment Line";
        TempBlob: Record TempBlob;
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        FL: File;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        CustGstin: Code[15];
        State_Gst: Code[2];
        CustGstin2: Code[15];
        TknNo: Text[50];
        ResponseText: Text;
        JString: Text;
        AckNo: Text;
        Irn: Text;
        Mnth: Text[2];
        Day: Text[2];
        SignedQRCode: Text;
        SNo: Integer;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
        AckDt: Variant;
    begin
        WITH TransferShipmentHeader DO BEGIN
            IF NOT CheckGST("No.") THEN
                EXIT;
            EInvIntegrationSetup.GET;

            GetCompanyInfo;
            TknNo := GetAccessToken;
            Location.GET("Transfer-from Code");
            LocationTo.GET("Transfer-to Code");

            //IF Location."State Code" = LocationTo."State Code" THEN
            IF Location."GST Registration No." = LocationTo."GST Registration No." THEN
                EXIT;
            CheckEInvoiceStatus("No.", 3, FALSE);

            StartJson;
            AddToJson('access_token', TknNo);
            AddToJson('user_gstin', GetGSTIN("Transfer-from Code"));
            AddToJson('data_soure', 'erp');

            JsonTextWriter.WritePropertyName('transaction_details');
            JsonTextWriter.WriteStartObject;
            AddToJson('supply_type', 'B2B');
            AddToJson('charge_type', 'N');
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('document_details');
            JsonTextWriter.WriteStartObject;
            AddToJson('document_type', 'INV');
            AddToJson('document_number', "No.");
            AddToJson('document_date', GetDateFormated("Posting Date"));
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('seller_details');
            JsonTextWriter.WriteStartObject;
            AddToJson('gstin', GetGSTIN("Transfer-from Code"));

            AddToJson('legal_name', CompanyInformation.Name);
            AddToJson('trade_name', Location.Name);
            AddToJson('address1', Location.Address);
            IF Location."Address 2" <> '' THEN
                AddToJson('address2', Location."Address 2");

            AddToJson('location', Location.City);
            AddToJson('pincode', Location."Post Code");
            AddToJson('state_code', GetStateCode(Location."State Code"));
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('buyer_details');
            JsonTextWriter.WriteStartObject;
            AddToJson('gstin', GetGSTIN("Transfer-to Code"));
            AddToJson('legal_name', CompanyInformation.Name);
            AddToJson('trade_name', LocationTo.Name);
            AddToJson('address1', LocationTo.Address);
            IF LocationTo."Address 2" <> '' THEN
                AddToJson('address2', LocationTo."Address 2");

            AddToJson('location', LocationTo.City);
            AddToJson('pincode', LocationTo."Post Code");
            AddToJson('place_of_supply', GetStateCode_POS(LocationTo."State Code"));
            AddToJson('state_code', GetStateCode(LocationTo."State Code"));
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('value_details');
            JsonTextWriter.WriteStartObject;
            AddToJson('total_assessable_value', ROUND(GetTaxableAmountTransfer("No."), 0.01, '='));
            AddToJson('total_cgst_value', GetGSTAmount("No.", 'CGST'));
            AddToJson('total_sgst_value', GetGSTAmount("No.", 'SGST'));
            AddToJson('total_igst_value', GetGSTAmount("No.", 'IGST'));
            AddToJson('total_cess_value', GetGSTAmount("No.", 'CESS'));
            //AddToJson('total_cess_value_of_state',GetGSTAmount("No.",'CESS'));

            TransferShipmentLine2.SETRANGE("Document No.", "No.");
            TransferShipmentLine2.CALCSUMS("Total GST Amount");

            AddToJson('total_invoice_value', ROUND(GetTaxableAmountTransfer("No.") + TransferShipmentLine2."Total GST Amount", 0.01, '='));
            JsonTextWriter.WriteEndObject;

            CLEAR(SNo);
            TransferShipmentLine.SETRANGE("Document No.", "No.");
            TransferShipmentLine.SETFILTER("Item No.", '<>%1', '');
            TransferShipmentLine.SETFILTER(Quantity, '<>%1', 0);
            IF TransferShipmentLine.FINDSET THEN BEGIN
                JsonTextWriter.WritePropertyName('item_list');
                JsonTextWriter.WriteStartArray;
                REPEAT
                    SNo += 1;
                    JsonTextWriter.WriteStartObject;
                    AddToJson('item_serial_number', SNo);
                    AddToJson('product_description', TransferShipmentLine.Description);
                    AddToJson('is_service', 'N');
                    AddToJson('hsn_code', TransferShipmentLine."HSN/SAC Code");
                    AddToJson('quantity', TransferShipmentLine.Quantity);
                    AddToJson('unit', GetUOM(TransferShipmentLine."Unit of Measure Code"));
                    AddToJson('unit_price', ROUND(TransferShipmentLine."Unit Price", 0.01, '='));
                    AddToJson('total_amount', ROUND(TransferShipmentLine."GST Base Amount", 0.01, '='));
                    AddToJson('assessable_value', ROUND(TransferShipmentLine."GST Base Amount", 0.01, '='));
                    IF Location."State Code" <> LocationTo."State Code" THEN
                        AddToJson('gst_rate', GetGSTRate(TransferShipmentLine."Document No.", 'IGST', TransferShipmentLine."Line No."))
                    ELSE
                        AddToJson('gst_rate', GetGSTRate(TransferShipmentLine."Document No.", 'CGST', TransferShipmentLine."Line No.") * 2);
                    AddToJson('cgst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'CGST', TransferShipmentLine."Line No."));
                    AddToJson('sgst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'SGST', TransferShipmentLine."Line No."));
                    AddToJson('igst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'IGST', TransferShipmentLine."Line No."));
                    AddToJson('cess_rate', GetGSTRate(TransferShipmentLine."Document No.", 'CESS', TransferShipmentLine."Line No."));
                    AddToJson('cess_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'CESS', TransferShipmentLine."Line No."));
                    AddToJson('cess_nonadvol_value', 0);
                    //AddToJson('state_cess_rate',GetGSTRate(TransferShipmentLine."Document No.",'CESS',TransferShipmentLine."Line No."));
                    //AddToJson('state_cess_amount',GetGSTAmountLineWise(TransferShipmentLine."Document No.",'CESS',TransferShipmentLine."Line No."));
                    AddToJson('total_item_value', ROUND(TransferShipmentLine."GST Base Amount" + TransferShipmentLine."Total GST Amount", 0.01, '='));
                    JsonTextWriter.WriteEndObject;
                UNTIL TransferShipmentLine.NEXT = 0;
            END;
            JsonTextWriter.WriteEndArray;
            EndJson;

            GenerateEInvoice('', ResponseText, FALSE);

            Json := ResponseText;
            ReadJSon(Json, DataExch);

            AckNo := GetJsonNodeValue('results.message.AckNo');
            AckDt := GetJsonNodeValue('results.message.AckDt');
            Irn := GetJsonNodeValue('results.message.Irn');
            SignedQRCode := GetJsonNodeValue('results.message.SignedQRCode');
            InsertResponse(GetJsonNodeValue('results.requestId'), "No.", 3, AckNo, AckDt,
                Irn, SignedQRCode, GetJsonNodeValue('results.status'), GetJsonNodeValue('results.errorMessage'), "Posting Date"
                              , GetJsonNodeValue('results.message.QRCodeUrl'), GetJsonNodeValue('results.message.EinvoicePdf'), GetJsonNodeValue('results.InfoDtls'));
            COMMIT;
            IF Irn <> '' THEN
                MESSAGE(Text50000, "No.")
            ELSE
                ERROR(Text50001, GetJsonNodeValue('results.errorMessage'), GetJsonNodeValue('results.requestId'));
        END;
    end;

    local procedure CreateJSONSalesCrmemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        Customer: Record Customer;
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShiptoAddress: Record "Ship-to Address";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        DataExch: Record "Data Exch. Field";
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_rec: Record State;
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
        eCommerceMerchantId: Record "e-Commerce Merchant Id";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        EInvoicingRequests: Record "E-Invoicing Requests";
        TempBlob: Record TempBlob;
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        SalesCrMemoLine3: Record "Sales Cr.Memo Line";
        PostedStructureOrderDetails: Record "Posted Structure Order Details";
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        FL: File;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        CustGstin: Code[15];
        State_Gst: Code[2];
        RefDocNo: Code[20];
        GstRoundingGL: Code[20];
        InvRoundingGL: Code[20];
        PITRoundingGL: Code[20];
        TknNo: Text;
        ResponseText: Text;
        JString: Text;
        AckNo: Text;
        Irn: Text;
        Mnth: Text[2];
        Day: Text[2];
        SignedQRCode: Text;
        Text50000: Label 'You cannot generate E-Invoice for Credit Memo %1 as E-Invoice for Applied Invoice %2 is not generated.';
        AckDt: Variant;
        SNo: Integer;
        LCYCurrency: Decimal;
        Text50001: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50002: Label '%1 Please share this request ID for support %2.';
    begin
        WITH SalesCrMemoHeader DO BEGIN
            IF NOT CheckGST("No.") THEN
                EXIT;
            EInvIntegrationSetup.GET;
            IF (EInvIntegrationSetup."Activation Date" = 0D) OR (EInvIntegrationSetup."Activation Date" > "Posting Date") THEN
                EXIT;
            IF ("Nature of Supply" = "Nature of Supply"::B2C) THEN
                EXIT;
            RefDocNo := GetRefInvNo(SalesCrMemoHeader."No.");
            IF RefDocNo = '' THEN
                RefDocNo := SalesCrMemoHeader."Reference Invoice No.";

            IF SalesInvoiceHeader.GET(RefDocNo) THEN
                IF SalesInvoiceHeader."Posting Date" >= EInvIntegrationSetup."Activation Date" THEN BEGIN // Date acc. to E-Inv Live Date
                                                                                                          //EXIT;
                    EInvoicingRequests.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
                    EInvoicingRequests.SETRANGE("Document Type", EInvoicingRequests."Document Type"::"Sale Invoice");
                    EInvoicingRequests.SETRANGE("Document No.", RefDocNo);
                    EInvoicingRequests.SETRANGE("E-Invoice Generated", FALSE);
                    IF EInvoicingRequests.FINDFIRST THEN
                        ERROR(Text50000, SalesCrMemoHeader."No.", RefDocNo);
                END;
            CheckEInvoiceStatus("No.", 2, FALSE);

            GetCompanyInfo;
            //TknNo := GetAccessToken;
            TknNo := EInvIntegrationSetup."Access Token";
            Location.GET("Location Code");
            OwnerId := Location."Cleartax Owner ID";
            LocGstRegNo := Location."GST Registration No.";
            Customer.GET("Bill-to Customer No.");
            LCYCurrency := 1;
            StartJson;
            AddToJson('Version', '1.1');
            JsonTextWriter.WritePropertyName('TranDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('TaxSch', 'GST');
            CASE "GST Customer Type" OF
                "GST Customer Type"::Export:
                    BEGIN
                        IF "GST Without Payment of Duty" THEN
                            AddToJson('SupTyp', 'EXPWOP')
                        ELSE
                            AddToJson('SupTyp', 'EXPWP');
                    END;
                "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit":
                    BEGIN
                        IF "GST Without Payment of Duty" THEN
                            AddToJson('SupTyp', 'SEZWOP')
                        ELSE
                            AddToJson('SupTyp', 'SEZWP');
                    END;
                "GST Customer Type"::"Deemed Export":
                    AddToJson('SupTyp', 'DEXP');
                "GST Customer Type"::Registered, "GST Customer Type"::Exempted:
                    AddToJson('SupTyp', 'B2B');
            END;
            AddToJson('RegRev', 'N');
            IF "POS Out Of India" THEN
                AddToJson('IgstOnIntra', 'Y')
            ELSE
                AddToJson('IgstOnIntra', 'N');
            IF "e-Commerce Customer" <> '' THEN BEGIN
                IF eCommerceMerchantId.GET("e-Commerce Customer", "e-Commerce Merchant Id") THEN
                    AddToJson('EcmGstin', eCommerceMerchantId."Company GST Reg. No.");
            END;

            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('DocDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('Typ', 'CRN');
            AddToJson('No', "No.");
            AddToJson('Dt', GetDateFormated("Posting Date"));
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('SellerDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('Gstin', GetGSTIN("Location Code"));
            AddToJson('LglNm', CompanyInformation.Name);
            AddToJson('LglNm', Location.Name);
            AddToJson('Addr1', Location.Address);
            IF Location."Address 2" <> '' THEN
                AddToJson('Addr2', Location."Address 2");

            AddToJson('Loc', Location.City);
            AddToJson('Pin', Location."Post Code");
            AddToJson('Stcd', GetStateCode(Location."State Code"));
            AddToJson('Ph', Location."Phone No.");
            AddToJson('Em', Location."E-Mail");
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('BuyerDtls');
            JsonTextWriter.WriteStartObject;

            IF ("GST Customer Type" = "GST Customer Type"::Export) THEN
                AddToJson('Gstin', 'URP')
            ELSE
                AddToJson('Gstin', Customer."GST Registration No.");

            AddToJson('LglNm', "Bill-to Name");
            AddToJson('TrdNm', "Bill-to Name");
            AddToJson('Addr1', "Bill-to Address");
            IF "Bill-to Address 2" <> '' THEN
                AddToJson('Addr2', "Bill-to Address 2");

            AddToJson('Loc', "Bill-to City");
            IF "GST Customer Type" = "GST Customer Type"::Export THEN
                AddToJson('Pin', '999999')
            ELSE
                AddToJson('Pin', "Bill-to Post Code");


            AddToJson('place_of_supply', GetStateCode_POS("GST Bill-to State Code"));
            AddToJson('Stcd', GetStateCode("GST Bill-to State Code"));

            SalesCrMemoLine3.SETRANGE("Document No.", "No.");
            SalesCrMemoLine3.SETFILTER("GST Place of Supply", '<>%1', SalesCrMemoLine3."GST Place of Supply"::" ");
            IF SalesCrMemoLine3.FINDFIRST THEN
                IF SalesCrMemoLine3."GST Place of Supply" = SalesCrMemoLine3."GST Place of Supply"::"Bill-to Address" THEN BEGIN
                    IF "GST Customer Type" IN ["GST Customer Type"::Export, "GST Customer Type"::"Deemed Export", "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                        AddToJson('Pos', '96')
                    ELSE
                        AddToJson('Pos', GetStateCode_POS("GST Bill-to State Code"));
                    IF "GST Customer Type" = "GST Customer Type"::Export THEN
                        AddToJson('Stcd', '96')
                    ELSE
                        AddToJson('Stcd', GetStateCode("GST Bill-to State Code"));
                END ELSE
                    IF SalesCrMemoLine3."GST Place of Supply" = SalesCrMemoLine3."GST Place of Supply"::"Ship-to Address" THEN BEGIN
                        IF "GST Customer Type" IN ["GST Customer Type"::Export, "GST Customer Type"::"Deemed Export", "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                            AddToJson('Pos', '96')
                        ELSE
                            AddToJson('Pos', GetStateCode_POS("GST Ship-to State Code"));

                        IF "GST Customer Type" = "GST Customer Type"::Export THEN
                            AddToJson('Stcd', '96')
                        ELSE
                            AddToJson('Stcd', GetStateCode("GST Ship-to State Code"));

                        IF ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
                            AddToJson('Ph', ShiptoAddress."Phone No.");
                            AddToJson('Em', ShiptoAddress."E-Mail");
                        END;
                    END;
            JsonTextWriter.WriteEndObject;

            IF ("Ship-to Code" <> '') AND (ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code")) THEN BEGIN
                CustGstin := ShiptoAddress."GST Registration No.";

                JsonTextWriter.WritePropertyName('ShipDtls');
                JsonTextWriter.WriteStartObject;
                IF "GST Customer Type" = "GST Customer Type"::Export THEN
                    AddToJson('gstin', 'URP')
                ELSE
                    AddToJson('Gstin', CustGstin);
                AddToJson('LglNm', "Ship-to Name");
                AddToJson('TrdNm', "Ship-to Name");
                AddToJson('Addr1', "Ship-to Address");
                IF "Ship-to Address 2" <> '' THEN
                    AddToJson('Addr2', "Ship-to Address 2");
                AddToJson('Loc', "Ship-to City");
                AddToJson('Pin', "Ship-to Post Code");
                AddToJson('Stcd', GetStateCode("GST Ship-to State Code"));
                JsonTextWriter.WriteEndObject;
            END;
            IF "GST Customer Type" IN
                ["GST Customer Type"::Export]
                   THEN BEGIN
                IF "Currency Factor" <> 0 THEN
                    LCYCurrency := (1 / "Currency Factor")
                ELSE
                    LCYCurrency := 1;
                JsonTextWriter.WritePropertyName('ExpDtls');
                JsonTextWriter.WriteStartObject;
                AddToJson('ShipBNo', "Bill Of Export No.");
                AddToJson('ShipBDt', GetDateFormated("Bill Of Export Date"));
                AddToJson('Port', "Exit Point");
                AddToJson('RefClm', 'Y');
                AddToJson('ForCur', "Currency Code");
                AddToJson('CntCode', "Bill-to Country/Region Code");
                JsonTextWriter.WriteEndObject;
            END;

            JsonTextWriter.WritePropertyName('RefDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('InvRm', 'Sale Return');
            JsonTextWriter.WritePropertyName('DocPerdDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('InvStDt', GetDateFormated(SalesInvoiceHeader."Posting Date"));
            AddToJson('InvEndDt', GetDateFormated(SalesInvoiceHeader."Posting Date"));
            JsonTextWriter.WriteEndObject;
            JsonTextWriter.WritePropertyName('PrecDocDtls');
            JsonTextWriter.WriteStartArray;
            JsonTextWriter.WriteStartObject;
            AddToJson('InvNo', SalesInvoiceHeader."No.");
            AddToJson('InvDt', GetDateFormated(SalesInvoiceHeader."Posting Date"));
            JsonTextWriter.WriteEndObject;
            JsonTextWriter.WriteEndArray;
            JsonTextWriter.WriteEndObject;

            JsonTextWriter.WritePropertyName('ValDtls');
            JsonTextWriter.WriteStartObject;
            AddToJson('AssVal', ROUND(GetTaxableAmountSCrMemo("No.") * LCYCurrency, 0.01, '='));
            AddToJson('CgstVal', GetGSTAmount("No.", 'CGST'));
            AddToJson('SgstVal', GetGSTAmount("No.", 'SGST'));
            AddToJson('IgstVal', GetGSTAmount("No.", 'IGST'));
            AddToJson('CesVal', GetGSTAmount("No.", 'CESS'));

            SalesCrMemoLine2.SETRANGE("Document No.", "No.");
            SalesCrMemoLine2.CALCSUMS("Line Amount", "Inv. Discount Amount", "Total GST Amount");
            AddToJson('Discount', ROUND(SalesCrMemoLine2."Inv. Discount Amount" * LCYCurrency, 0.01, '='));
            //AddToJson('Discount',ROUND((SalesCrMemoLine2."Line Amount"+SalesCrMemoLine2."Total GST Amount"-SalesCrMemoLine2."Inv. Discount Amount") *LCYCurrency,0.01,'='));
            GetRoundingGL(Customer."Customer Posting Group", GstRoundingGL, InvRoundingGL, PITRoundingGL);
            SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::"G/L Account");
            IF GstRoundingGL <> '' THEN
                SalesCrMemoLine2.SETFILTER("No.", '%1|%2|%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
            ELSE
                SalesCrMemoLine2.SETFILTER("No.", '%1|%2', InvRoundingGL, PITRoundingGL);
            SalesCrMemoLine2.CALCSUMS("Line Amount");
            AddToJson('RndOffAmt', ROUND(SalesCrMemoLine2."Line Amount" * LCYCurrency, 0.01, '='));
            //CALCFIELDS("Amount to Customer");
            //AddToJson('TotInvVal',ROUND("Amount to Customer"*LCYCurrency,0.01,'='));
            SalesCrMemoLine2.SETRANGE("No.");
            SalesCrMemoLine2.CALCSUMS("Line Amount", "Inv. Discount Amount", "Total GST Amount", "TDS/TCS Amount");
            AddToJson('TotInvVal', ROUND((SalesCrMemoLine2."Line Amount" + SalesCrMemoLine2."TDS/TCS Amount" + SalesCrMemoLine2."Total GST Amount" - SalesCrMemoLine2."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
            JsonTextWriter.WriteEndObject;

            CLEAR(SNo);
            SalesCrMemoLine.SETRANGE("Document No.", "No.");
            IF GstRoundingGL <> '' THEN
                SalesCrMemoLine.SETFILTER("No.", '<>%1&<>%2&<>%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
            ELSE
                SalesCrMemoLine.SETFILTER("No.", '<>%1&<>%2', InvRoundingGL, PITRoundingGL);
            SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
            IF SalesCrMemoLine.FINDSET THEN BEGIN
                JsonTextWriter.WritePropertyName('ItemList');
                JsonTextWriter.WriteStartArray;
                REPEAT
                    SNo += 1;
                    JsonTextWriter.WriteStartObject;
                    AddToJson('SlNo', SNo);
                    AddToJson('PrdDesc', SalesCrMemoLine.Description);
                    IF SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service THEN
                        AddToJson('IsServc', 'Y')
                    ELSE
                        AddToJson('IsServc', 'N');
                    AddToJson('HsnCd', SalesCrMemoLine."HSN/SAC Code");
                    AddToJson('Qty', SalesCrMemoLine.Quantity);
                    IF SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service THEN
                        AddToJson('Unit', 'OTH')
                    ELSE
                        AddToJson('Unit', GetUOM(SalesCrMemoLine."Unit of Measure Code"));
                    AddToJson('UnitPrice', ROUND(SalesCrMemoLine."Unit Price" * LCYCurrency, 0.01, '='));
                    AddToJson('TotAmt', ROUND((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * LCYCurrency, 0.01, '='));

                    PostedStructureOrderDetails.SETRANGE(Type, PostedStructureOrderDetails.Type::Sale);
                    PostedStructureOrderDetails.SETRANGE("Document Type", PostedStructureOrderDetails."Document Type"::"Credit Memo");
                    PostedStructureOrderDetails.SETRANGE("No.", "No.");
                    PostedStructureOrderDetails.SETRANGE("Structure Code", Structure);
                    IF PostedStructureOrderDetails.FINDFIRST THEN BEGIN
                        IF (PostedStructureOrderDetails."Include Line Discount") AND (PostedStructureOrderDetails."Include Invoice Discount") THEN
                            AddToJson('Discount', ROUND((SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
                        ELSE
                            IF (NOT PostedStructureOrderDetails."Include Line Discount") AND (PostedStructureOrderDetails."Include Invoice Discount") THEN
                                AddToJson('Discount', ROUND((SalesCrMemoLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
                            ELSE
                                IF (PostedStructureOrderDetails."Include Line Discount") AND (NOT PostedStructureOrderDetails."Include Invoice Discount") THEN
                                    AddToJson('Discount', ROUND((SalesCrMemoLine."Line Discount Amount") * LCYCurrency, 0.01, '='));
                    END;

                    AddToJson('AssAmt', ROUND(SalesCrMemoLine."GST Base Amount" * LCYCurrency, 0.01, '='));
                    IF SalesCrMemoLine."GST Jurisdiction Type" = SalesCrMemoLine."GST Jurisdiction Type"::Interstate THEN
                        AddToJson('GstRt', GetGSTRate(SalesCrMemoLine."Document No.", 'IGST', SalesCrMemoLine."Line No."))
                    ELSE
                        AddToJson('GstRt', GetGSTRate(SalesCrMemoLine."Document No.", 'CGST', SalesCrMemoLine."Line No.") * 2);
                    AddToJson('CgstAmt', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'CGST', SalesCrMemoLine."Line No."));
                    AddToJson('SgstAmt', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'SGST', SalesCrMemoLine."Line No."));
                    AddToJson('IgstAmt', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'IGST', SalesCrMemoLine."Line No."));
                    AddToJson('CesRt', GetGSTRate(SalesCrMemoLine."Document No.", 'CESS', SalesCrMemoLine."Line No."));
                    AddToJson('CesAmt', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'CESS', SalesCrMemoLine."Line No."));
                    //AddToJson('TotItemVal',ROUND((SalesCrMemoLine."Line Amount"+SalesCrMemoLine."Total GST Amount"-SalesCrMemoLine."Inv. Discount Amount")*LCYCurrency,0.01,'='));
                    AddToJson('TotItemVal', ROUND((SalesCrMemoLine."Amount Including Tax" + SalesCrMemoLine."Total GST Amount") * LCYCurrency, 0.01, '='));
                    JsonTextWriter.WriteEndObject;
                UNTIL SalesCrMemoLine.NEXT = 0;
            END;
            JsonTextWriter.WriteEndArray;
            EndJson;

            GenerateEInvoice('', ResponseText, FALSE);

            Json := ResponseText;
            ReadJSon(Json, DataExch);

            AckNo := GetJsonNodeValue('AckNo');
            AckDt := GetJsonNodeValue('AckDt');
            Irn := GetJsonNodeValue('Irn');
            SignedQRCode := GetJsonNodeValue('SignedQRCode');
            InsertResponse('', "No.", 1, AckNo, AckDt, Irn,
                          SignedQRCode, GetJsonNodeValue('Status'), GetJsonNodeValue('ErrorDetails..error_message'), "Posting Date"
                    , '', GetJsonNodeValue('SignedInvoice'), GetJsonNodeValue('info..Desc'));
            IF Irn <> '' THEN
                ValidateIRNandImportDetailsCrMemo(
                          SalesCrMemoHeader,
                          Irn, AckNo, SignedQRCode, AckDt);
            COMMIT;
            IF GetJsonNodeValue('info..Desc') <> '' THEN
                MESSAGE(GetJsonNodeValue('info..Desc'))
            ELSE
                IF Irn <> '' THEN
                    MESSAGE(Text50000, "No.")
                ELSE
                    ERROR(Text50001, GetJsonNodeValue('ErrorDetails..error_message'), '');
        END;
    end;

    local procedure CancelJSONSalesInvoice(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        Location: Record Location;
        TempBlob: Record TempBlob;
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        FL: File;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        TknNo: Text[250];
        ResponseText: Text;
        JString: Text;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
        TypeHelper: Codeunit "Type Helper";
        DataExch: Record "Data Exch. Field";
        Irn: Text;
        CancelDate: DateTime;
        DTVariant: Variant;
    begin
        WITH SalesInvoiceHeader DO BEGIN
            IF NOT CheckGST("No.") THEN
                EXIT;
            GetEInvSetup;
            IF ("Nature of Supply" = "Nature of Supply"::B2C) THEN
                EXIT;

            CheckEInvoiceStatus("No.", 1, TRUE);

            Location.GET("Location Code");
            OwnerId := Location."Cleartax Owner ID";
            LocGstRegNo := Location."GST Registration No.";
            TESTFIELD("Cancel Reason");
            GetCompanyInfo;
            TknNo := EInvIntegrationSetup."Access Token";
            StartJson;
            AddToJson('irn', "IRN Hash");
            AddToJson('CnlRsn', TypeHelper.GetOptionNo(FORMAT("Cancel Reason"), ' ,Duplicate,Data Entry Mistake,Order Canceled,Other'));
            AddToJson('CnlRem', FORMAT("Cancel Reason"));
            EndJson;


            GenerateEInvoice('', ResponseText, TRUE);

            Json := ResponseText;
            ReadJSon(Json, DataExch);

            Irn := GetJsonNodeValue('Irn');
            DTVariant := 0DT;
            TypeHelper.Evaluate(DTVariant, GetJsonNodeValue('CancelDate'), '', '');
            CancelDate := DTVariant;
            InsertCancelResponse("No.", 1, Irn, GetJsonNodeValue('Status'), GetJsonNodeValue('ErrorDetails..error_message'),
                        "Posting Date", CancelDate);
            "E-Inv. Cancelled Date" := CancelDate;
            MODIFY;
            COMMIT;
            IF GetJsonNodeValue('Success') = 'Y' THEN
                MESSAGE(Text90000)
            ELSE
                ERROR(Text50001, GetJsonNodeValue('ErrorDetails..error_message'), '');
        END;
    end;

    local procedure UpdateIRNOnDoc(DocNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; IRN: Text)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
    begin
        IF DocType = 1 THEN BEGIN
            IF SalesInvoiceHeader.GET(DocNo) THEN BEGIN
                SalesInvoiceHeader."IRN Hash" := IRN;
                SalesInvoiceHeader.MODIFY;
            END;
        END ELSE
            IF DocType = 2 THEN BEGIN
                IF SalesCrMemoHeader.GET(DocNo) THEN BEGIN
                    SalesCrMemoHeader."IRN Hash" := IRN;
                    SalesCrMemoHeader.MODIFY;
                END;
            END;
    end;

    local procedure CheckEInvoiceStatus(DocumentNo: Code[20]; DocType: Option; Canceled: Boolean)
    var
        EInvoicingRequests: Record "E-Invoicing Requests";
        Text50000: Label 'E-Invoice is already generated/cancelled for Document No. %1.';
    begin
        EInvoicingRequests.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
        EInvoicingRequests.SETRANGE("Document Type", DocType);
        EInvoicingRequests.SETRANGE("Document No.", DocumentNo);
        IF NOT Canceled THEN
            EInvoicingRequests.SETRANGE("E-Invoice Generated", TRUE)
        ELSE
            EInvoicingRequests.SETRANGE("E-Invoice Canceled", TRUE);
        IF EInvoicingRequests.FINDFIRST THEN
            ERROR(Text50000, DocumentNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, 33083461, 'CheckEInvoiceStatusForReportPrinting', '', false, false)]
    local procedure CheckEInvoiceStatusForReportPrint(DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; DocNo: Code[20])
    var
        GSTManagement: Codeunit "GST Management";
        EInvoicingRequests: Record "E-Invoicing Requests";
        Text50000: Label 'E-Invoice is not generated for Document No. %1.';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        Location: Record Location;
        LocationTo: Record Location;
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
    begin
        EInvIntegrationSetup.GET;
        CASE DocType OF
            DocType::"Sale Invoice":
                BEGIN
                    IF SalesInvoiceHeader.GET(DocNo) THEN BEGIN
                        IF SalesInvoiceHeader."Nature of Supply" = SalesInvoiceHeader."Nature of Supply"::B2C THEN
                            EXIT;
                        IF NOT GSTManagement.CheckGSTStrucure(SalesInvoiceHeader.Structure) THEN
                            EXIT;
                        IF SalesInvoiceHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN
                            EXIT;
                    END;
                END;
            DocType::"Sale Cr. Memo":
                BEGIN
                    IF SalesCrMemoHeader.GET(DocNo) THEN BEGIN
                        IF SalesCrMemoHeader."Nature of Supply" = SalesCrMemoHeader."Nature of Supply"::B2C THEN
                            EXIT;
                        IF NOT GSTManagement.CheckGSTStrucure(SalesCrMemoHeader.Structure) THEN
                            EXIT;
                        IF SalesCrMemoHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN
                            EXIT;
                    END;
                END;
            DocType::Transfer:
                BEGIN
                    IF TransferShipmentHeader.GET(DocNo) THEN BEGIN
                        Location.GET(TransferShipmentHeader."Transfer-from Code");
                        LocationTo.GET(TransferShipmentHeader."Transfer-to Code");
                        IF Location."State Code" = LocationTo."State Code" THEN
                            EXIT;
                        IF NOT GSTManagement.CheckGSTStrucure(TransferShipmentHeader.Structure) THEN
                            EXIT;
                        IF TransferShipmentHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN
                            EXIT;
                    END;
                END;
        END;

        EInvoicingRequests.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
        EInvoicingRequests.SETRANGE("Document Type", DocType);
        EInvoicingRequests.SETRANGE("Document No.", DocNo);
        EInvoicingRequests.SETRANGE("E-Invoice Generated", TRUE);
        IF NOT EInvoicingRequests.FINDFIRST THEN
            ERROR(Text50000, DocNo);
    end;

    local procedure GetRefInvNo(DocNo: Code[20]) RefInvNo: Code[20]
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin
        ReferenceInvoiceNo.SETRANGE("Document No.", DocNo);
        IF ReferenceInvoiceNo.FINDFIRST THEN
            RefInvNo := ReferenceInvoiceNo."Reference Invoice Nos."
        ELSE
            RefInvNo := '';
    end;

    local procedure "//QRCode"()
    begin
    end;

    local procedure GetQRCode(QRCodeInput: Text[1024]) QRCodeFileName: Text[1024]
    var
        [RunOnClient]
        IBarCodeProvider: DotNet IBarcodeProvider;
    begin
        GetBarCodeProvider(IBarCodeProvider);
        QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    end;

    [Scope('Internal')]
    procedure MoveToMagicPath(SourceFileName: Text[1024]) DestinationFileName: Text[1024]
    var
        FileSystemObject: Automation;
    begin
        // User Temp Path
        DestinationFileName := FileManagement.ClientTempFileName('');
        IF ISCLEAR(FileSystemObject) THEN
            CREATE(FileSystemObject, TRUE, TRUE);
        FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
    end;

    [Scope('Internal')]
    procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
    var
        [RunOnClient]
        QRCodeProvider: DotNet QRCodeProvider;
    begin
        QRCodeProvider := QRCodeProvider.QRCodeProvider;
        IBarCodeProvider := QRCodeProvider;
    end;

    [Scope('Internal')]
    procedure GenerateQRCode(var EInvoicingRequests: Record "E-Invoicing Requests")
    var
        QRCodeInput: Text[1024];
        QRCodeFileName: Text[1024];
        TempBlob: Record TempBlob;
        Text50000: Label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
    begin
        QRCodeInput := EInvoicingRequests."Signed QR Code" + EInvoicingRequests."Signed QR Code2" + EInvoicingRequests."Signed QR Code3" + EInvoicingRequests."Signed QR Code4";

        QRCodeFileName := GetQRCode(QRCodeInput);
        QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
        // Load the image from file into the BLOB field
        CLEAR(TempBlob);
        FileManagement.BLOBImport(TempBlob, QRCodeFileName);
        IF TempBlob.Blob.HASVALUE THEN
            EInvoicingRequests."QR Image" := TempBlob.Blob;

        // Erase the temporary file
        IF NOT ISSERVICETIER THEN
            IF EXISTS(QRCodeFileName) THEN
                ERASE(QRCodeFileName);
    end;

    [EventSubscriber(ObjectType::Codeunit, 33083461, 'ReturnQRCodeEinvoicing', '', false, false)]
    [Scope('Internal')]
    procedure ReturnQRImage(DocType: Option; DocNo: Code[20]; var TempBlob: Record TempBlob; var IRN: Text)
    var
        QRCodeInput: Text[1024];
        QRCodeFileName: Text[1024];
        Text50000: Label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
        EInvoicingRequests: Record "E-Invoicing Requests";
    begin
        EInvoicingRequests.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
        EInvoicingRequests.SETRANGE("Document Type", DocType);
        EInvoicingRequests.SETRANGE("Document No.", DocNo);
        EInvoicingRequests.SETRANGE("E-Invoice Generated", TRUE);
        EInvoicingRequests.SETFILTER("Signed QR Code", '<>%1', '');
        IF EInvoicingRequests.FINDFIRST THEN BEGIN
            QRCodeInput := EInvoicingRequests."Signed QR Code" + EInvoicingRequests."Signed QR Code2" + EInvoicingRequests."Signed QR Code3" + EInvoicingRequests."Signed QR Code4";
            IRN := EInvoicingRequests."IRN No.";
        END;

        IF QRCodeInput <> '' THEN BEGIN
            QRCodeFileName := GetQRCode(QRCodeInput);
            QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
                                                               // Load the image from file into the BLOB field
            CLEAR(TempBlob);
            FileManagement.BLOBImport(TempBlob, QRCodeFileName);
        END;
    end;

    local procedure GetEInvSetup()
    begin
        IF NOT SetupFound THEN BEGIN
            EInvIntegrationSetup.GET;
            SetupFound := TRUE;
        END;
    end;

    local procedure ValidateIRNandImportDetails(SalesInvoiceHeader: Record "Sales Invoice Header"; IRNValue2: Text; AckValue2: Text; SignedQRCodeValue2: Text; AckDt2: Text): Boolean
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        TempDateTime: DateTime;
    begin
        RecRef.GET(SalesInvoiceHeader.RECORDID);
        FieldRef := RecRef.FIELD(16628);
        FieldRef.VALUE := IRNValue2;
        FieldRef := RecRef.FIELD(16627);
        FieldRef.VALUE := AckValue2;
        FieldRef := RecRef.FIELD(16632);
        CLEAR(TempDateTime);
        EVALUATE(TempDateTime, ConvertAckDt(AckDt2));
        FieldRef.VALUE := TempDateTime;
        FieldRef := RecRef.FIELD(16633);
        FieldRef.VALUE := TRUE;
        GenrateQRCode(SignedQRCodeValue2, RecRef);
    end;

    local procedure ValidateIRNandImportDetailsCrMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; IRNValue2: Text; AckValue2: Text; SignedQRCodeValue2: Text; AckDt2: Text): Boolean
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        TempDateTime: DateTime;
    begin
        RecRef.GET(SalesCrMemoHeader.RECORDID);
        FieldRef := RecRef.FIELD(16628);
        FieldRef.VALUE := IRNValue2;
        FieldRef := RecRef.FIELD(16627);
        FieldRef.VALUE := AckValue2;
        FieldRef := RecRef.FIELD(16632);
        CLEAR(TempDateTime);
        EVALUATE(TempDateTime, ConvertAckDt(AckDt2));
        FieldRef.VALUE := TempDateTime;
        FieldRef := RecRef.FIELD(16633);
        FieldRef.VALUE := TRUE;
        GenrateQRCode(SignedQRCodeValue2, RecRef);
    end;

    local procedure ConvertAckDt(AckDt2: Text) DateTime: Text
    var
        YYYY: Text[4];
        MM: Text[2];
        DD: Text[2];
    begin
        YYYY := COPYSTR(AckDt2, 1, 4);
        MM := COPYSTR(AckDt2, 6, 2);
        DD := COPYSTR(AckDt2, 9, 2);

        // TIME := COPYSTR(AckDt2,12,8);

        DateTime := DD + '-' + MM + '-' + YYYY + ' ' + COPYSTR(AckDt2, 12, 8);
    end;

    local procedure GenrateQRCode(QRCodeTxt: Text; var RecRef: RecordRef)
    var
        TempBlob: Record TempBlob;
        FieldRef: FieldRef;
        QRCodeInput: Text;
        QRCodeFileName: Text;
    begin
        // Save a QR code image into a file in a temporary folder.
        QRCodeInput := QRCodeTxt;
        QRCodeFileName := GetQRCode(QRCodeInput);
        QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC.

        // Load the image from file into the BLOB field.
        CLEAR(TempBlob);
        TempBlob.CALCFIELDS(Blob);
        FileManagement.BLOBImport(TempBlob, QRCodeFileName);

        FieldRef := RecRef.FIELD(16629);
        FieldRef.VALUE := TempBlob.Blob;
        RecRef.MODIFY;

        // Erase the temporary file.
        IF NOT ISSERVICETIER THEN
            IF EXISTS(QRCodeFileName) THEN
                ERASE(QRCodeFileName);
    end;
}

