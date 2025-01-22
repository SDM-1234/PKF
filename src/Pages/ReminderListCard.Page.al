/// <summary>
/// Page Reminder List Card (ID 50015).
/// </summary>
page 50015 "Reminder List Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Reminder List";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    Editable = Field1Visible;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEditProc() THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Type; Rec.Type)
                {
                    Editable = Field2Visible;
                }
                field(Decription; Rec.Decription)
                {
                    Editable = Field3Visible;
                }
                field("Start Period"; Rec."Start Period")
                {
                    Editable = Field4Visible;
                }
                field("End Period"; Rec."End Period")
                {
                    Editable = Field5Visible;
                }
                field(Company; Rec.Company)
                {
                    Editable = Field6Visible;
                }
                field(Status; Rec.Status)
                {
                    Editable = Field7Visible;
                }
                field(Location; Rec.Location)
                {
                    Editable = Field8Visible;
                }
                field("Generated From Previous Entry"; Rec."Generated From Previous Entry")
                {
                }
            }
            group(Purchase)
            {
                field("Purchase Date"; Rec."Purchase Date")
                {
                    Editable = Field9Visible;
                }
                field("Purchase Amount"; Rec."Purchase Amount")
                {
                    Editable = Field10Visible;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = Field11Visible;
                }
                field("Count"; Rec.Count)
                {
                    Editable = Field12Visible;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    Editable = Field13Visible;
                }
            }
            group("Email Parameters")
            {
                field("Send To"; Rec."Send To")
                {
                    Editable = Field14Visible;
                }
                field("Send CC"; Rec."Send CC")
                {
                    Editable = Field15Visible;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000017; Outlook)
            {
            }
            systempart(Control1000000018; Notes)
            {
            }
            systempart(Control1000000019; MyNotes)
            {
            }
            systempart(Control1000000020; Links)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF (Rec.Status = Rec.Status::Open) AND (Rec."Generated From Previous Entry") THEN BEGIN
            Field15Visible := FALSE;
            Field14Visible := FALSE;
            Field13Visible := TRUE;
            Field12Visible := FALSE;
            Field11Visible := TRUE;
            Field10Visible := FALSE;
            Field9Visible := FALSE;
            Field8Visible := FALSE;
            Field7Visible := TRUE;
            Field6Visible := FALSE;
            Field5Visible := TRUE;
            Field4Visible := TRUE;
            Field3Visible := FALSE;
            Field2Visible := FALSE;
            Field1Visible := FALSE;
        END ELSE
            IF (Rec.Status = Rec.Status::Closed) AND (Rec."Generated From Previous Entry") THEN BEGIN
                Field15Visible := FALSE;
                Field14Visible := FALSE;
                Field13Visible := FALSE;
                Field12Visible := FALSE;
                Field11Visible := FALSE;
                Field10Visible := FALSE;
                Field9Visible := FALSE;
                Field8Visible := FALSE;
                Field7Visible := FALSE;
                Field6Visible := FALSE;
                Field5Visible := FALSE;
                Field4Visible := FALSE;
                Field3Visible := FALSE;
                Field2Visible := FALSE;
                Field1Visible := FALSE;

            END ELSE
                IF (Rec.Status = Rec.Status::Open) AND (NOT Rec."Generated From Previous Entry") THEN BEGIN
                    Field15Visible := TRUE;
                    Field14Visible := TRUE;
                    Field13Visible := TRUE;
                    Field12Visible := TRUE;
                    Field11Visible := TRUE;
                    Field10Visible := TRUE;
                    Field9Visible := TRUE;
                    Field8Visible := TRUE;
                    Field7Visible := TRUE;
                    Field6Visible := TRUE;
                    Field5Visible := TRUE;
                    Field4Visible := TRUE;
                    Field3Visible := TRUE;
                    Field2Visible := TRUE;
                    Field1Visible := TRUE;
                END ELSE
                    IF (Rec.Status = Rec.Status::Closed) AND (NOT Rec."Generated From Previous Entry") THEN BEGIN
                        Field15Visible := FALSE;
                        Field14Visible := FALSE;
                        Field13Visible := FALSE;
                        Field12Visible := FALSE;
                        Field11Visible := FALSE;
                        Field10Visible := FALSE;
                        Field9Visible := FALSE;
                        Field8Visible := FALSE;
                        Field7Visible := FALSE;
                        Field6Visible := FALSE;
                        Field5Visible := FALSE;
                        Field4Visible := FALSE;
                        Field3Visible := FALSE;
                        Field2Visible := FALSE;
                        Field1Visible := FALSE;

                    END
    end;

    trigger OnOpenPage()
    begin
        IF (Rec.Status = Rec.Status::Open) AND (Rec."Generated From Previous Entry") THEN BEGIN
            Field15Visible := FALSE;
            Field14Visible := FALSE;
            Field13Visible := TRUE;
            Field12Visible := FALSE;
            Field11Visible := TRUE;
            Field10Visible := FALSE;
            Field9Visible := FALSE;
            Field8Visible := FALSE;
            Field7Visible := TRUE;
            Field6Visible := FALSE;
            Field5Visible := TRUE;
            Field4Visible := TRUE;
            Field3Visible := FALSE;
            Field2Visible := FALSE;
            Field1Visible := FALSE;
        END ELSE
            IF (Rec.Status = Rec.Status::Closed) AND (Rec."Generated From Previous Entry") THEN BEGIN
                Field15Visible := FALSE;
                Field14Visible := FALSE;
                Field13Visible := FALSE;
                Field12Visible := FALSE;
                Field11Visible := FALSE;
                Field10Visible := FALSE;
                Field9Visible := FALSE;
                Field8Visible := FALSE;
                Field7Visible := FALSE;
                Field6Visible := FALSE;
                Field5Visible := FALSE;
                Field4Visible := FALSE;
                Field3Visible := FALSE;
                Field2Visible := FALSE;
                Field1Visible := FALSE;

            END ELSE
                IF (Rec.Status = Rec.Status::Open) AND (NOT Rec."Generated From Previous Entry") THEN BEGIN
                    Field15Visible := TRUE;
                    Field14Visible := TRUE;
                    Field13Visible := TRUE;
                    Field12Visible := TRUE;
                    Field11Visible := TRUE;
                    Field10Visible := TRUE;
                    Field9Visible := TRUE;
                    Field8Visible := TRUE;
                    Field7Visible := TRUE;
                    Field6Visible := TRUE;
                    Field5Visible := TRUE;
                    Field4Visible := TRUE;
                    Field3Visible := TRUE;
                    Field2Visible := TRUE;
                    Field1Visible := TRUE;
                END ELSE
                    IF (Rec.Status = Rec.Status::Closed) AND (NOT Rec."Generated From Previous Entry") THEN BEGIN
                        Field15Visible := FALSE;
                        Field14Visible := FALSE;
                        Field13Visible := FALSE;
                        Field12Visible := FALSE;
                        Field11Visible := FALSE;
                        Field10Visible := FALSE;
                        Field9Visible := FALSE;
                        Field8Visible := FALSE;
                        Field7Visible := FALSE;
                        Field6Visible := FALSE;
                        Field5Visible := FALSE;
                        Field4Visible := FALSE;
                        Field3Visible := FALSE;
                        Field2Visible := FALSE;
                        Field1Visible := FALSE;
                    END
    end;

    var

        Field1Visible: Boolean;

        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;

        Field6Visible: Boolean;

        Field7Visible: Boolean;

        Field8Visible: Boolean;

        Field9Visible: Boolean;

        Field10Visible: Boolean;

        Field11Visible: Boolean;

        Field12Visible: Boolean;

        Field13Visible: Boolean;

        Field14Visible: Boolean;

        Field15Visible: Boolean;

}

