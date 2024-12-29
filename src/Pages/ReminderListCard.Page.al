page 50015 "Reminder List Card"
{
    PageType = Card;
    SourceTable = "Reminder List";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    AssistEdit = true;
                    Editable = Field1Visible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Type; Type)
                {
                    Editable = Field2Visible;
                }
                field(Decription; Decription)
                {
                    Editable = Field3Visible;
                }
                field("Start Period"; "Start Period")
                {
                    Editable = Field4Visible;
                }
                field("End Period"; "End Period")
                {
                    Editable = Field5Visible;
                }
                field(Company; Company)
                {
                    Editable = Field6Visible;
                }
                field(Status; Status)
                {
                    Editable = Field7Visible;
                }
                field(Location; Location)
                {
                    Editable = Field8Visible;
                }
                field("Generated From Previous Entry"; "Generated From Previous Entry")
                {
                }
            }
            group(Purchase)
            {
                field("Purchase Date"; "Purchase Date")
                {
                    Editable = Field9Visible;
                }
                field("Purchase Amount"; "Purchase Amount")
                {
                    Editable = Field10Visible;
                }
                field(Amount; Amount)
                {
                    Editable = Field11Visible;
                }
                field("Count"; Count)
                {
                    Editable = Field12Visible;
                }
                field("Payment Date"; "Payment Date")
                {
                    Editable = Field13Visible;
                }
            }
            group("Email Parameters")
            {
                field("Send To"; "Send To")
                {
                    Editable = Field14Visible;
                }
                field("Send CC"; "Send CC")
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
        IF (Status = Status::Open) AND ("Generated From Previous Entry") THEN BEGIN
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
            IF (Status = Status::Closed) AND ("Generated From Previous Entry") THEN BEGIN
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
                IF (Status = Status::Open) AND (NOT "Generated From Previous Entry") THEN BEGIN
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
                    IF (Status = Status::Closed) AND (NOT "Generated From Previous Entry") THEN BEGIN
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
        IF (Status = Status::Open) AND ("Generated From Previous Entry") THEN BEGIN
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
            IF (Status = Status::Closed) AND ("Generated From Previous Entry") THEN BEGIN
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
                IF (Status = Status::Open) AND (NOT "Generated From Previous Entry") THEN BEGIN
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
                    IF (Status = Status::Closed) AND (NOT "Generated From Previous Entry") THEN BEGIN
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
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        PageEditable: Boolean;
}

