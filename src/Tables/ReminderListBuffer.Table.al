/// <summary>
/// Table Reminder List Buffer (ID 50013).
/// </summary>
table 50013 "Reminder List Buffer"
{
    DrillDownPageID = "Reminders List";
    LookupPageID = "Reminders List";


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reminder Type".Code;
        }
        field(3; Decription; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Purchase Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Purchase Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Location; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Company; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        field(12; Status; Enum "Reminder List Status Type")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status = Status::Closed then begin
                    if "Payment Date" = 0D then
                        ERROR('Payment date should not be have blank');

                    if CONFIRM(CofirmMsg, true) then begin

                        ReminderList.INIT();

                        ReminderList.TRANSFERFIELDS(xRec);
                        ReminderList."No." := '';
                        ReminderList."Payment Date" := 0D;
                        ReminderList."Generated From Previous Entry" := TRUE;
                        ReminderList.INSERT(TRUE);
                        PAGE.RUN(50015, ReminderList);
                    END ELSE
                        EXIT;
                END;
            end;
        }
        field(13; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Send To"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(16; "Send CC"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(17; "Generated From Previous Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            GeneralLedgerSetup.GET();
            GeneralLedgerSetup.TESTFIELD("Reminder Nos.");
            "No. Series" := GeneralLedgerSetup."Reminder Nos.";
            //NoSeriesMgt.InitSeries(GeneralLedgerSetup."Reminder Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            NoSeries.AreRelated("No. Series", xRec."No. Series");
        END;
    end;

    var
        ReminderList: Record "Reminder List";

        GeneralLedgerSetup: Record "General Ledger Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";
        CofirmMsg: Label 'Do you want to create new Reminder ?';

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(): Boolean
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("Reminder Nos.");
        if NoSeries.LookupRelatedNoSeries(GeneralLedgerSetup."Reminder Nos.", xRec."No. Series", "No. Series") then begin
            //IF NoSeriesMgt.SelectSeries(GeneralLedgerSetup."Reminder Nos.", xRec."No. Series", "No. Series") THEN BEGIN
            "No." := NoSeries.GetNextNo("No. Series");
            //NoSeriesMgt.SetSeries("No.");
            exit(true)
        end;
    end;
}

