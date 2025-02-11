codeunit 50001 "API Consumer E-Invoicing"
{

    trigger OnRun()
    begin
    end;

    var
        EInvIntegrationSetup: Record "E-Inv Integration Setup";
        CompanyInformation: Record "Company Information";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        StringBuilder: TextBuilder;
        Json: Text;
        JsonToken: JsonToken;
        JsonTextWriter: JsonObject;
        JsonTextReader: JsonObject;
        JObject: JsonObject;
        JsonArrayData: JsonArray;
        MessageText, ResponseText, OwnerId, LocGstRegNo, DocumentNo : Text;
        SetupFound, IsInvoice : Boolean;
        RndOffAmt: Decimal;
        Text90000: Label 'Invoice Cancelled';
        IRNTxt: Label 'Irn', Locked = true;
        AcknowledgementNoTxt: Label 'AckNo', Locked = true;
        AcknowledgementDateTxt: Label 'AckDt', Locked = true;
        IRNHashErr: Label 'No matched IRN Hash %1 found to update.', Comment = '%1 = IRN Hash';
        SignedQRCodeTxt: Label 'SignedQRCode', Locked = true;
        CGSTLbl: Label 'CGST', Locked = true;
        SGSTLbl: label 'SGST', Locked = true;
        IGSTLbl: Label 'IGST', Locked = true;
        CESSLbl: Label 'CESS', Locked = true;
        SalesLinesMaxCountLimitErr: Label 'E-Invoice allowes only 100 lines per Invoice. Current transaction is having %1 lines.', Comment = '%1 = Sales Lines count';

    local procedure AddToJson(Variablename: Text; Variable: Variant)
    begin
        JsonTextWriter.Add(Variablename, FORMAT(Variable, 0, 9));
    end;

    local procedure GetJson()
    begin
        JObject.WriteTo(Json);
    end;

    procedure GetAccessToken(): Text
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        RequestHeader_L: HttpHeaders;
        HttpContent: HttpContent;
        HttpWebRequestMgt: HttpRequestMessage;
        ValidSec: Integer;
        IsSuccessful: Boolean;
    begin
        GetEInvSetup();
        IF CURRENTDATETIME > EInvIntegrationSetup."Access Token Validity" THEN BEGIN
            AddToJson('username', EInvIntegrationSetup."User Name");
            AddToJson('password', EInvIntegrationSetup.Password);
            AddToJson('client_id', EInvIntegrationSetup."Client ID");
            AddToJson('client_secret', EInvIntegrationSetup."Client Secret");
            AddToJson('grant_type', 'password');
            GetJson();

            HttpContent.GetHeaders(RequestHeader_L);

            if RequestHeader_L.Contains('Content-Type') then RequestHeader_L.Remove('Content-Type');
            RequestHeader_L.Add('Content-Type', 'application/json');

            if RequestHeader_L.Contains('Content-Encoding') then RequestHeader_L.Remove('Content-Encoding');
            RequestHeader_L.Add('Content-Encoding', 'UTF8');

            HttpContent.WriteFrom(json);

            IsSuccessful := HttpClient.Post(EInvIntegrationSetup."Access Token URL", HttpContent, HttpResponse);

            HttpWebRequestMgt.SetRequestUri(EInvIntegrationSetup."Access Token URL");
            HttpWebRequestMgt.Method('POST');
            RequestHeader_L.Add('Content-Type', 'application/json');
            RequestHeader_L.Add('Accept', 'application/json');
            HttpContent.GetHeaders(RequestHeader_L);
            HttpWebRequestMgt.Content(HttpContent);
            IF IsSuccessful THEN BEGIN
                HttpResponse.Content().ReadAs(ResponseText);
                JsonTextReader.ReadFrom(ResponseText);
                JsonTextReader.Get('access_token', JsonToken);
                MessageText := JsonToken.AsValue().AsText();
                JsonTextReader.Get('expires_in', JsonToken);
                ValidSec := JsonToken.AsValue().AsInteger();
                EInvIntegrationSetup."Access Token" := MessageText;
                EInvIntegrationSetup."Access Token Validity" := CURRENTDATETIME + (ValidSec * 1000);
                EInvIntegrationSetup.MODIFY();
                EXIT(MessageText);
            END;
        END ELSE
            EXIT(EInvIntegrationSetup."Access Token");
    end;

    procedure GenerateEInvoice(JsonString: Text; var ResponseText_p: Text; Cancel: Boolean)
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        RequestHeader_L: HttpHeaders;
        HttpContent: HttpContent;
        Url: Text;
        IsSuccessful: Boolean;
    begin
        GetEInvSetup();
        GetJson();
        IF GUIALLOWED THEN // To avoid error while Background Posting
            IF CONFIRM('Do you want view the JSON') THEN
                MESSAGE('%1', Json);
        IF NOT Cancel THEN
            Url := EInvIntegrationSetup."Generate E-Invoice URL"
        ELSE
            Url := EInvIntegrationSetup."Cancel E-Invoice URL";

        HttpContent.GetHeaders(RequestHeader_L);

        RequestHeader_L.Add('X-Cleartax-Auth-Token', EInvIntegrationSetup."Access Token");
        RequestHeader_L.Add('owner_id', OwnerId);
        RequestHeader_L.Add('gstin', LocGstRegNo);
        RequestHeader_L.Add('x-cleartax-product', 'EInvoice');
        if RequestHeader_L.Contains('Content-Type') then RequestHeader_L.Remove('Content-Type');
        RequestHeader_L.Add('Content-Type', 'application/json');

        if RequestHeader_L.Contains('Content-Encoding') then RequestHeader_L.Remove('Content-Encoding');
        RequestHeader_L.Add('Content-Encoding', 'UTF8');

        HttpContent.WriteFrom(json);

        IsSuccessful := HttpClient.Post(Url, HttpContent, HttpResponse);
        if (not IsSuccessful) and (HttpResponse.HttpStatusCode = 400) then begin
            Message(HttpResponse.ReasonPhrase);
            EXIT;
        end;
        HttpResponse.Content().WriteFrom(ResponseText_p);
    end;

    local procedure GetCompanyInfo()
    begin
        CompanyInformation.GET();
    end;

    local procedure CheckGST(DocNo: Code[20]): Boolean
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        IF DetailedGSTLedgerEntry.FINDFIRST() THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure InsertResponse(RequestId: Text[250]; DocumentNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; AckNo: Text; AckDt: Text; Irn: Text; SignedQRCode: Text; StatusP: Text; ErrorMessage: Text; DocDate: Date; QRCodeURL: Text; EInvoicePDFURL: Text; InfoDetails: Text)
    var
        EInvoicingRequests: Record "E-Invoicing Requests";
        EInvoicingRequests2: Record "E-Invoicing Requests";
    begin
        EInvoicingRequests2.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Generated");
        EInvoicingRequests2.SETRANGE("Document Type", DocType);
        EInvoicingRequests2.SETRANGE("Document No.", DocumentNo);
        IF EInvoicingRequests2.FINDFIRST() THEN BEGIN
            EInvoicingRequests2."Acknowledgement No." := AckNo;
            EInvoicingRequests2."Acknowledgement Date" := AckDt;
            EInvoicingRequests2."IRN No." := Irn;
            IF STRLEN(SignedQRCode) > 250 THEN BEGIN
                EInvoicingRequests2."Signed QR Code" := COPYSTR(SignedQRCode, 1, 250);
                EInvoicingRequests2."Signed QR Code2" := COPYSTR(SignedQRCode, 251, 250);
                EInvoicingRequests2."Signed QR Code3" := COPYSTR(SignedQRCode, 501, 250);
                EInvoicingRequests2."Signed QR Code4" := COPYSTR(SignedQRCode, 751, 250);
            END ELSE
                EInvoicingRequests2."Signed QR Code" := (SignedQRCode);

            IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                EInvoicingRequests2."Error Message" := COPYSTR(ErrorMessage, 1, 250);
                EInvoicingRequests2."Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                EInvoicingRequests2."Error Message3" := COPYSTR(ErrorMessage, 501, 250);
            END ELSE
                EInvoicingRequests2."Error Message" := ErrorMessage;

            EInvoicingRequests2.Status := StatusP;
            EInvoicingRequests2."Request ID" := RequestId;
            EInvoicingRequests2."Request Date" := WORKDATE;
            EInvoicingRequests2."Request Time" := TIME;
            EInvoicingRequests2."User Id" := USERID;
            //"QR Code URL":= QRCodeURL;
            //"E Invoice PDF URL":= EInvoicePDFURL;
            IF STRLEN(InfoDetails) > 250 THEN BEGIN
                EInvoicingRequests2."Info Details" := COPYSTR(InfoDetails, 1, 250);
                EInvoicingRequests2."Info Details2" := COPYSTR(InfoDetails, 251, 250);
            END ELSE
                EInvoicingRequests2."Info Details" := InfoDetails;

            IF Irn <> '' THEN
                //IF GUIALLOWED THEN // To avoid error while Background Posting
                //    GenerateQRCode(EInvoicingRequests2);
                EInvoicingRequests2."E-Invoice Generated" := TRUE;
            EInvoicingRequests2.MODIFY();
        END ELSE BEGIN
            EInvoicingRequests."Entry No." := CREATEGUID;
            EInvoicingRequests."Document Type" := DocType;
            EInvoicingRequests."Document No." := DocumentNo;
            EInvoicingRequests."Document Date" := DocDate;
            EInvoicingRequests."Acknowledgement No." := AckNo;
            EInvoicingRequests."Acknowledgement Date" := AckDt;
            EInvoicingRequests."IRN No." := Irn;
            IF STRLEN(SignedQRCode) > 250 THEN BEGIN
                EInvoicingRequests."Signed QR Code" := COPYSTR(SignedQRCode, 1, 250);
                EInvoicingRequests."Signed QR Code2" := COPYSTR(SignedQRCode, 251, 250);
                EInvoicingRequests."Signed QR Code3" := COPYSTR(SignedQRCode, 501, 250);
                EInvoicingRequests."Signed QR Code4" := COPYSTR(SignedQRCode, 751, 250);
            END ELSE
                EInvoicingRequests."Signed QR Code" := (SignedQRCode);

            IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                EInvoicingRequests."Error Message" := COPYSTR(ErrorMessage, 1, 250);
                EInvoicingRequests."Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                EInvoicingRequests."Error Message3" := COPYSTR(ErrorMessage, 501, 250);
            END ELSE
                EInvoicingRequests."Error Message" := ErrorMessage;

            EInvoicingRequests.Status := StatusP;
            EInvoicingRequests."Request ID" := RequestId;
            EInvoicingRequests."Request Date" := WORKDATE;
            EInvoicingRequests."Request Time" := TIME;
            EInvoicingRequests."User Id" := USERID;
            //"QR Code URL":= QRCodeURL;
            //"E Invoice PDF URL":= EInvoicePDFURL;
            IF STRLEN(InfoDetails) > 250 THEN BEGIN
                EInvoicingRequests."Info Details" := COPYSTR(InfoDetails, 1, 250);
                EInvoicingRequests."Info Details2" := COPYSTR(InfoDetails, 251, 250);
            END ELSE
                EInvoicingRequests."Info Details" := InfoDetails;

            IF Irn <> '' THEN
                EInvoicingRequests."E-Invoice Generated" := TRUE;
            //IF GUIALLOWED THEN // To avoid error while Background Posting
            //    GenerateQRCode(EInvoicingRequests);//temp
            EInvoicingRequests.INSERT();
        END;
    END;

    local procedure InsertCancelResponse(DocumentNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; Irn: Text; StatusP: Text; ErrorMessage: Text; DocDate: Date; CancelDate: DateTime)
    var
        EInvoicingRequests: Record "E-Invoicing Requests";
        EInvoicingRequests2: Record "E-Invoicing Requests";
    begin
        EInvoicingRequests2.SETCURRENTKEY("Document Type", "Document No.", "E-Invoice Canceled");
        EInvoicingRequests2.SETRANGE("Document Type", DocType);
        EInvoicingRequests2.SETRANGE("Document No.", DocumentNo);
        IF EInvoicingRequests2.FINDFIRST() THEN BEGIN
            IF STRLEN(ErrorMessage) > 250 THEN BEGIN
                EInvoicingRequests2."Error Message" := COPYSTR(ErrorMessage, 1, 250);
                EInvoicingRequests2."Error Message2" := COPYSTR(ErrorMessage, 251, 250);
                EInvoicingRequests2."Error Message3" := COPYSTR(ErrorMessage, 501, 250);
            END ELSE
                EInvoicingRequests2."Error Message" := ErrorMessage;

            IF CancelDate <> 0DT THEN BEGIN
                EInvoicingRequests2."Cancel Date" := DT2DATE(CancelDate);
                EInvoicingRequests2."Cancel Time" := DT2TIME(CancelDate);
                EInvoicingRequests2."Cancel User Id" := USERID;
                EInvoicingRequests2."E-Invoice Canceled" := TRUE;
            END;
            EInvoicingRequests2.MODIFY();
        END;
    END;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure CreateJSONSalesInvoice_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        GetEInvSetup();
        IF EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."Mode of E-Invoice - Sales"::"BackGround Posting" THEN
            EXIT;

        IF NOT SalesInvoiceHeader.GET(SalesInvHdrNo) THEN
            EXIT;
        CreateJson(SalesInvoiceHeader, 1);
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure CreateJSONSalesCrmemo_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        EInvIntegrationSetup.GET();
        IF EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."Mode of E-Invoice - Sales"::"BackGround Posting" THEN
            EXIT;

        IF (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Credit Memo") AND (NOT SalesCrMemoHeader.GET(SalesCrMemoHdrNo)) THEN
            EXIT;
        CreateJson(SalesCrMemoHeader, 2);
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'Generate E-Invoice Cleartax', false, false)]
    local procedure CreateJSONSalesInvoice_OnPostedInvoice(var Rec: Record "Sales Invoice Header")
    begin
        CreateJson(Rec, 1);
    end;

    [EventSubscriber(ObjectType::Page, 134, 'OnAfterActionEvent', 'Generate E-Invoice Cleartax', false, false)]
    local procedure CreateJSONSalesCrmemo__OnPostedInvoice(var Rec: Record "Sales Cr.Memo Header")
    begin
        CreateJson(Rec, 2);
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'Cancel E-Invoice Cleartax', false, false)]
    local procedure CancelJSONSalesInvoice_OnPostedInvoice(var Rec: Record "Sales Invoice Header")
    begin
        CancelJSONSalesInvoice(Rec);
    end;

    local procedure CreateJson(RecVariant: Variant; DocumentType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer)
    begin
        CASE DocumentType OF
            DocumentType::"Sale Invoice":
                CreateJSONSalesInvoice(RecVariant);
            DocumentType::"Sale Cr. Memo":
                CreateJSONSalesCrmemo(RecVariant);
        END;
    end;

    local procedure CreateJSONSalesInvoice(SalesInvoiceHeader_p: Record "Sales Invoice Header")
    var
        Location: Record Location;
        RecRef: RecordRef;
        TknNo, AckNo, AckDt, Irn, SignedQRCode, Status, ErrDtls, SignedInv, Info : Text;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
    begin
        RecRef.Open(Database::"Sales Invoice Header");
        RecRef.GetBySystemId(SalesInvoiceHeader_p."SystemId");
        SalesInvoiceHeader.GetBySystemId(SalesInvoiceHeader_p."SystemId");
        IF NOT CheckGST(SalesInvoiceHeader."No.") THEN
            EXIT;
        GetEInvSetup();
        IF (EInvIntegrationSetup."Activation Date" = 0D) OR (EInvIntegrationSetup."Activation Date" > SalesInvoiceHeader."Posting Date") THEN
            EXIT;
        IF (SalesInvoiceHeader."Nature of Supply" = SalesInvoiceHeader."Nature of Supply"::B2C) THEN
            EXIT;

        CheckEInvoiceStatus(SalesInvoiceHeader."No.", 1, FALSE);

        GetCompanyInfo();
        TknNo := GetAccessToken();
        TknNo := EInvIntegrationSetup."Access Token";
        Location.GET(SalesInvoiceHeader."Location Code");
        LocGstRegNo := Location."GST Registration No.";
        OwnerId := Location."Cleartax Owner ID";
        IsInvoice := true;
        DocumentNo := SalesInvoiceHeader_p."No.";
        WriteJsonFileHeader();
        ReadTransactionDetails(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocumentHeaderDetails();
        ReadDocumentSellerDetails();
        ReadDocumentBuyerDetails();
        ReadDocumentShippingDetails();
        ReadExportDetails();
        ReadDocumentTotalDetails();
        ReadDocumentItemList();
        GenerateEInvoice('', ResponseText, FALSE);
        If ResponseText = '' THEN
            EXIT;
        clear(JsonTextReader);
        JsonTextReader.ReadFrom(ResponseText);

        JsonTextReader.Get('AckNo', JsonToken);
        AckNo := JsonToken.AsValue().AsText();
        JsonTextReader.Get('AckDt', JsonToken);
        AckDt := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Irn', JsonToken);
        Irn := JsonToken.AsValue().AsText();
        JsonTextReader.Get('SignedQRCode', JsonToken);
        SignedQRCode := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Status', JsonToken);
        Status := JsonToken.AsValue().AsText();
        JsonTextReader.Get('ErrorDetails..error_message', JsonToken);
        ErrDtls := JsonToken.AsValue().AsText();
        JsonTextReader.Get('SignedInvoice', JsonToken);
        SignedInv := JsonToken.AsValue().AsText();
        JsonTextReader.Get('info..Desc', JsonToken);
        Info := JsonToken.AsValue().AsText();
        InsertResponse('', SalesInvoiceHeader."No.", 1, AckNo, AckDt, Irn,
                      SignedQRCode, Status, ErrDtls, SalesInvoiceHeader."Posting Date"
                , '', SignedInv, Info);
        IF Irn <> '' THEN
            GetEInvoiceResponse(RecRef);
        COMMIT();
        IF Info <> '' THEN
            MESSAGE(Info)
        ELSE
            IF Irn <> '' THEN
                MESSAGE(Text50000, SalesInvoiceHeader."No.")
            ELSE
                ERROR(Text50001, ErrDtls, '');
    END;

    local procedure CreateJSONSalesCrmemo(SalesCrMemoHeader_p: Record "Sales Cr.Memo Header")
    var
        Location: Record Location;
        RecRef: RecordRef;
        TknNo, JString, AckNo, AckDt, Irn, SignedQRCode, Status, ErrDtls, SignedInv, Info : Text;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
    begin
        RecRef.Open(Database::"Sales Cr.Memo Header");
        RecRef.GetBySystemId(SalesCrMemoHeader_p."SystemId");
        SalesCrMemoHeader.GetBySystemId(SalesCrMemoHeader_p."SystemId");
        IF NOT CheckGST(SalesCrMemoHeader."No.") THEN
            EXIT;
        GetEInvSetup();
        IF (EInvIntegrationSetup."Activation Date" = 0D) OR (EInvIntegrationSetup."Activation Date" > SalesCrMemoHeader."Posting Date") THEN
            EXIT;
        IF (SalesCrMemoHeader."Nature of Supply" = SalesCrMemoHeader."Nature of Supply"::B2C) THEN
            EXIT;

        CheckEInvoiceStatus(SalesCrMemoHeader."No.", 1, FALSE);

        GetCompanyInfo();
        TknNo := GetAccessToken();
        TknNo := EInvIntegrationSetup."Access Token";
        Location.GET(SalesInvoiceHeader."Location Code");
        LocGstRegNo := Location."GST Registration No.";
        OwnerId := Location."Cleartax Owner ID";
        DocumentNo := SalesCrMemoHeader_p."No.";
        WriteJsonFileHeader();
        ReadTransactionDetails(SalesCrMemoHeader."GST Customer Type", SalesCrMemoHeader."Ship-to Code");
        ReadDocumentHeaderDetails();
        ReadDocumentSellerDetails();
        ReadDocumentBuyerDetails();
        ReadDocumentShippingDetails();
        ReadExportDetails();
        ReadDocumentTotalDetails();
        ReadDocumentItemList();
        GenerateEInvoice('', ResponseText, FALSE);
        If ResponseText = '' THEN
            EXIT;
        clear(JsonTextReader);
        JsonTextReader.ReadFrom(ResponseText);

        JsonTextReader.Get('AckNo', JsonToken);
        AckNo := JsonToken.AsValue().AsText();
        JsonTextReader.Get('AckDt', JsonToken);
        AckDt := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Irn', JsonToken);
        Irn := JsonToken.AsValue().AsText();
        JsonTextReader.Get('SignedQRCode', JsonToken);
        SignedQRCode := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Status', JsonToken);
        Status := JsonToken.AsValue().AsText();
        JsonTextReader.Get('ErrorDetails..error_message', JsonToken);
        ErrDtls := JsonToken.AsValue().AsText();
        JsonTextReader.Get('SignedInvoice', JsonToken);
        SignedInv := JsonToken.AsValue().AsText();
        JsonTextReader.Get('info..Desc', JsonToken);
        Info := JsonToken.AsValue().AsText();
        InsertResponse('', SalesCrMemoHeader."No.", 1, AckNo, AckDt, Irn,
                      SignedQRCode, Status, ErrDtls, SalesCrMemoHeader."Posting Date"
                , '', SignedInv, Info);
        IF Irn <> '' THEN
            GetEInvoiceResponse(RecRef);
        COMMIT();
        IF Info <> '' THEN
            MESSAGE(Info)
        ELSE
            IF Irn <> '' THEN
                MESSAGE(Text50000, SalesCrMemoHeader."No.")
            ELSE
                ERROR(Text50001, ErrDtls, '');
    end;

    local procedure CancelJSONSalesInvoice(var SalesInvoiceHeader_p: Record "Sales Invoice Header")
    var
        Location: Record Location;
        TypeHelper: Codeunit "Type Helper";
        TknNo: Text[250];
        Irn, Status, ErrDtls, Info : Text;
        CancelDate: DateTime;
        DTVariant: Variant;
        Text50000: Label 'E-Invoice generated successfully for Document No. %1.';
        Text50001: Label '%1 Please share this request ID for support %2.';
    begin
        IF NOT CheckGST(SalesInvoiceHeader_p."No.") THEN
            EXIT;
        GetEInvSetup();
        IF (SalesInvoiceHeader_p."Nature of Supply" = SalesInvoiceHeader_p."Nature of Supply"::B2C) THEN
            EXIT;

        CheckEInvoiceStatus(SalesInvoiceHeader_p."No.", 1, TRUE);

        Location.GET(SalesInvoiceHeader_p."Location Code");
        OwnerId := Location."Cleartax Owner ID";
        LocGstRegNo := Location."GST Registration No.";
        SalesInvoiceHeader_p.TESTFIELD("Cancel Reason");
        GetCompanyInfo();
        TknNo := EInvIntegrationSetup."Access Token";
        AddToJson('irn', SalesInvoiceHeader_p."IRN Hash");
        AddToJson('CnlRsn', TypeHelper.GetOptionNo(FORMAT(SalesInvoiceHeader_p."Cancel Reason"), ' ,Duplicate,Data Entry Mistake,Order Canceled,Other'));
        AddToJson('CnlRem', FORMAT(SalesInvoiceHeader_p."Cancel Reason"));

        GenerateEInvoice('', ResponseText, TRUE);

        clear(JsonTextReader);
        JsonTextReader.ReadFrom(ResponseText);

        JsonTextReader.Get('Irn', JsonToken);
        Irn := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Status', JsonToken);
        Status := JsonToken.AsValue().AsText();
        JsonTextReader.Get('CancelDate', JsonToken);
        DTVariant := 0DT;
        TypeHelper.Evaluate(DTVariant, JsonToken.AsValue().AsText(), '', '');
        CancelDate := DTVariant;
        JsonTextReader.Get('ErrorDetails..error_message', JsonToken);
        ErrDtls := JsonToken.AsValue().AsText();
        JsonTextReader.Get('Success', JsonToken);
        Info := JsonToken.AsValue().AsText();
        InsertCancelResponse(SalesInvoiceHeader_p."No.", 1, Irn, Status, ErrDtls,
                    SalesInvoiceHeader_p."Posting Date", CancelDate);
        SalesInvoiceHeader_p."E-Inv. Cancelled Date" := CancelDate;
        SalesInvoiceHeader_p.MODIFY();
        COMMIT();
        IF Info = 'Y' THEN
            MESSAGE(Text90000)
        ELSE
            ERROR(Text50001, ErrDtls, '');
    END;

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

    local procedure GetRefInvNo(DocNo: Code[20]) RefInvNo: Code[20]
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin
        ReferenceInvoiceNo.SETRANGE("Document No.", DocNo);
        IF ReferenceInvoiceNo.FINDFIRST() THEN
            RefInvNo := ReferenceInvoiceNo."Reference Invoice Nos."
        ELSE
            RefInvNo := '';
    end;

    local procedure GetEInvSetup()
    begin
        IF NOT SetupFound THEN BEGIN
            EInvIntegrationSetup.GET();
            SetupFound := TRUE;
        END;
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

    local procedure WriteJsonFileHeader()
    begin
        JObject.Add('Version', '1.1');
        JsonArrayData.Add(JObject);
    end;

    local procedure ReadTransactionDetails(GSTCustType: Enum "GST Customer Type"; ShipToCode: Code[12])
    begin
        Clear(JsonArrayData);
        if IsInvoice then
            ReadInvoiceTransactionDetails(GSTCustType, ShipToCode)
        else
            ReadCreditMemoTransactionDetails(GSTCustType, ShipToCode);
    end;

    local procedure ReadCreditMemoTransactionDetails(GSTCustType: Enum "GST Customer Type"; ShipToCode: Code[12])
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        NatureOfSupply: Text[7];
        SupplyType: Text[3];
        IgstOnIntra: Text[3];
    begin
        if IsInvoice then
            exit;

        case GSTCustType of
            SalesInvoiceHeader."GST Customer Type"::Registered, SalesInvoiceHeader."GST Customer Type"::Exempted:
                NatureOfSupply := 'B2B';

            SalesInvoiceHeader."GST Customer Type"::Export:
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    NatureOfSupply := 'EXPWOP'
                else
                    NatureOfSupply := 'EXPWP';

            SalesInvoiceHeader."GST Customer Type"::"Deemed Export":
                NatureOfSupply := 'DEXP';

            SalesInvoiceHeader."GST Customer Type"::"SEZ Development", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit":
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    NatureOfSupply := 'SEZWOP'
                else
                    NatureOfSupply := 'SEZWP';
        end;

        if ShipToCode <> '' then begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if SalesCrMemoLine.FindSet() then
                repeat
                    if SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" then
                        SupplyType := 'REG'
                    else
                        SupplyType := 'SHP';
                until SalesCrMemoLine.Next() = 0;
        end else
            SupplyType := 'REG';

        if SalesCrMemoHeader."POS Out Of India" then
            IgstOnIntra := 'Y'
        else
            IgstOnIntra := 'N';

        WriteTransactionDetails(NatureOfSupply, 'N', '', IgstOnIntra);
    end;

    local procedure ReadInvoiceTransactionDetails(GSTCustType: Enum "GST Customer Type"; ShipToCode: Code[12])
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        NatureOfSupplyCategory: Text[7];
        SupplyType: Text[3];
        IgstOnIntra: Text[3];
    begin
        if not IsInvoice then
            exit;

        case GSTCustType of
            SalesInvoiceHeader."GST Customer Type"::Registered, SalesInvoiceHeader."GST Customer Type"::Exempted:
                NatureOfSupplyCategory := 'B2B';

            SalesInvoiceHeader."GST Customer Type"::Export:
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    NatureOfSupplyCategory := 'EXPWOP'
                else
                    NatureOfSupplyCategory := 'EXPWP';

            SalesInvoiceHeader."GST Customer Type"::"Deemed Export":
                NatureOfSupplyCategory := 'DEXP';

            SalesInvoiceHeader."GST Customer Type"::"SEZ Development", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit":
                IF SalesInvoiceHeader."GST Without Payment of Duty" THEN
                    NatureOfSupplyCategory := 'SEZWOP'
                ELSE
                    NatureOfSupplyCategory := 'SEZWP';
        end;

        if ShipToCode <> '' then begin
            SalesInvoiceLine.SetRange("Document No.", DocumentNo);
            if SalesInvoiceLine.FindSet() then
                repeat
                    if SalesInvoiceLine."GST Place of Supply" <> SalesInvoiceLine."GST Place of Supply"::"Ship-to Address" then
                        SupplyType := 'SHP'
                    else
                        SupplyType := 'REG';
                until SalesInvoiceLine.Next() = 0;
        end else
            SupplyType := 'REG';

        if SalesInvoiceHeader."POS Out Of India" then
            IgstOnIntra := 'Y'
        else
            IgstOnIntra := 'N';

        WriteTransactionDetails(NatureOfSupplyCategory, 'N', '', IgstOnIntra);
    end;

    local procedure WriteTransactionDetails(
        SupplyCategory: Text[7];
        RegRev: Text[2];
        EcmGstin: Text[15];
        IgstOnIntra: Text[3])
    var
        JTranDetails: JsonObject;
    begin
        JTranDetails.Add('TaxSch', 'GST');
        JTranDetails.Add('SupTyp', SupplyCategory);
        JTranDetails.Add('RegRev', RegRev);

        if EcmGstin <> '' then
            JTranDetails.Add('EcmGstin', EcmGstin);

        JTranDetails.Add('IgstOnIntra', IgstOnIntra);

        JObject.Add('TranDtls', JTranDetails);
    end;

    local procedure ReadDocumentHeaderDetails()
    var
        InvoiceType: Text[3];
        PostingDate: Text[10];
        OriginalInvoiceNo: Text[16];
    begin
        Clear(JsonArrayData);
        if IsInvoice then begin
            if (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") or
               (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary)
            then
                InvoiceType := 'DBN'
            else
                InvoiceType := 'INV';
            PostingDate := Format(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        end else begin
            InvoiceType := 'CRN';
            PostingDate := Format(SalesCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        end;

        OriginalInvoiceNo := CopyStr(GetRefInvNo(DocumentNo), 1, 16);
        WriteDocumentHeaderDetails(InvoiceType, CopyStr(DocumentNo, 1, 16), PostingDate, OriginalInvoiceNo);
    end;

    local procedure WriteDocumentHeaderDetails(InvoiceType: Text[3]; DocumentNo: Text[16]; PostingDate: Text[10]; OriginalInvoiceNo: Text[16])
    var
        JDocumentHeaderDetails: JsonObject;
    begin
        JDocumentHeaderDetails.Add('Typ', InvoiceType);
        JDocumentHeaderDetails.Add('No', DocumentNo);
        JDocumentHeaderDetails.Add('Dt', PostingDate);
        JDocumentHeaderDetails.Add('OrgInvNo', OriginalInvoiceNo);

        JObject.Add('DocDtls', JDocumentHeaderDetails);
    end;

    local procedure ReadDocumentSellerDetails()
    var
        CompanyInformationBuff: Record "Company Information";
        LocationBuff: Record "Location";
        StateBuff: Record "State";
        GSTRegistrationNo: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        Flno: Text[60];
        Loc: Text[60];
        City: Text[60];
        StateCode: Text[10];
        PhoneNumber: Text[10];
        Email: Text[50];
        Pin: Integer;
        PhoneNoValidation: Text[30];
    begin
        Clear(JsonArrayData);
        if IsInvoice then begin
            GSTRegistrationNo := SalesInvoiceHeader."Location GST Reg. No.";
            LocationBuff.Get(SalesInvoiceHeader."Location Code");
        end else begin
            GSTRegistrationNo := SalesCrMemoHeader."Location GST Reg. No.";
            LocationBuff.Get(SalesCrMemoHeader."Location Code");
        end;

        CompanyInformationBuff.Get();
        CompanyName := CompanyInformationBuff.Name;
        Address := LocationBuff.Address;
        Address2 := LocationBuff."Address 2";
        Flno := '';
        Loc := '';
        City := LocationBuff.City;
        if LocationBuff."Post Code" <> '' then
            Evaluate(Pin, (CopyStr(LocationBuff."Post Code", 1, 6)))
        else
            Pin := 000000;

        StateBuff.Get(LocationBuff."State Code");
        StateCode := StateBuff."State Code (GST Reg. No.)";

        if LocationBuff."Phone No." <> '' then
            PhoneNumber := CopyStr(LocationBuff."Phone No.", 1, 10)
        else
            PhoneNumber := '000000';

        if LocationBuff."E-Mail" <> '' then
            Email := CopyStr(LocationBuff."E-Mail", 1, 50)
        else
            Email := '0000@00';

        PhoneNoValidation := '!@*()+=-[]\\\;,./{}|\":<>?';
        PhoneNumber := DelChr(PhoneNumber, '=', PhoneNoValidation);
        WriteSellerDetails(GSTRegistrationNo, CompanyName, Address, Address2, City, Pin, StateCode, PhoneNumber, Email);
    end;

    local procedure WriteSellerDetails(
        GSTRegistrationNo: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        City: Text[60];
        PostCode: Integer;
        StateCode: Text[10];
        PhoneNumber: Text[10];
        Email: Text[50])
    var
        JSellerDetails: JsonObject;
    begin
        JSellerDetails.Add('Gstin', GSTRegistrationNo);
        JSellerDetails.Add('LglNm', CompanyName);
        JSellerDetails.Add('Addr1', Address);

        if Address2 <> '' then
            JSellerDetails.Add('Addr2', Address2);

        JSellerDetails.Add('Loc', City);
        JSellerDetails.Add('Pin', PostCode);
        JSellerDetails.Add('Stcd', StateCode);

        if PhoneNumber <> '' then
            JSellerDetails.Add('Ph', PhoneNumber)
        else
            JSellerDetails.Add('Ph', '000000');

        if Email <> '' then
            JSellerDetails.Add('Em', Email)
        else
            JSellerDetails.Add('Em', '0000@00');

        JObject.Add('SellerDtls', JSellerDetails);
    end;

    local procedure ReadDocumentBuyerDetails()
    begin
        Clear(JsonArrayData);
        if IsInvoice then
            ReadInvoiceBuyerDetails()
        else
            ReadCrMemoBuyerDetails();
    end;

    local procedure ReadInvoiceBuyerDetails()
    var
        Contact: Record Contact;
        SalesInvoiceLine: Record "Sales Invoice Line";
        ShiptoAddress: Record "Ship-to Address";
        StateBuff: Record State;
        GSTRegistrationNumber: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        Floor: Text[60];
        AddressLocation: Text[60];
        City: Text[60];
        StateCode: Text[10];
        PhoneNumber: Text[10];
        Email: Text[50];
        Pin: Integer;
        PhoneNoValidation: Text[30];
    begin
        if SalesInvoiceHeader."Customer GST Reg. No." <> '' then
            GSTRegistrationNumber := SalesInvoiceHeader."Customer GST Reg. No."
        else
            GSTRegistrationNumber := 'URP';

        CompanyName := SalesInvoiceHeader."Bill-to Name";
        Address := SalesInvoiceHeader."Bill-to Address";
        Address2 := SalesInvoiceHeader."Bill-to Address 2";
        Floor := '';
        AddressLocation := '';
        City := SalesInvoiceHeader."Bill-to City";

        if SalesInvoiceHeader."Bill-to Post Code" <> '' then
            Evaluate(Pin, (CopyStr(SalesInvoiceHeader."Bill-to Post Code", 1, 6)))
        else
            Pin := 000000;

        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
        if SalesInvoiceLine.FindFirst() then
            case SalesInvoiceLine."GST Place of Supply" of
                SalesInvoiceLine."GST Place of Supply"::"Bill-to Address":
                    begin
                        if not (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                            StateBuff.Get(SalesInvoiceHeader."GST Bill-to State Code");
                            StateCode := StateBuff."State Code (GST Reg. No.)";
                        end else
                            StateCode := '';

                        if Contact.Get(SalesInvoiceHeader."Bill-to Contact No.") then begin
                            PhoneNumber := CopyStr(Contact."Phone No.", 1, 10);
                            Email := CopyStr(Contact."E-Mail", 1, 50);
                        end else begin
                            PhoneNumber := '';
                            Email := '';
                        end;
                    end;

                SalesInvoiceLine."GST Place of Supply"::"Ship-to Address":
                    begin
                        if not (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                            StateBuff.Get(SalesInvoiceHeader."GST Ship-to State Code");
                            StateCode := StateBuff."State Code (GST Reg. No.)";
                        end else
                            StateCode := '';

                        if ShiptoAddress.Get(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code") then begin
                            PhoneNumber := CopyStr(ShiptoAddress."Phone No.", 1, 10);
                            Email := CopyStr(ShiptoAddress."E-Mail", 1, 50);
                        end else begin
                            PhoneNumber := '';
                            Email := '';
                        end;
                    end;
                else begin
                    StateCode := '';
                    PhoneNumber := '';
                    Email := '';
                end;
            end;

        PhoneNoValidation := '!@*()+=-[]\\\;,./{}|\":<>?';
        PhoneNumber := DelChr(PhoneNumber, '=', PhoneNoValidation);
        WriteBuyerDetails(GSTRegistrationNumber, CompanyName, Address, Address2, City, Pin, StateCode, PhoneNumber, Email);
    end;

    local procedure ReadCrMemoBuyerDetails()
    var
        Contact: Record Contact;
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShiptoAddress: Record "Ship-to Address";
        StateBuff: Record State;
        GSTRegistrationNumber: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        Floor: Text[60];
        AddressLocation: Text[60];
        City: Text[60];
        Pin: Integer;
        StateCode: Text[10];
        PhoneNumber: Text[10];
        Email: Text[50];
        PhoneNoValidation: Text[30];
    begin
        if SalesCrMemoHeader."Customer GST Reg. No." <> '' then
            GSTRegistrationNumber := SalesCrMemoHeader."Customer GST Reg. No."
        else
            GSTRegistrationNumber := 'URP';
        CompanyName := SalesCrMemoHeader."Bill-to Name";
        Address := SalesCrMemoHeader."Bill-to Address";
        Address2 := SalesCrMemoHeader."Bill-to Address 2";
        Floor := '';
        AddressLocation := '';
        City := SalesCrMemoHeader."Bill-to City";
        if SalesCrMemoHeader."Bill-to Post Code" <> '' then
            Evaluate(Pin, (CopyStr(SalesCrMemoHeader."Bill-to Post Code", 1, 6)))
        else
            Pin := 000000;

        StateCode := '';
        PhoneNumber := '';
        Email := '';

        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindFirst() then
            case SalesCrMemoLine."GST Place of Supply" of

                SalesCrMemoLine."GST Place of Supply"::"Bill-to Address":
                    begin
                        if not (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export) then begin
                            StateBuff.Get(SalesCrMemoHeader."GST Bill-to State Code");
                            StateCode := StateBuff."State Code (GST Reg. No.)";
                        end;

                        if Contact.Get(SalesCrMemoHeader."Bill-to Contact No.") then begin
                            PhoneNumber := CopyStr(Contact."Phone No.", 1, 10);
                            Email := CopyStr(Contact."E-Mail", 1, 50);
                        end;
                    end;

                SalesCrMemoLine."GST Place of Supply"::"Ship-to Address":
                    begin
                        if not (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export) then begin
                            StateBuff.Get(SalesCrMemoHeader."GST Ship-to State Code");
                            StateCode := StateBuff."State Code (GST Reg. No.)";
                        end;

                        if ShiptoAddress.Get(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") then begin
                            PhoneNumber := CopyStr(ShiptoAddress."Phone No.", 1, 10);
                            Email := CopyStr(ShiptoAddress."E-Mail", 1, 50);
                        end;
                    end;
            end;

        PhoneNoValidation := '!@*()+=-[]\\\;,./{}|\":<>?';
        PhoneNumber := DelChr(PhoneNumber, '=', PhoneNoValidation);
        WriteBuyerDetails(GSTRegistrationNumber, CompanyName, Address, Address2, City, Pin, StateCode, PhoneNumber, Email);
    end;

    local procedure WriteBuyerDetails(
        GSTRegistrationNumber: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        City: Text[60];
        Pin: Integer;
        StateCode: Text[10];
        PhoneNumber: Text[10];
        EmailID: Text[50])
    var
        JBuyerDetails: JsonObject;
    begin
        JBuyerDetails.Add('Gstin', GSTRegistrationNumber);
        JBuyerDetails.Add('LglNm', CompanyName);

        if StateCode <> '' then
            JBuyerDetails.Add('POS', StateCode)
        else
            JBuyerDetails.Add('POS', '96');

        JBuyerDetails.Add('Addr1', Address);

        if Address2 <> '' then
            JBuyerDetails.Add('Addr2', Address2);

        JBuyerDetails.Add('Loc', City);
        JBuyerDetails.Add('Stcd', StateCode);
        JBuyerDetails.Add('Pin', Pin);

        if PhoneNumber <> '' then
            JBuyerDetails.Add('Ph', PhoneNumber)
        else
            JBuyerDetails.Add('Ph', '000000');

        if EmailID <> '' then
            JBuyerDetails.Add('Em', EmailID)
        else
            JBuyerDetails.Add('Em', '0000@00');

        JObject.Add('BuyerDtls', JBuyerDetails);
    end;

    local procedure ReadDocumentShippingDetails()
    var
        ShiptoAddress: Record "Ship-to Address";
        StateBuff: Record State;
        PostCode: Integer;
        GSTRegistrationNumber: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        City: Text[100];
        StateCode: Text[10];
        PhoneNumber: Text[10];
        EmailID: Text[50];
    begin
        Clear(JsonArrayData);
        if IsInvoice and (SalesInvoiceHeader."Ship-to Code" <> '') then begin
            ShiptoAddress.Get(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code");
            StateBuff.Get(SalesInvoiceHeader."GST Ship-to State Code");
            CompanyName := SalesInvoiceHeader."Ship-to Name";
            Address := SalesInvoiceHeader."Ship-to Address";
            Address2 := SalesInvoiceHeader."Ship-to Address 2";
            City := SalesInvoiceHeader."Ship-to City";
            Evaluate(PostCode, (CopyStr(SalesInvoiceHeader."Ship-to Post Code", 1, 6)));
        end else
            if SalesCrMemoHeader."Ship-to Code" <> '' then begin
                ShiptoAddress.Get(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code");
                StateBuff.Get(SalesCrMemoHeader."GST Ship-to State Code");
                CompanyName := SalesCrMemoHeader."Ship-to Name";
                Address := SalesCrMemoHeader."Ship-to Address";
                Address2 := SalesCrMemoHeader."Ship-to Address 2";
                City := SalesCrMemoHeader."Ship-to City";
                Evaluate(PostCode, CopyStr(SalesCrMemoHeader."Ship-to Post Code", 1, 6));
            end;
        if ShiptoAddress."GST Registration No." <> '' then
            GSTRegistrationNumber := ShiptoAddress."GST Registration No."
        else
            GSTRegistrationNumber := SalesInvoiceHeader."Location GST Reg. No.";

        StateCode := StateBuff."State Code (GST Reg. No.)";
        PhoneNumber := CopyStr(ShiptoAddress."Phone No.", 1, 10);
        EmailID := CopyStr(ShiptoAddress."E-Mail", 1, 50);
        WriteShippingDetails(GSTRegistrationNumber, CompanyName, Address, Address2, City, PostCode, StateCode);
    end;

    local procedure WriteShippingDetails(
        GSTRegistrationNumber: Text[20];
        CompanyName: Text[100];
        Address: Text[100];
        Address2: Text[100];
        AddressLocation: Text[100];
        PostCode: Integer;
        StateCode: Text[10])
    var
        Pin: Integer;
        JShippingDetails: JsonObject;
    begin
        Pin := 000000;
        JShippingDetails.Add('Gstin', GSTRegistrationNumber);
        JShippingDetails.Add('LglNm', CompanyName);
        JShippingDetails.Add('TrdNm', CompanyName);
        JShippingDetails.Add('Addr1', Address);

        if Address2 <> '' then
            JShippingDetails.Add('Addr2', Address2);

        JShippingDetails.Add('Loc', AddressLocation);

        if PostCode <> 0 then
            JShippingDetails.Add('Pin', PostCode)
        else
            JShippingDetails.Add('Pin', Pin);

        JShippingDetails.Add('Stcd', StateCode);

        if CompanyName <> '' then
            JObject.Add('ShipDtls', JShippingDetails);
    end;

    local procedure ReadDocumentTotalDetails()
    var
        AssessableAmount: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        CessAmount: Decimal;
        StateCessAmount: Decimal;
        CESSNonAvailmentAmount: Decimal;
        DiscountAmount: Decimal;
        OtherCharges: Decimal;
        TotalInvoiceValue: Decimal;
    begin
        Clear(JsonArrayData);
        GetGSTValue(AssessableAmount, CGSTAmount, SGSTAmount, IGSTAmount, CessAmount, StateCessAmount, CESSNonAvailmentAmount, DiscountAmount, OtherCharges, TotalInvoiceValue);
        WriteDocumentTotalDetails(AssessableAmount, CGSTAmount, SGSTAmount, IGSTAmount, CessAmount, CESSNonAvailmentAmount, DiscountAmount, OtherCharges, TotalInvoiceValue);
    end;

    local procedure WriteDocumentTotalDetails(
        AssessableAmount: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        CessAmount: Decimal;
        CessNonAdvanceVal: Decimal;
        DiscountAmount: Decimal;
        OtherCharges: Decimal;
        TotalInvoiceAmount: Decimal)
    var
        JDocTotalDetails: JsonObject;
        RoundOffAmt: Integer;
    begin
        RoundOffAmt := 0;
        JDocTotalDetails.Add('Assval', AssessableAmount);
        JDocTotalDetails.Add('CgstVal', CGSTAmount);
        JDocTotalDetails.Add('SgstVAl', SGSTAmount);
        JDocTotalDetails.Add('IgstVal', IGSTAmount);
        JDocTotalDetails.Add('CesVal', CessAmount);
        JDocTotalDetails.Add('CesNonAdVal', CessNonAdvanceVal);
        JDocTotalDetails.Add('Discount', DiscountAmount);
        JDocTotalDetails.Add('OthChrg', OtherCharges);

        if RndOffAmt = 0 then
            JDocTotalDetails.Add('RndOffAmt', RoundOffAmt)
        else
            JDocTotalDetails.Add('RndOffAmt', RndOffAmt);

        JDocTotalDetails.Add('TotInvVal', TotalInvoiceAmount);

        JObject.Add('ValDtls', JDocTotalDetails);
    end;

    local procedure GetGSTValue(
    var AssessableAmount: Decimal;
    var CGSTAmount: Decimal;
    var SGSTAmount: Decimal;
    var IGSTAmount: Decimal;
    var CessAmount: Decimal;
    var StateCessValue: Decimal;
    var CessNonAdvanceAmount: Decimal;
    var DiscountAmount: Decimal;
    var OtherCharges: Decimal;
    var TotalInvoiceValue: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotGSTAmt: Decimal;
    begin
        GSTLedgerEntry.SetRange("Document No.", DocumentNo);

        GSTLedgerEntry.SetRange("GST Component Code", CGSTLbl);
        if GSTLedgerEntry.FindSet() then
            repeat
                CGSTAmount += Abs(GSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.Next() = 0
        else
            CGSTAmount := 0;

        GSTLedgerEntry.SetRange("GST Component Code", SGSTLbl);
        if GSTLedgerEntry.FindSet() then
            repeat
                SGSTAmount += Abs(GSTLedgerEntry."GST Amount")
            until GSTLedgerEntry.Next() = 0
        else
            SGSTAmount := 0;

        GSTLedgerEntry.SetRange("GST Component Code", IGSTLbl);
        if GSTLedgerEntry.FindSet() then
            repeat
                IGSTAmount += Abs(GSTLedgerEntry."GST Amount")
            until GSTLedgerEntry.Next() = 0
        else
            IGSTAmount := 0;

        CessAmount := 0;
        CessNonAdvanceAmount := 0;

        DetailedGSTLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SetRange("GST Component Code", CESSLbl);
        if DetailedGSTLedgerEntry.FindFirst() then
            repeat
                if DetailedGSTLedgerEntry."GST %" > 0 then
                    CessAmount += Abs(DetailedGSTLedgerEntry."GST Amount")
                else
                    CessNonAdvanceAmount += Abs(DetailedGSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.Next() = 0;

        GSTLedgerEntry.SetFilter("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS');
        if GSTLedgerEntry.FindSet() then
            repeat
                StateCessValue += Abs(GSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.Next() = 0;

        if IsInvoice then begin
            SalesInvoiceLine.SetRange("Document No.", DocumentNo);
            if SalesInvoiceLine.FindSet() then
                repeat
                    AssessableAmount += SalesInvoiceLine.Amount;
                    DiscountAmount += SalesInvoiceLine."Inv. Discount Amount";
                until SalesInvoiceLine.Next() = 0;
            TotGSTAmt := CGSTAmount + SGSTAmount + IGSTAmount + CessAmount + CessNonAdvanceAmount + StateCessValue;

            AssessableAmount := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                  WorkDate(), SalesInvoiceHeader."Currency Code", AssessableAmount, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                  WorkDate(), SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            DiscountAmount := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                  WorkDate(), SalesInvoiceHeader."Currency Code", DiscountAmount, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
        end else begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if SalesCrMemoLine.FindSet() then begin
                repeat
                    AssessableAmount += SalesCrMemoLine.Amount;
                    DiscountAmount += SalesCrMemoLine."Inv. Discount Amount";
                until SalesCrMemoLine.Next() = 0;
                TotGSTAmt := CGSTAmount + SGSTAmount + IGSTAmount + CessAmount + CessNonAdvanceAmount + StateCessValue;
            end;

            AssessableAmount := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    WorkDate(),
                    SalesCrMemoHeader."Currency Code",
                    AssessableAmount,
                    SalesCrMemoHeader."Currency Factor"),
                    0.01,
                    '=');

            TotGSTAmt := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    WorkDate(),
                    SalesCrMemoHeader."Currency Code",
                    TotGSTAmt,
                    SalesCrMemoHeader."Currency Factor"),
                    0.01,
                    '=');

            DiscountAmount := Round(
                CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    WorkDate(),
                    SalesCrMemoHeader."Currency Code",
                    DiscountAmount,
                    SalesCrMemoHeader."Currency Factor"),
                    0.01,
                    '=');
        end;

        CustLedgerEntry.SetCurrentKey("Document No.");
        CustLedgerEntry.SetRange("Document No.", DocumentNo);
        if IsInvoice then begin
            CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        end else begin
            CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
            CustLedgerEntry.SetRange("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
        end;

        if CustLedgerEntry.FindFirst() then begin
            CustLedgerEntry.CalcFields("Amount (LCY)");
            TotalInvoiceValue := Abs(CustLedgerEntry."Amount (LCY)");
        end;

        OtherCharges := CalculateOtherCharges(DocumentNo);
    end;

    local procedure CalculateOtherCharges(DocNo: code[20]) Amount: Decimal
    var
        TaxBaseSubscribers: Codeunit "Tax Base Subscribers";
    begin
        TaxBaseSubscribers.GetAmountFromDocumentNoForEInv(DocNo, Amount);
    end;

    local procedure ReadDocumentItemList()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        AssessableAmount: Decimal;
        GstRate: Decimal;
        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        CessRate: Decimal;
        CesNonAdval: Decimal;
        StateCess: Decimal;
        CGSTValue: Decimal;
        SGSTValue: Decimal;
        IGSTValue: Decimal;
        IsServc: Text[1];
        Count: Integer;
    begin
        Count := 1;
        Clear(JsonArrayData);
        if IsInvoice then begin
            SalesInvoiceLine.SetRange("Document No.", DocumentNo);
            SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
            SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
            if SalesInvoiceLine.FindSet() then begin
                if SalesInvoiceLine.Count > 100 then
                    Error(SalesLinesMaxCountLimitErr, SalesInvoiceLine.Count);
                repeat
                    if SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 then
                        AssessableAmount := SalesInvoiceLine."GST Assessable Value (LCY)"
                    else
                        AssessableAmount := SalesInvoiceLine.Amount;

                    if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Goods then
                        IsServc := 'N'
                    else
                        IsServc := 'Y';

                    GetGSTComponentRate(
                        SalesInvoiceLine."Document No.",
                        SalesInvoiceLine."Line No.",
                        CGSTRate,
                        SGSTRate,
                        IGSTRate,
                        CessRate,
                        CesNonAdval,
                        StateCess);

                    if SalesInvoiceLine."GST Jurisdiction Type" = SalesInvoiceLine."GST Jurisdiction Type"::Intrastate then
                        GstRate := CGSTRate + SGSTRate
                    else
                        GstRate := IGSTRate;

                    GetGSTValueForLine(SalesInvoiceLine."Line No.", CGSTValue, SGSTValue, IGSTValue);
                    if SalesInvoiceLine."No." <> GetInvoiceRoundingAccountForInvoice() then
                        WriteItem(
                          Format(Count),
                          SalesInvoiceLine.Description + SalesInvoiceLine."Description 2",
                          SalesInvoiceLine."HSN/SAC Code",
                          GstRate, SalesInvoiceLine.Quantity,
                          CopyStr(SalesInvoiceLine."Unit of Measure Code", 1, 3),
                          Round(SalesInvoiceLine."Unit Price", 0.001, '='),
                          SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Line Discount Amount",
                          SalesInvoiceLine."Line Discount Amount", 0,
                          AssessableAmount, CGSTValue, SGSTValue, IGSTValue, CessRate, CesNonAdval,
                          AssessableAmount + CGSTValue + SGSTValue + IGSTValue,
                          IsServc)
                    else
                        RndOffAmt := SalesInvoiceLine.Amount;
                    Count += 1;
                until SalesInvoiceLine.Next() = 0;
            end;

            JObject.Add('ItemList', JsonArrayData);
        end else begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            SalesCrMemoLine.SetFilter(Type, '<>%1', SalesCrMemoLine.Type::" ");
            SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
            if SalesCrMemoLine.FindSet() then begin
                if SalesCrMemoLine.Count > 100 then
                    Error(SalesLinesMaxCountLimitErr, SalesCrMemoLine.Count);

                repeat
                    if SalesCrMemoLine."GST Assessable Value (LCY)" <> 0 then
                        AssessableAmount := SalesCrMemoLine."GST Assessable Value (LCY)"
                    else
                        AssessableAmount := SalesCrMemoLine.Amount;

                    if SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Goods then
                        IsServc := 'N'
                    else
                        IsServc := 'Y';

                    GetGSTComponentRate(
                        SalesCrMemoLine."Document No.",
                        SalesCrMemoLine."Line No.",
                        CGSTRate,
                        SGSTRate,
                        IGSTRate,
                        CessRate,
                        CesNonAdval,
                        StateCess);

                    if SalesCrMemoLine."GST Jurisdiction Type" = SalesCrMemoLine."GST Jurisdiction Type"::Intrastate then
                        GstRate := CGSTRate + SGSTRate
                    else
                        GstRate := IGSTRate;

                    GetGSTValueForLine(SalesCrMemoLine."Line No.", CGSTValue, SGSTValue, IGSTValue);
                    if SalesCrMemoLine."No." <> GetInvoiceRoundingAccountForCreditMemo() then
                        WriteItem(
                          Format(Count),
                          SalesCrMemoLine.Description + SalesCrMemoLine."Description 2",
                          SalesCrMemoLine."HSN/SAC Code", GstRate,
                          SalesCrMemoLine.Quantity,
                          CopyStr(SalesCrMemoLine."Unit of Measure Code", 1, 3),
                          Round(SalesCrMemoLine."Unit Price", 0.001, '='),
                          SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Line Discount Amount",
                          SalesCrMemoLine."Line Discount Amount", 0,
                          AssessableAmount, CGSTValue, SGSTValue, IGSTValue, CessRate, CesNonAdval,
                          AssessableAmount + CGSTValue + SGSTValue + IGSTValue,
                          IsServc)
                    else
                        RndOffAmt := SalesCrMemoLine.Amount;

                    Count += 1;
                until SalesCrMemoLine.Next() = 0;
            end;

            JObject.Add('ItemList', JsonArrayData);
        end;
    end;

    local procedure GetInvoiceRoundingAccountForInvoice(): Code[20]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        if not SalesInvoiceHeader.Get(DocumentNo) then
            exit;

        if not CustomerPostingGroup.Get(SalesInvoiceHeader."Customer Posting Group") then
            exit;

        exit(CustomerPostingGroup."Invoice Rounding Account");
    end;

    local procedure GetInvoiceRoundingAccountForCreditMemo(): Code[20]
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        if not SalesCrMemoHeader.Get(DocumentNo) then
            exit;

        if not CustomerPostingGroup.Get(SalesCrMemoHeader."Customer Posting Group") then
            exit;

        exit(CustomerPostingGroup."Invoice Rounding Account");
    end;

    local procedure WriteItem(
        SlNo: Text[10];
        ProductName: Text;
        HSNCode: Text[10];
        GstRate: Decimal;
        Quantity: Decimal;
        Unit: Text[3];
        UnitPrice: Decimal;
        TotAmount: Decimal;
        Discount: Decimal;
        OtherCharges: Decimal;
        AssessableAmount: Decimal;
        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        CESSRate: Decimal;
        CessNonAdvanceAmount: Decimal;
        TotalItemValue: Decimal;
        IsServc: Text[1])
    var
        JItem: JsonObject;
    begin
        JItem.Add('SlNo', SlNo);
        JItem.Add('PrdDesc', ProductName);
        JItem.Add('IsServc', IsServc);
        JItem.Add('HsnCd', HSNCode);
        JItem.Add('Qty', Quantity);
        JItem.Add('Unit', Unit);
        JItem.Add('UnitPrice', UnitPrice);
        JItem.Add('TotAmt', TotAmount);
        JItem.Add('Discount', Discount);
        JItem.Add('OthChrg', OtherCharges);
        JItem.Add('AssAmt', AssessableAmount);
        JItem.Add('GstRt', GstRate);
        JItem.Add('CgstAmt', CGSTRate);
        JItem.Add('SgstAmt', SGSTRate);
        JItem.Add('IgstAmt', IGSTRate);
        JItem.Add('CesRt', CESSRate);
        JItem.Add('CesAmt', 0);

        JItem.Add('CesNonAdval', CessNonAdvanceAmount);
        JItem.Add('TotItemVal', TotalItemValue);

        JsonArrayData.Add(JItem);
    end;

    local procedure GetGSTValueForLine(
    DocumentLineNo: Integer;
    var CGSTLineAmount: Decimal;
    var SGSTLineAmount: Decimal;
    var IGSTLineAmount: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        CGSTLineAmount := 0;
        SGSTLineAmount := 0;
        IGSTLineAmount := 0;

        DetailedGSTLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", DocumentLineNo);
        DetailedGSTLedgerEntry.SetRange("GST Component Code", CGSTLbl);
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                CGSTLineAmount += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;

        DetailedGSTLedgerEntry.SetRange("GST Component Code", SGSTLbl);
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                SGSTLineAmount += Abs(DetailedGSTLedgerEntry."GST Amount")
            until DetailedGSTLedgerEntry.Next() = 0;

        DetailedGSTLedgerEntry.SetRange("GST Component Code", IGSTLbl);
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                IGSTLineAmount += Abs(DetailedGSTLedgerEntry."GST Amount")
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    local procedure GetGSTComponentRate(
    DocumentNo: Code[20];
    LineNo: Integer;
    var CGSTRate: Decimal;
    var SGSTRate: Decimal;
    var IGSTRate: Decimal;
    var CessRate: Decimal;
    var CessNonAdvanceAmount: Decimal;
    var StateCess: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", LineNo);

        DetailedGSTLedgerEntry.SetRange("GST Component Code", CGSTLbl);
        if DetailedGSTLedgerEntry.FindFirst() then
            CGSTRate := DetailedGSTLedgerEntry."GST %"
        else
            CGSTRate := 0;

        DetailedGSTLedgerEntry.SetRange("GST Component Code", SGSTLbl);
        if DetailedGSTLedgerEntry.FindFirst() then
            SGSTRate := DetailedGSTLedgerEntry."GST %"
        else
            SGSTRate := 0;

        DetailedGSTLedgerEntry.SetRange("GST Component Code", IGSTLbl);
        if DetailedGSTLedgerEntry.FindFirst() then
            IGSTRate := DetailedGSTLedgerEntry."GST %"
        else
            IGSTRate := 0;

        CessRate := 0;
        CessNonAdvanceAmount := 0;
        DetailedGSTLedgerEntry.SetRange("GST Component Code", CESSLbl);
        if DetailedGSTLedgerEntry.FindFirst() then
            if DetailedGSTLedgerEntry."GST %" > 0 then
                CessRate := DetailedGSTLedgerEntry."GST %"
            else
                CessNonAdvanceAmount := Abs(DetailedGSTLedgerEntry."GST Amount");

        StateCess := 0;
        DetailedGSTLedgerEntry.SetRange("GST Component Code");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if not (DetailedGSTLedgerEntry."GST Component Code" in [CGSTLbl, SGSTLbl, IGSTLbl, CESSLbl])
                then
                    StateCess := DetailedGSTLedgerEntry."GST %";
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    local procedure ReadExportDetails()
    begin
        Clear(JsonArrayData);
        if IsInvoice then
            ReadInvoiceExportDetails()
        else
            ReadCrMemoExportDetails();
    end;

    local procedure ReadCrMemoExportDetails()
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ExportCategory: Text[3];
        WithPayOfDuty: Text[1];
        ShipmentBillNo: Text[16];
        ShipmentBillDate: Text[10];
        ExitPort: Text[10];
        DocumentAmount: Decimal;
        CurrencyCode: Text[3];
        CountryCode: Text[2];
    begin
        if IsInvoice then
            exit;

        if not (SalesCrMemoHeader."GST Customer Type" in [
            SalesCrMemoHeader."GST Customer Type"::Export,
            SalesCrMemoHeader."GST Customer Type"::"Deemed Export",
            SalesCrMemoHeader."GST Customer Type"::"SEZ Unit",
            SalesCrMemoHeader."GST Customer Type"::"SEZ Development"])
        then
            exit;

        case SalesCrMemoHeader."GST Customer Type" of
            SalesCrMemoHeader."GST Customer Type"::Export:
                ExportCategory := 'DIR';
            SalesCrMemoHeader."GST Customer Type"::"Deemed Export":
                ExportCategory := 'DEM';
            SalesCrMemoHeader."GST Customer Type"::"SEZ Unit":
                ExportCategory := 'SEZ';
            "GST Customer Type"::"SEZ Development":
                ExportCategory := 'SED';
        end;

        if SalesCrMemoHeader."GST Without Payment of Duty" then
            WithPayOfDuty := 'N'
        else
            WithPayOfDuty := 'Y';

        ShipmentBillNo := CopyStr(SalesCrMemoHeader."Bill Of Export No.", 1, 16);
        ShipmentBillDate := Format(SalesCrMemoHeader."Bill Of Export Date", 0, '<Day,2>/<Month,2>/<Year4>');
        ExitPort := SalesCrMemoHeader."Exit Point";

        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindSet() then
            repeat
                DocumentAmount := DocumentAmount + SalesCrMemoLine.Amount;
            until SalesCrMemoLine.Next() = 0;

        CurrencyCode := CopyStr(SalesCrMemoHeader."Currency Code", 1, 3);
        CountryCode := CopyStr(SalesCrMemoHeader."Bill-to Country/Region Code", 1, 2);

        WriteExportDetails(WithPayOfDuty, ShipmentBillNo, ShipmentBillDate, ExitPort, CurrencyCode, CountryCode);
    end;

    local procedure ReadInvoiceExportDetails()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        ExportCategory: Text[3];
        WithPayOfDuty: Text[1];
        ShipmentBillNo: Text[16];
        ShipmentBillDate: Text[10];
        ExitPort: Text[10];
        DocumentAmount: Decimal;
        CurrencyCode: Text[3];
        CountryCode: Text[2];
    begin
        if not IsInvoice then
            exit;

        if not (SalesInvoiceHeader."GST Customer Type" in [
            SalesInvoiceHeader."GST Customer Type"::Export,
            SalesInvoiceHeader."GST Customer Type"::"Deemed Export",
            SalesInvoiceHeader."GST Customer Type"::"SEZ Unit",
            SalesInvoiceHeader."GST Customer Type"::"SEZ Development"])
        then
            exit;

        case SalesInvoiceHeader."GST Customer Type" of
            SalesInvoiceHeader."GST Customer Type"::Export:
                ExportCategory := 'DIR';
            SalesInvoiceHeader."GST Customer Type"::"Deemed Export":
                ExportCategory := 'DEM';
            SalesInvoiceHeader."GST Customer Type"::"SEZ Unit":
                ExportCategory := 'SEZ';
            SalesInvoiceHeader."GST Customer Type"::"SEZ Development":
                ExportCategory := 'SED';
        end;

        if SalesInvoiceHeader."GST Without Payment of Duty" then
            WithPayOfDuty := 'N'
        else
            WithPayOfDuty := 'Y';

        ShipmentBillNo := CopyStr(SalesInvoiceHeader."Bill Of Export No.", 1, 16);
        ShipmentBillDate := Format(SalesInvoiceHeader."Bill Of Export Date", 0, '<Day,2>/<Month,2>/<Year4>');
        ExitPort := SalesInvoiceHeader."Exit Point";

        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                DocumentAmount := DocumentAmount + SalesInvoiceLine.Amount;
            until SalesInvoiceLine.Next() = 0;

        CurrencyCode := CopyStr(SalesInvoiceHeader."Currency Code", 1, 3);
        CountryCode := CopyStr(SalesInvoiceHeader."Bill-to Country/Region Code", 1, 2);

        WriteExportDetails(WithPayOfDuty, ShipmentBillNo, ShipmentBillDate, ExitPort, CurrencyCode, CountryCode);
    end;

    local procedure WriteExportDetails(
        WithPayOfDuty: Text[1];
        ShipmentBillNo: Text[16];
        ShipmentBillDate: Text[10];
        ExitPort: Text[10];
        CurrencyCode: Text[3];
        CountryCode: Text[2])
    var
        JExpDetails: JsonObject;
    begin
        JExpDetails.Add('ShipBNo', ShipmentBillNo);
        JExpDetails.Add('ShipBDt', ShipmentBillDate);
        JExpDetails.Add('Port', ExitPort);
        JExpDetails.Add('RefClm', WithPayOfDuty);
        JExpDetails.Add('ForCur', CurrencyCode);
        JExpDetails.Add('CntCode', CountryCode);

        JObject.Add('ExpDtls', JExpDetails);
    end;

    procedure GetEInvoiceResponse(var RecRef: RecordRef)
    var
        JSONManagement: Codeunit "JSON Management";
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        FieldRef: FieldRef;
        JsonString: Text;
        TempIRNTxt: Text;
        TempDateTime: DateTime;
        AcknowledgementDateTimeText: Text;
        AcknowledgementDate: Date;
        AcknowledgementTime: Time;
    begin
        JsonString := ResponseText;
        if (JsonString = '') or (JsonString = '[]') then
            exit;

        JSONManagement.InitializeObject(JsonString);
        if JSONManagement.GetValue(IRNTxt) <> '' then begin
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash"));
            FieldRef.Value := JSONManagement.GetValue(IRNTxt);
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No."));
            FieldRef.Value := JSONManagement.GetValue(AcknowledgementNoTxt);

            AcknowledgementDateTimeText := JSONManagement.GetValue(AcknowledgementDateTxt);
            Evaluate(AcknowledgementDate, CopyStr(AcknowledgementDateTimeText, 1, 10));
            Evaluate(AcknowledgementTime, CopyStr(AcknowledgementDateTimeText, 11, 8));
            TempDateTime := CreateDateTime(AcknowledgementDate, AcknowledgementTime);
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));

            FieldRef.Value := TempDateTime;
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo(IsJSONImported));
            FieldRef.Value := true;
            QRGenerator.GenerateQRCodeImage(JSONManagement.GetValue(SignedQRCodeTxt), TempBlob);
            FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
            TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
            RecRef.Modify();
        end else
            Error(IRNHashErr, TempIRNTxt);
    end;

}