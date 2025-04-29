page 50101 "Date Input Page"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    SourceTable = "Input Temp Table";
    Editable = true;

    layout
    {
        area(content)
        {
            field("Input Date"; Rec."Input Date")
            {
                Caption = 'Enter Posting Date';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }

            action(Cancel)
            {
                Caption = 'Cancel';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        TempDate: Date;

    procedure SetDate(NewDate: Date)
    begin
        TempDate := NewDate;
    end;

    procedure GetDate(): Date
    begin
        exit(TempDate);
    end;
}