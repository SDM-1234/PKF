pageextension 50151 pageextension50151 extends "Sales Invoice List"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 15)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 153)".

        modify("Posting Date")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = true;
        }
        addafter("External Document No.")
        {
            field("Posting No."; "Posting No.")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("Invoice Types"; "Invoice Types")
            {
            }
            field(Amount; Amount)
            {
            }
            field("Tax Amount"; "Amount to Customer" - Amount)
            {
            }
            field("Amount to Customer"; "Amount to Customer")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on ""P&ost"(Action 51).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
          SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;


        //Unsupported feature: Code Modification on ""Post and &Print"(Action 52).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Sales-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
         SendToPosting(CODEUNIT::"Sales-Post + Print");
        */
        //end;


        //Unsupported feature: Code Modification on ""Post and Email"(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesPostPrint.PostAndEmail(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
          SalesPostPrint.PostAndEmail(Rec);
        */
        //end;


        //Unsupported feature: Code Modification on "PostAndSend(Action 59).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Sales-Post and Send");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
          SendToPosting(CODEUNIT::"Sales-Post and Send");
        */
        //end;
        addafter("P&osting")
        {
            group(Print)
            {
                Caption = 'Print';
                action("<Action1000000014>")
                {
                    Caption = 'GST Sales Invoice';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        //SDM BCS on control of Invoice No. & Posting No. should be same - START
                        IF ("Posting No." <> "No.") THEN BEGIN
                            ERROR('Invoice No. & Posting No. are not same');
                        END
                        ELSE BEGIN
                            SalesHeaderL.SETRANGE("Document Type", "Document Type");
                            SalesHeaderL.SETRANGE("No.", "No.");
                            REPORT.RUNMODAL(50011, TRUE, FALSE, SalesHeaderL)
                        END;
                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                }
                action("<Action1000000015>")
                {
                    Caption = 'GST Expense Invoice';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        //SDM BCS on control of Invoice No. & Posting No. should be same - START
                        IF ("Posting No." <> "No.") THEN BEGIN
                            ERROR('Invoice No. & Posting No. are not same');
                        END
                        ELSE BEGIN
                            SalesHeaderL.SETRANGE("Document Type", "Document Type");
                            SalesHeaderL.SETRANGE("No.", "No.");
                            REPORT.RUNMODAL(50013, TRUE, FALSE, SalesHeaderL);
                        END;
                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                }
                action("<Action1000000016>")
                {
                    Caption = 'GST Sales Invoice SEZ';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        //SDM BCS on control of Invoice No. & Posting No. should be same - START
                        IF ("Posting No." <> "No.") THEN BEGIN
                            ERROR('Invoice No. & Posting No. are not same');
                        END
                        ELSE BEGIN
                            SalesHeaderL.SETRANGE("Document Type", "Document Type");
                            SalesHeaderL.SETRANGE("No.", "No.");
                            REPORT.RUNMODAL(50006, TRUE, FALSE, SalesHeaderL)
                        END;
                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                }
                action("<Action1000000017>")
                {
                    Caption = 'GST Sales Invoice Export';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        //SDM BCS on control of Invoice No. & Posting No. should be same - START
                        IF ("Posting No." <> "No.") THEN BEGIN
                            ERROR('Invoice No. & Posting No. are not same');
                        END
                        ELSE BEGIN
                            SalesHeaderL.SETRANGE("Document Type", "Document Type");
                            SalesHeaderL.SETRANGE("No.", "No.");
                            REPORT.RUNMODAL(50014, TRUE, FALSE, SalesHeaderL)
                        END;
                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                }
                action("<Action1000000010>")
                {
                    Caption = 'GST Expense Invoice Export';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        //SDM BCS on control of Invoice No. & Posting No. should be same - START
                        IF ("Posting No." <> "No.") THEN BEGIN
                            ERROR('Invoice No. & Posting No. are not same');
                        END
                        ELSE BEGIN
                            SalesHeaderL.SETRANGE("Document Type", "Document Type");
                            SalesHeaderL.SETRANGE("No.", "No.");
                            REPORT.RUNMODAL(50015, TRUE, FALSE, SalesHeaderL)
                        END;
                        //SDM BCS on control of Invoice No. & Posting No. should be same - STOP
                    end;
                }
            }
        }
    }
}

