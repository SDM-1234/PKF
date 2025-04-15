codeunit 50000 "PKF Portal Web Services"
{

    trigger OnRun()
    begin
    end;

    [ServiceEnabled]
    procedure VeriLoginDetails(UName: Code[10]; PPassword: Text[15]; var PName: Text[100]; var PEmail: Text[250]; var PPartnerCode: Code[20]; var PSuperUser: Boolean): Boolean
    var
        PortalUser: Record "Portal User";
    begin
        IF PortalUser.VerifyLogin(UName, PPassword, PName, PEmail, PPartnerCode, PSuperUser) THEN
            EXIT(TRUE);
    end;

    // procedure GetReportFile(uid: Code[20]; Type: Option " ",Excel,PDF,Word; PartnerCode: Code[20]; var ReportFile: BigText)
    // var
    //     Convert: DotNet Convert;
    //     Path: DotNet Path;
    //     _File: DotNet File;
    //     FileAccess: DotNet FileAccess;
    //     FileMode: DotNet FileMode;
    //     MemoryStream: DotNet MemoryStream;
    //     FileStream: DotNet FileStream;
    //     tempFile: Text[250];
    //     EmployeeRep: Report "Responsible Person-wise";
    //     Employee: Record Employee;
    //     PortalUser: Record "Portal User";
    // begin
    //     PortalUser.GET(uid);
    //     IF (PortalUser."Partner Code" = '') AND (NOT PortalUser."Super User") THEN
    //         EXIT;

    //     // This section gives us a temporary file name in a temporary location and saves our 'Customer Top 10' as PDF to this path
    //     tempFile := Path.GetTempPath() + Path.GetRandomFileName();

    //     IF PartnerCode <> '' THEN
    //         Employee.SETRANGE("No.", PartnerCode)
    //     ELSE
    //         Employee.SETRANGE("No.");
    //     EmployeeRep.SETTABLEVIEW(Employee);
    //     CASE Type OF
    //         1:
    //             IF EmployeeRep.SAVEASEXCEL(tempFile) THEN
    //                 ;
    //         2:
    //             IF EmployeeRep.SAVEASPDF(tempFile) THEN
    //                 ;
    //         3:
    //             IF EmployeeRep.SAVEASWORD(tempFile) THEN
    //                 ;
    //     END;

    //     // This section opens the saved PDF.
    //     FileMode := 4;
    //     FileAccess := 1;
    //     FileStream := _File.Open(tempFile, FileMode, FileAccess);

    //     // This section creates a MemoryStream and reads the contents of the file to its buffer.
    //     // Next, this byte buffer is converted to Base64 string and added to out return variable.
    //     MemoryStream := MemoryStream.MemoryStream();
    //     MemoryStream.SetLength(FileStream.Length);
    //     FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);
    //     ReportFile.ADDTEXT(Convert.ToBase64String(MemoryStream.GetBuffer()));

    //     // And finally we have to dispose all the resources.
    //     MemoryStream.Close();
    //     MemoryStream.Dispose();
    //     FileStream.Close();
    //     FileStream.Dispose();
    //     _File.Delete(tempFile);
    // end;
    [ServiceEnabled]
    procedure GetEmployee(var pEmployee: BigText)
    var
        Employee: Record Employee;
    begin
        pEmployee.ADDTEXT('');
        Employee.SETRANGE(Type, Employee.Type::Partner);
        IF Employee.FINDSET() THEN
            REPEAT
                pEmployee.ADDTEXT(',' + Employee."No.");
            UNTIL Employee.NEXT() = 0;
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