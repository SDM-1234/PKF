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

        addlast(General)
        {
            field("Location GST Reg. No."; Rec."Location GST Reg. No.")
            {
                ApplicationArea = ALl;
                Editable = false;
            }
            field(LOB; Rec.LOB)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Resp. Name"; Rec."Resp. Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
            }
            field("Team Leader"; Rec."Team Leader")
            {
                ApplicationArea = All;
            }
            field("Sales Currency"; Rec."Sales Currency")
            {
                ApplicationArea = All;
            }
            field("Work Order No."; Rec."Work Order No.")
            {
                ApplicationArea = All;
            }
            field("Take Print"; Rec."Take Print")
            {
                ApplicationArea = All;
            }
            field("Bank Selection For Report"; Rec."Bank Selection For Report")
            {
                ApplicationArea = All;
                Visible = BankTypeSelectionVisible;
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

        // addafter(Preview)
        // {
        //     action("GST Sales Invoice")
        //     {
        //         Caption = 'GST Sales Invoice';
        //         Image = Invoice;
        //         Promoted = true;
        //         PromotedCategory = Category9;
        //         PromotedIsBig = false;

        //         trigger OnAction()
        //         var
        //             SalesHeaderL: Record "Sales Header";
        //         begin
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //             IF ("Posting No." <> "No.") THEN BEGIN
        //                 ERROR('Invoice No. & Posting No. are not same');
        //             END
        //             ELSE BEGIN
        //                 SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                 SalesHeaderL.SETRANGE("No.", "No.");
        //                 REPORT.RUNMODAL(50011, TRUE, FALSE, SalesHeaderL)
        //             END;
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //         end;
        //     }
        //     action("GST Expense Invoice")
        //     {
        //         Caption = 'GST Expense Invoice';
        //         Image = Invoice;
        //         Promoted = true;
        //         PromotedCategory = Category9;
        //         PromotedIsBig = false;

        //         trigger OnAction()
        //         var
        //             SalesHeaderL: Record "Sales Header";
        //         begin
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //             IF ("Posting No." <> "No.") THEN BEGIN
        //                 ERROR('Invoice No. & Posting No. are not same');
        //             END
        //             ELSE BEGIN
        //                 SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                 SalesHeaderL.SETRANGE("No.", "No.");
        //                 REPORT.RUNMODAL(50013, TRUE, FALSE, SalesHeaderL);
        //             END;
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //         end;
        //     }
        //     action("<Action1000000017>")
        //     {
        //         Caption = 'GST Sales Invoice SEZ';
        //         Image = Invoice;
        //         Promoted = true;
        //         PromotedCategory = Category9;

        //         trigger OnAction()
        //         var
        //             SalesHeaderL: Record "Sales Header";
        //         begin
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //             IF ("Posting No." <> "No.") THEN BEGIN
        //                 ERROR('Invoice No. & Posting No. are not same');
        //             END
        //             ELSE BEGIN
        //                 SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                 SalesHeaderL.SETRANGE("No.", "No.");
        //                 REPORT.RUNMODAL(50006, TRUE, FALSE, SalesHeaderL)
        //             END;
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //         end;
        //     }
        //     action("GST Sales Invoice Export")
        //     {
        //         Caption = 'GST Sales Invoice Export';
        //         Image = Invoice;
        //         Promoted = true;
        //         PromotedCategory = Category10;
        //         PromotedIsBig = false;

        //         trigger OnAction()
        //         var
        //             SalesHeaderL: Record "Sales Header";
        //         begin
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //             IF ("Posting No." <> "No.") THEN BEGIN
        //                 ERROR('Invoice No. & Posting No. are not same');
        //             END
        //             ELSE BEGIN
        //                 SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                 SalesHeaderL.SETRANGE("No.", "No.");
        //                 REPORT.RUNMODAL(50014, TRUE, FALSE, SalesHeaderL)
        //             END;
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //         end;
        //     }
        //     action("<Action1000000010>")
        //     {
        //         Caption = 'GST Expense Invoice Export';
        //         Image = Invoice;
        //         Promoted = true;
        //         PromotedCategory = Category10;
        //         PromotedIsBig = false;

        //         trigger OnAction()
        //         var
        //             SalesHeaderL: Record "Sales Header";
        //         begin
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - START
        //             IF ("Posting No." <> "No.") THEN BEGIN
        //                 ERROR('Invoice No. & Posting No. are not same');
        //             END
        //             ELSE BEGIN
        //                 SalesHeaderL.SETRANGE("Document Type", "Document Type");
        //                 SalesHeaderL.SETRANGE("No.", "No.");
        //                 REPORT.RUNMODAL(50015, TRUE, FALSE, SalesHeaderL)
        //             END;
        //             //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
        //         end;
        //     }
        // }
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
        IF NOT ((Rec."Sales Currency" IN [Rec."Sales Currency"::INR, Rec."Sales Currency"::" "]) OR (Rec."Currency Code" IN ['INR', ''])) THEN
            IF NOT (Rec."Currency Code" = FORMAT(Rec."Sales Currency")) THEN
                ERROR('Curreny Code Should be same as Sales Currency');

        IF Rec."Posting No." = '' THEN
            ERROR('Please take print out');
    End;
}

