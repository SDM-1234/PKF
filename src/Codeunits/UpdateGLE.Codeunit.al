codeunit 50004 "Update GLE"
{

    trigger OnRun()
    begin
        IF GLRegister.FINDFIRST THEN
            REPEAT
                GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                IF GLEntry.FINDSET THEN
                    REPEAT
                        GLEntry."Creation Date" := GLRegister."Creation Date";
                        GLEntry.MODIFY;
                    UNTIL GLEntry.NEXT() = 0;
            UNTIL GLRegister.NEXT() = 0;
        MESSAGE('Updated');
    end;

    var
        GLEntry: Record "G/L Entry";
        GLRegister: Record "G/L Register";
}

