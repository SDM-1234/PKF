pageextension 50093 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        modify("Salesperson Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                EmployeeLOB: Record "Employee LOB";
            begin
                IF (PAGE.RUNMODAL(PAGE::"Employee LOB", EmployeeLOB, EmployeeLOB.LOB) = ACTION::LookupOK) THEN BEGIN
                    Rec."Salesperson Code" := EmployeeLOB."Emp No.";
                    Rec."Resp. Name" := EmployeeLOB."Emp Name";
                    Rec.LOB := EmployeeLOB.LOB;
                    Rec.Segment := EmployeeLOB.Segment;


                END;
            end;
        }

        addafter("Assigned User ID")
        {

            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. field.', Comment = '%';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. Series field.', Comment = '%';
            }
        }

        addlast(General)
        {
            field("Location GST Reg. No."; Rec."Location GST Reg. No.")
            {
                ApplicationArea = ALl;
                Editable = false;
                ToolTip = 'Specifies the GST registration number of the Location specified on the Sales document.';
            }
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the LOB field.';
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Segment field.';
            }
            field("Resp. Name"; Rec."Resp. Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Resp. Name field.';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Types field.';
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Leader field.';
            }
            field("Sales Currency"; Rec."Sales Currency")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Currency field.';
            }
            field("Work Order No."; Rec."Work Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Work Order No. field.';
            }
            field("Take Print"; Rec."Take Print")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Take Print field.';
            }
            field("Bank Selection For Report"; Rec."Bank Selection For Report")
            {
                ApplicationArea = All;
                Visible = BankTypeSelectionVisible;
                ToolTip = 'Specifies the value of the Bank Selection For Report field.';
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                PrePostValidations();
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                PrePostValidations();
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            begin
                PrePostValidations();
            end;
        }

        addafter(Preview)
        {
            action("GST Sales Invoice")
            {
                Caption = 'GST Sales Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = false;
                ToolTip = 'Executes the GST Sales Invoice action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    //SDM BCS on control of Invoice No. & Posting No. should be same - START
                    IF (Rec."Posting No." <> Rec."No.") THEN
                        ERROR('Invoice No. & Posting No. are not same')
                    ELSE BEGIN
                        SalesHeaderL.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeaderL.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50011, TRUE, FALSE, SalesHeaderL)
                    END;
                    //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                end;
            }
            action("GST Expense Invoice")
            {
                Caption = 'GST Expense Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = false;
                ToolTip = 'Executes the GST Expense Invoice action.';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    //SDM BCS on control of Invoice No. & Posting No. should be same - START
                    IF (Rec."Posting No." <> Rec."No.") THEN
                        ERROR('Invoice No. & Posting No. are not same')

                    ELSE BEGIN
                        SalesHeaderL.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeaderL.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50013, TRUE, FALSE, SalesHeaderL);
                    END;
                    //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                end;
            }
            action("GST Sales Invoice SEZ")
            {
                Caption = 'GST Sales Invoice SEZ';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Executes the GST Sales Invoice SEZ action.';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    //SDM BCS on control of Invoice No. & Posting No. should be same - START
                    IF (Rec."Posting No." <> Rec."No.") THEN
                        ERROR('Invoice No. & Posting No. are not same')

                    ELSE BEGIN
                        SalesHeaderL.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeaderL.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50006, TRUE, FALSE, SalesHeaderL)
                    END;
                    //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                end;
            }
            action("GST Sales Invoice Export")
            {
                Caption = 'GST Sales Invoice Export';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = false;
                ToolTip = 'Executes the GST Sales Invoice Export action.';
                ApplicationArea = All;
                Visible = false;




                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    //SDM BCS on control of Invoice No. & Posting No. should be same - START
                    IF (Rec."Posting No." <> Rec."No.") THEN
                        ERROR('Invoice No. & Posting No. are not same')

                    ELSE BEGIN
                        SalesHeaderL.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeaderL.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50014, TRUE, FALSE, SalesHeaderL)
                    END;
                    //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                end;
            }
            action("GST Expense Invoice Export")
            {
                Caption = 'GST Expense Invoice Export';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = false;
                ToolTip = 'Executes the GST Expense Invoice Export action.';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    //SDM BCS on control of Invoice No. & Posting No. should be same - START
                    IF (Rec."Posting No." <> Rec."No.") THEN
                        ERROR('Invoice No. & Posting No. are not same')
                    ELSE BEGIN
                        SalesHeaderL.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeaderL.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50015, TRUE, FALSE, SalesHeaderL)

                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                end;
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        BankTypeSelectionVisible: Boolean;

    trigger OnOpenPage()
    begin
        CompanyInformation.GET();
        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN
            BankTypeSelectionVisible := TRUE;

    end;

    local procedure PrePostValidations()
    BEGIN

        if Rec."GST Customer Type" IN [Rec."GST Customer Type"::Registered, Rec."GST Customer Type"::Unregistered, Rec."GST Customer Type"::" "] then
            CalculateGSTAmount();


        IF NOT ((Rec."Sales Currency" IN [Rec."Sales Currency"::INR, Rec."Sales Currency"::" "]) OR (Rec."Currency Code" IN ['INR', ''])) THEN
            IF NOT (Rec."Currency Code" = FORMAT(Rec."Sales Currency")) THEN
                ERROR('Curreny Code Should be same as Sales Currency');

        IF Rec."Posting No." = '' THEN
            ERROR('Please take print out');
    End;

    local procedure CalculateGSTAmount()
    var
        SalesLine1: Record "Sales Line";
        TaxTrnasactionValue1: Record "Tax Transaction Value";
        TaxTrnasactionValue: Record "Tax Transaction Value";
        GSTCompAmount: array[10] of Decimal;
        GSTCompNo: Integer;
        GSTComponentCode: array[10] of Integer;
        GSTAmountByLineNo: Decimal;
    begin
        SalesLine1.SetCurrentKey("Document No.", "Document Type", "Line No.");
        SalesLine1.SetRange("Document No.", Rec."No.");
        SalesLine1.SetRange("Document Type", Rec."Document Type");
        SalesLine1.SetRange(Type, SalesLine1.Type::"G/L Account");
        if SalesLine1.FindSet() then
            repeat
                GSTAmountByLineNo := 0;
                GSTCompNo := 1;
                TaxTrnasactionValue.Reset();
                TaxTrnasactionValue.SetRange("Tax Record ID", SalesLine1.RecordId);
                TaxTrnasactionValue.SetRange("Tax Type", 'GST');
                TaxTrnasactionValue.SetRange("Value Type", TaxTrnasactionValue."Value Type"::COMPONENT);
                TaxTrnasactionValue.SetFilter(Percent, '<>%1', 0);
                if TaxTrnasactionValue.FindSet() then
                    repeat
                        GSTCompNo := TaxTrnasactionValue."Value ID";
                        GSTComponentCode[GSTCompNo] := TaxTrnasactionValue."Value ID";
                        TaxTrnasactionValue1.Reset();
                        TaxTrnasactionValue1.SetRange("Tax Record ID", SalesLine1.RecordId);
                        TaxTrnasactionValue1.SetRange("Tax Type", 'GST');
                        TaxTrnasactionValue1.SetRange("Value Type", TaxTrnasactionValue1."Value Type"::COMPONENT);
                        TaxTrnasactionValue1.SetRange("Value ID", GSTComponentCode[GSTCompNo]);
                        if TaxTrnasactionValue1.FindSet() then begin
                            repeat
                                GSTCompAmount[GSTCompNo] += TaxTrnasactionValue1."Amount";
                                GSTAmountByLineNo += TaxTrnasactionValue1.Amount;
                            until TaxTrnasactionValue1.Next() = 0;
                            GSTCompNo += 1;
                        end;
                    until TaxTrnasactionValue.Next() = 0;
                if GSTAmountByLineNo = 0 then
                    Error('GST Amount is missing for Document No. %1, Line No. %2. Please verify the GST calculation.', SalesLine1."Document No.", SalesLine1."Line No.");
            until SalesLine1.Next() = 0;
    end;
}

