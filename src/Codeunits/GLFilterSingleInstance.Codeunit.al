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

    [Scope('Internal')]
    procedure SetGLFilter(ParGLFilter: Boolean; PostingDt: Date; DocNo: Code[20])
    begin
        CLEAR(FilterGLAcc);
        CLEAR(PostingDate);
        CLEAR(DocNoVar);
        FilterGLAcc := ParGLFilter;
        PostingDate := PostingDt;
        DocNoVar := DocNo;
    end;

    [Scope('Internal')]
    procedure GetGLFilter(): Boolean
    begin

        EXIT(FilterGLAcc)
    end;

    [Scope('Internal')]
    procedure GetPostingDate(): Date
    begin
        EXIT(PostingDate);
    end;

    [Scope('Internal')]
    procedure GetDocNo(): Code[20]
    begin
        EXIT(DocNoVar);
    end;
}

