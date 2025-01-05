codeunit 50003 "Email Reminder-Monthly"
{

    trigger OnRun()
    var
        Date: Record Date;
        RemEmailIDListBuffer: Record "Reminder Type" temporary;
        ReminderListBuffer: Record "Reminder List Buffer";
        ReminderType: Record "Reminder Type";
        SMTPMailSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        Enddate: Date;
        FirstDate: Date;
        StartDate: Date;
        WeekNumber: Integer;
        Year: Integer;
        CCEmailID: Text;
        MonthName: Text;
        ToEmailID: Text;
        UserName: Text;
    begin
        CLEAR(SMTPMailSetup);
        CLEAR(SMTPMail);
        CLEAR(MonthName);
        CLEAR(WeekNumber);
        CLEAR(DataExist);
        CLEAR(RemEmailIDListBuffer);
        CLEAR(ReminderListBuffer);
        CLEAR(ReminderType);
        ReminderListBuffer.DELETEALL;
        SMTPMailSetup.GET;

        MonthName := GetMonthName(TODAY);
        WeekNumber := GetWeekNumber(TODAY);
        Year := DATE2DMY(TODAY, 3);

        GetRemindersUserWise(ReminderListBuffer, RemEmailIDListBuffer);
        IF RemEmailIDListBuffer.FINDSET THEN
            REPEAT
                GetEmailandRecepientName(ToEmailID, UserName, RemEmailIDListBuffer, CCEmailID);

                SMTPMail.CreateMessage(COMPANYNAME, SMTPMailSetup."User ID", ToEmailID, 'Monthly Reminders', '', TRUE);

                SMTPMail.AppendBody('Dear' + ' ' + FORMAT(UserName));
                SMTPMail.AppendBody('<br><br>');

                IF TODAY = CALCDATE('-CM', TODAY) THEN
                    SMTPMail.AppendBody('Follwing are the funds to be arranged and payments to be done for month of ' + FORMAT(MonthName) + ' of year ' + FORMAT(Year));

                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody(CreateMailBody(ReminderListBuffer, RemEmailIDListBuffer));
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('Thanks');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('<HR>');
                SMTPMail.AppendBody('This is a system generated email. Please do not reply to this mail');
                IF DataExist THEN BEGIN
                    SMTPMail.AddCC(CCEmailID);
                    SMTPMail.Send;
                    IF GUIALLOWED THEN
                        MESSAGE('Mail Sent');
                END;
            UNTIL RemEmailIDListBuffer.NEXT = 0;
    end;

    var
        DataExist: Boolean;

    local procedure CreateMailBody(ReminderList: Record "Reminder List Buffer"; RemEmailIDListBuffer: Record "Reminder Type"): Text
    var
        ReminderType: Record "Reminder Type";
        FirstDateOfMonth: Date;
        LastDateOfMonth: Date;
        LastDayofWeek: Date;
        StartDayofWeek: Date;
        EmailText: Text;
    begin
        CLEAR(DataExist);

        EmailText += '<table border = "1">';

        EmailText += '<tr>';
        EmailText += '<th> Rem No. </th>';
        EmailText += '<th> Type </th>';
        EmailText += '<th> Description </th>';
        EmailText += '<th> Purchase Date </th>';
        EmailText += '<th> Start Period </th>';
        EmailText += '<th> Purchase Amount </th>';
        EmailText += '<th> End Period </th>';
        EmailText += '<th> Amount </th>';
        EmailText += '<th> Count </th>';
        EmailText += '<th> Location </th>';
        EmailText += '<th> Company </th>';
        EmailText += '<th> Status </th>';

        CLEAR(FirstDateOfMonth);
        CLEAR(LastDateOfMonth);

        FirstDateOfMonth := CALCDATE('-CM', TODAY);
        LastDateOfMonth := CALCDATE('CM', TODAY);

        //ERROR('%1 %2',FirstDateOfMonth,LastDateOfMonth);

        ReminderList.SETRANGE("Send To", RemEmailIDListBuffer."Send To");
        ReminderList.SETRANGE("Send CC", RemEmailIDListBuffer."Send CC");
        IF ReminderList.FINDFIRST THEN
            REPEAT
                IF (ReminderList."End Period" >= FirstDateOfMonth) AND (ReminderList."End Period" <= LastDateOfMonth) THEN BEGIN
                    DataExist := TRUE;
                    EmailText += '<tr>';
                    EmailText += '<td>' + FORMAT(ReminderList."No.") + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Type) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Decription) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList."Purchase Date") + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList."Start Period") + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList."Purchase Amount") + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList."End Period") + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Amount) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Count) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Location) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Company) + '</td>';
                    EmailText += '<td>' + FORMAT(ReminderList.Status) + '</td>';
                    EmailText += '</tr>'
                END;
            UNTIL ReminderList.NEXT = 0;
        EmailText += '</table>';
        EXIT(EmailText);
    end;

    local procedure GetEmailandRecepientName(var ToEmailID: Text; var UserName: Text; ReminderType: Record "Reminder Type"; var CCEmailID: Text)
    var
        Users: Record User;
        UserSetup: Record "User Setup";
    begin
        IF ReminderType."Send To" <> '' THEN BEGIN
            IF UserSetup.GET(ReminderType."Send To") THEN
                IF UserSetup."E-Mail" <> '' THEN
                    ToEmailID := UserSetup."E-Mail"
                ELSE
                    UserSetup.TESTFIELD("E-Mail");

            Users.SETRANGE("User Name", UserSetup."User ID");
            IF Users.FINDFIRST THEN
                UserName := Users."Full Name";

            IF UserSetup.GET(ReminderType."Send CC") THEN
                IF UserSetup."E-Mail" <> '' THEN
                    CCEmailID := UserSetup."E-Mail"
                ELSE
                    UserSetup.TESTFIELD("E-Mail");

        END;
    end;

    local procedure GetMonthName(InputDate: Date): Text
    var
        recDate: Record Date;
        RecMonth: Record Date;
        RecWeek: Record Date;
    begin
        recDate.RESET;
        recDate.SETCURRENTKEY("Period Type", "Period Start");
        recDate.SETRANGE("Period Type", recDate."Period Type"::Month);
        recDate.SETRANGE("Period Start", InputDate - 50, InputDate);
        recDate.FIND('+');
        EXIT(recDate."Period Name");
    end;

    local procedure GetWeekNumber(InputDate: Date): Integer
    var
        DateRec1: Record Date;
        DateRec: Record Date;
        PDStartBLN: Boolean;
        DEndDate: Date;
        DStartDate: Date;
        PDEndDate: Date;
        PDStartDate: Date;
        Ctr: Integer;
        WeekNo: Integer;
    begin
        IF NOT (InputDate = 0D) THEN BEGIN
            PDStartBLN := FALSE;
            PDStartDate := CALCDATE('-CM', InputDate);
            PDEndDate := CALCDATE('CM', InputDate);
            Ctr := 0;
            WeekNo := 0;
            DateRec.RESET;
            DateRec.SETFILTER("Period Type", '%1', DateRec."Period Type"::Week);
            DateRec.SETFILTER("Period Start", '%1..%2', PDStartDate, PDEndDate);
            IF DateRec.FINDFIRST THEN
                REPEAT
                    DStartDate := CALCDATE('-1D', (DateRec."Period Start"));
                    DEndDate := CALCDATE('-1D', (DateRec."Period End"));
                    CLEAR(DateRec1);

                    IF DateRec1.GET(DateRec1."Period Type"::Date, DStartDate) THEN BEGIN
                        IF DStartDate = CALCDATE('-CM', DStartDate) THEN BEGIN
                            IF DateRec1."Period Name" = 'Sunday' THEN
                                Ctr := 0;
                        END ELSE
                            Ctr += 1;
                        IF NOT PDStartBLN THEN BEGIN
                            IF PDStartDate < DStartDate THEN BEGIN
                                Ctr := 1;
                                PDStartBLN := TRUE
                            END;
                        END;
                    END;
                    IF InputDate < DStartDate THEN BEGIN
                        WeekNo := Ctr;
                        EXIT(WeekNo);
                    END ELSE
                        IF (InputDate >= DStartDate) AND (InputDate <= DEndDate) THEN BEGIN
                            WeekNo := Ctr + 1;
                            EXIT(WeekNo);
                        END;
                UNTIL DateRec.NEXT = 0;
        END;
    end;

    local procedure InsertLog(ReminderList: Record "Reminder List"; Status: Boolean)
    var
        ReminderEmailLog: Record "Reminder Email Log";
        EntryNo: Integer;
    begin

        IF NOT ReminderEmailLog.FINDLAST THEN
            EntryNo := 1
        ELSE
            EntryNo := ReminderEmailLog."Entry No." + 1;
        ReminderEmailLog.INIT;
        ReminderEmailLog."Entry No." := EntryNo;
        ReminderEmailLog.INSERT;
        ReminderEmailLog."Reminder No." := ReminderList."No.";
        ReminderEmailLog."Period Start" := ReminderList."Start Period";
        ReminderEmailLog."Period End" := ReminderList."End Period";
        IF Status THEN
            ReminderEmailLog."Email Sending Status" := 'Email Sent Successfully'
        ELSE
            ReminderEmailLog."Email Sending Status" := 'Reminders does not exist for this period';
        ReminderEmailLog.MODIFY;
    end;

    local procedure GetRemindersUserWise(var ReminderListBuffer: Record "Reminder List Buffer"; var RemEmailIDListBuffer: Record "Reminder Type" temporary)
    var
        ReminderList: Record "Reminder List";
        ReminderType: Record "Reminder Type";
        EntryNo: Integer;
    begin
        ReminderList.RESET;
        ReminderList.SETRANGE(Status, ReminderList.Status::Open);
        IF ReminderList.FINDSET THEN
            REPEAT
                IF (ReminderList."Send To" = '') AND (ReminderList."Send CC" = '') THEN BEGIN
                    IF ReminderType.GET(ReminderList.Type) THEN
                        IF (ReminderType."Send To" <> '') AND (ReminderType."Send CC" <> '') THEN BEGIN
                            ReminderListBuffer.SETRANGE("Send To", ReminderType."Send To");
                            ReminderListBuffer.SETRANGE("Send CC", ReminderType."Send CC");
                            IF NOT ReminderListBuffer.FINDFIRST THEN
                                InsertEmailInfo(RemEmailIDListBuffer, ReminderType, ReminderList, FALSE);
                            InsertReminderListBuffer(ReminderList, ReminderType, FALSE);
                        END;
                END ELSE BEGIN
                    ReminderListBuffer.SETRANGE("Send To", ReminderList."Send To");
                    ReminderListBuffer.SETRANGE("Send CC", ReminderList."Send CC");
                    IF NOT ReminderListBuffer.FINDFIRST THEN
                        InsertEmailInfo(RemEmailIDListBuffer, ReminderType, ReminderList, TRUE);
                    InsertReminderListBuffer(ReminderList, ReminderType, TRUE);
                END;
            UNTIL ReminderList.NEXT = 0;
    end;

    local procedure InsertReminderListBuffer(ReminderList: Record "Reminder List"; ReminderType: Record "Reminder Type"; EmailExist: Boolean)
    var
        ReminderListBuffer: Record "Reminder List Buffer";
    begin
        ReminderListBuffer.INIT;
        ReminderListBuffer.TRANSFERFIELDS(ReminderList);
        IF NOT EmailExist THEN BEGIN
            ReminderListBuffer."Send To" := ReminderType."Send To";
            ReminderListBuffer."Send CC" := ReminderType."Send CC";
        END ELSE BEGIN
            ReminderListBuffer."Send To" := ReminderList."Send To";
            ReminderListBuffer."Send CC" := ReminderList."Send CC";
        END;
        ReminderListBuffer.INSERT;
    end;

    local procedure InsertEmailInfo(var RemEmailIDListBuffer: Record "Reminder Type" temporary; ReminderType: Record "Reminder Type"; ReminderList: Record "Reminder List"; EmailExist: Boolean)
    begin
        RemEmailIDListBuffer.INIT;
        IF NOT EmailExist THEN BEGIN
            RemEmailIDListBuffer.Code := ReminderType.Code;
            RemEmailIDListBuffer."Send To" := ReminderType."Send To";
            RemEmailIDListBuffer."Send CC" := ReminderType."Send CC";
        END ELSE BEGIN
            RemEmailIDListBuffer.Code := ReminderList."No.";
            RemEmailIDListBuffer."Send To" := ReminderList."Send To";
            RemEmailIDListBuffer."Send CC" := ReminderList."Send CC";
        END;
        RemEmailIDListBuffer.INSERT;
    end;
}

