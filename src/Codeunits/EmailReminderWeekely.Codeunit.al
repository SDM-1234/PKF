codeunit 50002 "Email Reminder-Weekely"
{

    trigger OnRun()
    var
        RemEmailIDListBuffer: Record "Reminder Type" temporary;
        ReminderListBuffer: Record "Reminder List Buffer";
        EMail: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Year: Integer;
        CCEmailID: Text;
        MonthName: Text;
        ToEmailID: Text;
        UserName: Text;
    begin
        CLEAR(DataExist);

        ReminderListBuffer.DELETEALL();
        MonthName := GetMonthName(TODAY);

        Year := DATE2DMY(TODAY, 3);

        GetRemindersUserWise(ReminderListBuffer, RemEmailIDListBuffer);
        if RemEmailIDListBuffer.FINDSET() then
            repeat
                GetEmailandRecepientName(ToEmailID, UserName, RemEmailIDListBuffer, CCEmailID);
                EmailMessage.Create(ToEmailID, 'Weekely Reminders', '');

                EmailMessage.AppendToBody('Dear' + ' ' + FORMAT(UserName));
                EmailMessage.AppendToBody('<br><br>');

                IF TODAY = CALCDATE('-CM', TODAY) THEN
                    EmailMessage.AppendToBody('Follwing are the funds to be arranged and payments to be done for month of ' + FORMAT(MonthName) + ' of year ' + FORMAT(Year));

                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody(CreateMailBody(ReminderListBuffer, RemEmailIDListBuffer));
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('Thanks');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<HR>');
                EmailMessage.AppendToBody('This is a system generated email. Please do not reply to this mail');

                IF DataExist THEN BEGIN

                    EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, CCEmailID);
                    EMail.Send(EmailMessage);
                    IF GUIALLOWED THEN
                        MESSAGE('Mail Sent');
                END;
            UNTIL RemEmailIDListBuffer.NEXT() = 0;
    end;

    var
        DataExist: Boolean;

    local procedure CreateMailBody(ReminderList: Record "Reminder List Buffer"; RemEmailIDListBuffer: Record "Reminder Type"): Text
    var
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

        CLEAR(StartDayofWeek);
        CLEAR(LastDayofWeek);

        StartDayofWeek := CALCDATE('<-CW>', WORKDATE);
        LastDayofWeek := CALCDATE('<CW>', WORKDATE);

        MESSAGE('%1 %2', StartDayofWeek, LastDayofWeek);
        ReminderList.SETRANGE("Send To", RemEmailIDListBuffer."Send To");
        ReminderList.SETRANGE("Send CC", RemEmailIDListBuffer."Send CC");
        IF ReminderList.FindSet() THEN
            REPEAT
                IF (ReminderList."End Period" >= StartDayofWeek) AND (ReminderList."End Period" <= LastDayofWeek) THEN BEGIN
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
            UNTIL ReminderList.NEXT() = 0;
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
            IF Users.FINDFIRST() THEN
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
    begin
        recDate.SETCURRENTKEY("Period Type", "Period Start");
        recDate.SETRANGE("Period Type", recDate."Period Type"::Month);
        recDate.SETRANGE("Period Start", InputDate - 50, InputDate);
        recDate.FindFirst();
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
            DateRec.RESET();
            DateRec.SETFILTER("Period Type", '%1', DateRec."Period Type"::Week);
            DateRec.SETFILTER("Period Start", '%1..%2', PDStartDate, PDEndDate);
            IF DateRec.FindSet() THEN
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
                        IF NOT PDStartBLN THEN
                            IF PDStartDate < DStartDate THEN BEGIN
                                Ctr := 1;
                                PDStartBLN := TRUE
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
                UNTIL DateRec.NEXT() = 0;
        END;
    end;

    local procedure InsertLog(ReminderList: Record "Reminder List"; Status: Boolean)
    var
        ReminderEmailLog: Record "Reminder Email Log";
        EntryNo: Integer;
    begin

        IF NOT ReminderEmailLog.FINDLAST() THEN
            EntryNo := 1
        ELSE
            EntryNo := ReminderEmailLog."Entry No." + 1;
        ReminderEmailLog.INIT();
        ReminderEmailLog."Entry No." := EntryNo;
        ReminderEmailLog.INSERT();
        ReminderEmailLog."Reminder No." := ReminderList."No.";
        ReminderEmailLog."Period Start" := ReminderList."Start Period";
        ReminderEmailLog."Period End" := ReminderList."End Period";
        IF Status THEN
            ReminderEmailLog."Email Sending Status" := 'Email Sent Successfully'
        ELSE
            ReminderEmailLog."Email Sending Status" := 'Reminders does not exist for this period';
        ReminderEmailLog.MODIFY();
    end;

    local procedure GetRemindersUserWise(var ReminderListBuffer: Record "Reminder List Buffer"; var RemEmailIDListBuffer: Record "Reminder Type" temporary)
    var
        ReminderList: Record "Reminder List";
        ReminderType: Record "Reminder Type";
    begin
        ReminderList.SETRANGE(Status, ReminderList.Status::Open);
        IF ReminderList.FINDSET() THEN
            REPEAT
                IF (ReminderList."Send To" = '') AND (ReminderList."Send CC" = '') THEN BEGIN
                    IF ReminderType.GET(ReminderList.Type) THEN
                        IF (ReminderType."Send To" <> '') AND (ReminderType."Send CC" <> '') THEN BEGIN
                            ReminderListBuffer.SETRANGE("Send To", ReminderType."Send To");
                            ReminderListBuffer.SETRANGE("Send CC", ReminderType."Send CC");
                            IF NOT ReminderListBuffer.FINDFIRST() THEN
                                InsertEmailInfo(RemEmailIDListBuffer, ReminderType, ReminderList, FALSE);
                            InsertReminderListBuffer(ReminderList, ReminderType, FALSE);
                        END;
                END ELSE BEGIN
                    ReminderListBuffer.SETRANGE("Send To", ReminderList."Send To");
                    ReminderListBuffer.SETRANGE("Send CC", ReminderList."Send CC");
                    IF NOT ReminderListBuffer.FINDFIRST() THEN
                        InsertEmailInfo(RemEmailIDListBuffer, ReminderType, ReminderList, TRUE);
                    InsertReminderListBuffer(ReminderList, ReminderType, TRUE);
                END;
            UNTIL ReminderList.NEXT() = 0;
    end;

    local procedure InsertReminderListBuffer(ReminderList: Record "Reminder List"; ReminderType: Record "Reminder Type"; EmailExist: Boolean)
    var
        ReminderListBuffer: Record "Reminder List Buffer";
    begin
        ReminderListBuffer.INIT();
        ReminderListBuffer.TRANSFERFIELDS(ReminderList);
        IF NOT EmailExist THEN BEGIN
            ReminderListBuffer."Send To" := ReminderType."Send To";
            ReminderListBuffer."Send CC" := ReminderType."Send CC";
        END ELSE BEGIN
            ReminderListBuffer."Send To" := ReminderList."Send To";
            ReminderListBuffer."Send CC" := ReminderList."Send CC";
        END;
        ReminderListBuffer.INSERT();
    end;

    local procedure InsertEmailInfo(var RemEmailIDListBuffer: Record "Reminder Type" temporary; ReminderType: Record "Reminder Type"; ReminderList: Record "Reminder List"; EmailExist: Boolean)
    begin
        RemEmailIDListBuffer.INIT();
        IF NOT EmailExist THEN BEGIN
            RemEmailIDListBuffer.Code := ReminderType.Code;
            RemEmailIDListBuffer."Send To" := ReminderType."Send To";
            RemEmailIDListBuffer."Send CC" := ReminderType."Send CC";
        END ELSE BEGIN
            RemEmailIDListBuffer.Code := ReminderList."No.";
            RemEmailIDListBuffer."Send To" := ReminderList."Send To";
            RemEmailIDListBuffer."Send CC" := ReminderList."Send CC";
        END;
        RemEmailIDListBuffer.INSERT();
    end;
}

