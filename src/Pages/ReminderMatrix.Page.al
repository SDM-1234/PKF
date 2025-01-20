/// <summary>
/// Page Reminder Matrix (ID 50017).
/// </summary>
page 50017 "Reminder Matrix"
{
    ApplicationArea = All;
    Caption = 'PKF- Reminder Matrix';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                field("View By"; this.ViewBy)
                {
                    Caption = 'View By';
                    trigger OnValidate()
                    begin
                        this.SetColumns(this.SetWanted::Initial);
                    end;
                }
                field("Column Set"; this.ColumnSet)
                {
                    Caption = 'Column Set';
                    Editable = false;
                }
                field(DateFilter; this.DateFilter)
                {
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    begin
                        FilterTokens.MakeDateFilter(DateFilter);
                        this.SetColumns(this.SetWanted::Initial);
                    end;
                }
            }
            part(MatrixSubPage; "Matrix Reminder List By Period")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Previous);
                end;
            }
            action("Previous Column")
            {
                Caption = 'Previous Column';
                Image = PreviousRecord;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::PreviousColumn);
                end;
            }
            action("Next Column")
            {
                Caption = 'Next Column';
                Image = NextRecord;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::NextColumn);
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Next);
                end;
            }
        }
        area(Promoted)
        {
            actionref(NextColumn_Promoted; "Next Column")
            {
            }
            actionref(NextSet_Promoted; "Next Set")
            {

            }
            actionref(PreviousColumn_Promoted; "Previous Column")
            {

            }
            actionref(PreviousSet_Promoted; "Previous Set")
            {

            }
        }
    }

    var
        MatrixRecord: array[32] of Record Date;
        MatrixMgt: Codeunit "Matrix Management";
        FilterTokens: Codeunit "Filter Tokens";
        ColumnSet: Text[1024];
        ViewBy: enum "Analysis Period Type";
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        Matrix_ColumnCaptions: array[32] of Text[1024];
        DateFilter: Text;
        PKFirstRecInSet: Text;
        ColumnSetLength: Integer;

    local procedure SetColumns(SetWantedPar: Option)
    begin
        this.MatrixMgt.GeneratePeriodMatrixData(SetWantedPar, ARRAYLEN(this.Matrix_ColumnCaptions), false, this.ViewBy, this.DateFilter, PKFirstRecInSet, Matrix_ColumnCaptions, ColumnSet,
        this.ColumnSetLength, this.MatrixRecord);
        CurrPage.MatrixSubPage.PAGE.SetMatrixData(Matrix_ColumnCaptions, MatrixRecord, DateFilter, ColumnSetLength);
        CurrPage.UPDATE(false);
    end;

}

