codeunit 50000 "PKF Portal Web Services"
{

    trigger OnRun()
    begin
    end;

    [ServiceEnabled]
    procedure VeriLoginDetails(UName: Code[10]; PPassword: Text[15]): Text
    var
        PortalUser: Record "Portal User";
        PName: Text[100];
        PEmail: Text[250];
        PPartnerCode: Code[20];
        PSuperUser: Boolean;
        JsonObject: JsonObject;
    begin
        IF PortalUser.VerifyLogin(UName, PPassword, PName, PEmail, PPartnerCode, PSuperUser) THEN begin
            JsonObject.Add('Name', PName);
            JsonObject.Add('Email', PEmail);
            JsonObject.Add('PartnerCode', PPartnerCode);
            JsonObject.Add('SuperUser', PSuperUser);
            exit(Format(JsonObject));
        end;
    end;

    procedure GetReportFile(uid: Code[20]; Type: Text[20]; PartnerCode: Code[20]): Text
    var
        Employee: Record Employee;
        PortalUser: Record "Portal User";
        EmployeeRep: Report "Responsible Person-wise";
        Base64: Codeunit "Base64 Convert";
        Blob: Codeunit "Temp Blob";
        RepFormat: ReportFormat;
        Stream: OutStream;
        InStream: InStream;
    begin
        if PartnerCode = '0' then
            PartnerCode := '';
        PortalUser.GET(uid);
        IF (PortalUser."Partner Code" = '') AND (NOT PortalUser."Super User") THEN
            EXIT;
        if not PortalUser."Super User" then
            PartnerCode := PortalUser."Partner Code";
        IF PartnerCode <> '' THEN
            Employee.SETRANGE("No.", PartnerCode)
        ELSE
            Employee.SETRANGE("No.");
        EmployeeRep.SETTABLEVIEW(Employee);
        CASE Type OF
            'Excel':
                RepFormat := ReportFormat::Excel;
            'PDF':
                RepFormat := ReportFormat::PDF;
            'Word':
                RepFormat := ReportFormat::Word;
        END;
        Stream := Blob.CreateOutStream();
        EmployeeRep.SaveAs('', RepFormat, Stream);
        InStream := Blob.CreateInStream();
        exit(Base64.ToBase64(InStream));
    end;

    [ServiceEnabled]
    procedure GetEmployee(inputJson: Text): Text
    var
        Employee: Record Employee;
    begin
        Employee.SETRANGE(Type, Employee.Type::Partner);
        IF Employee.FINDSET() THEN
            REPEAT
                inputJson += ',' + Employee."No.";
            UNTIL Employee.NEXT() = 0;
        exit(inputJson);
    end;

    procedure GetLengthOfStringWithConfirmation(inputJson: Text): Integer
    var
        c: JsonToken;
        input: JsonObject;
    begin
        input.ReadFrom(inputJson);
        if input.Get('confirm', c) and c.AsValue().AsBoolean() = true and input.Get('str', c) then
            exit(StrLen(c.AsValue().AsText()))
        else
            exit(-1);
    end;
}