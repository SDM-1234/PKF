

codeunit 50009 SingleInstance
{
    SingleInstance = true;
    procedure SetPostingdate(postingdate: Date; DocNo: code[20])
    begin
        gPostingDate := postingdate;
        gDocNo := DocNo;
    end;

    Procedure GetPostingdate(var postingdate: Date; var DocNo: code[20])
    begin
        postingdate := gPostingDate;
        DocNo := gDocNo;
    end;

    var
        gPostingDate: Date;
        gDocNo: code[20];
}
