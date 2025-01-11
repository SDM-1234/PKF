codeunit 50025 "GL Filter Single Instance"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        FilterGLAcc: Boolean;
        PostingDate: Date;
        DocNoVar: Code[20];

    procedure SetGLFilter(ParGLFilter: Boolean; PostingDt: Date; DocNo: Code[20])
    begin
        CLEAR(FilterGLAcc);
        CLEAR(PostingDate);
        CLEAR(DocNoVar);
        FilterGLAcc := ParGLFilter;
        PostingDate := PostingDt;
        DocNoVar := DocNo;
    end;

    procedure GetGLFilter(): Boolean
    begin

        EXIT(FilterGLAcc)
    end;

    procedure GetPostingDate(): Date
    begin
        EXIT(PostingDate);
    end;

    procedure GetDocNo(): Code[20]
    begin
        EXIT(DocNoVar);
    end;
}

