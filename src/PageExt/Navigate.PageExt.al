pageextension 50079 Navigate extends Navigate
{
    var
        GLFilterSingleInstance: Codeunit "GL Filter Single Instance";


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        GLFilterSingleInstance.SetGLFilter(FALSE, 0D, '');//SDM.RSF.281024

    end;
}

