page 50017 "Reminder Matrix"
{
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                field("View By"; ViewBy)
                {
                    Caption = 'View By';
                    OptionCaption = 'Day,Week,Month,Quarter,Year';

                    trigger OnValidate()
                    begin
                        SetColumns(SetWanted::Initial);
                    end;
                }
                field("Column Set"; ColumnSet)
                {
                    Caption = 'Column Set';
                    Editable = false;
                }
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    begin
                        //ApplicationManagement.MakeDateFilter(DateFilter);
                        SetColumns(SetWanted::Initial);
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Previous);
                end;
            }
            action("Previous Column")
            {
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::PreviousColumn);
                end;
            }
            action("Next Column")
            {
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::NextColumn);
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Next);
                end;
            }
        }
    }

    var
        MatrixRecord: array[32] of Record Date;
        MatrixMgt: Codeunit "Matrix Management";
        //ApplicationManagement: Codeunit ApplicationManagement;
        ColumnSet: Text[1024];
        ViewBy: Option Day,Week,Month,Quarter,Year;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        Matrix_ColumnCaptions: array[32] of Text[1024];
        DateFilter: Text;
        PKFirstRecInSet: Text;
        ColumnSetLength: Integer;

    local procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    begin
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, ARRAYLEN(Matrix_ColumnCaptions), FALSE, ViewBy, DateFilter, PKFirstRecInSet, Matrix_ColumnCaptions, ColumnSet,
        ColumnSetLength, MatrixRecord);

        //CurrPage.MatrixSubPage.PAGE.SetMatrixData(Matrix_ColumnCaptions, MatrixRecord, DateFilter, ColumnSetLength);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure Matrix_OnAfterGetRecord(CurrColumnNo: Integer)
    begin
    end;
}

