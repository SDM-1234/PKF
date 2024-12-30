pageextension 50093 pageextension50093 extends "Sales Invoice"
{
    layout
    {
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address"(Control 75)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Address 2"(Control 77)".

        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Name"(Control 16)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address"(Control 18)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Bill-to Address 2"(Control 20)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 36)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 38)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address 2"(Control 40)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".

        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter(Control1500022)
        {
            field("Location Code"; "Location Code")
            {
            }
        }
        addafter("Incoming Document Entry No.")
        {
            field("Payment Terms Code"; "Payment Terms Code")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("Posting No. Series"; "Posting No. Series")
            {
            }
            field("Posting No."; "Posting No.")
            {
                Editable = false;
            }
        }
        addafter("GST Reason Type")
        {
            field("Salesperson Code"; "Salesperson Code")
            {
            }
            field(LOB; LOB)
            {
                Editable = false;
            }
            field(Segment; Segment)
            {
                Editable = false;
            }
            field("Resp. Name"; "Resp. Name")
            {
                Editable = false;
            }
            field(Remarks; Remarks)
            {
            }
            field("Type of Invoice"; "Type of Invoice")
            {
                Visible = false;
            }
            field("Invoice Types"; "Invoice Types")
            {
            }
            field("Team Leader"; "Team Leader")
            {
            }
            field("Sales Currency"; "Sales Currency")
            {
            }
            field("Work Order No."; "Work Order No.")
            {
            }
            field("Take Print"; "Take Print")
            {
            }
            field("Bank Selection For Report"; "Bank Selection For Report")
            {
                Visible = BankTypeSelectionVisible;
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on "Post(Action 71).OnAction".

        //trigger (Variable: lSalesCurrCode)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Post(Action 71).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        TESTFIELD("Sell-to Post Code");
        TESTFIELD("Sell-to City");
        TESTFIELD(Structure);
        //SDM.RSF.290423
        IF "Customer Posting Group" = 'FOREIGN' THEN BEGIN
          TESTFIELD("Invoice Type","Invoice Type"::Export);
          TESTFIELD("GST Without Payment of Duty",TRUE);
        END;
        //SDM.RSF.290423

        IF NOT (("Sales Currency" IN ["Sales Currency"::INR,"Sales Currency"::" "])  OR ("Currency Code" IN[ 'INR','']))  THEN
          IF NOT ("Currency Code" = FORMAT("Sales Currency")) THEN
            ERROR('Curreny Code Should be same as Sales Currency');

        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
          Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;


        //Unsupported feature: Code Modification on "PostAndSend(Action 76).OnAction".

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


        //Unsupported feature: Code Modification on ""Post and &Print"(Action 72).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Salesperson Code");
        IF "Posting No." = '' THEN
          ERROR('Please take print out')
        ELSE
          Post(CODEUNIT::"Sales-Post + Print");
        */
        //end;


        //Unsupported feature: Code Modification on ""Post and Email"(Action 17).OnAction".

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
        addafter(Preview)
        {
            action("GST Sales Invoice")
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
            action("GST Expense Invoice")
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
            action("<Action1000000017>")
            {
                Caption = 'GST Sales Invoice SEZ';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category9;

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
            action("GST Sales Invoice Export")
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

    var
        lSalesCurrCode: Code[10];

    var
        BankTypeSelectionVisible: Boolean;
        CompanyInformation: Record "Company Information";


        //Unsupported feature: Code Modification on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetExtDocNoMandatoryCondition;
        ReturnOrderNoEnable := TRUE;
        ReturnOrderNoVisible := TRUE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        BankTypeSelectionVisible := FALSE;
        */
        //end;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;

        SetDocNoVisible;
        SetLocGSTRegNoEditable;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInformation.GET;

        #1..8


        IF CompanyInformation.Name = 'PKF PROSERV PVT. LTD.' THEN
          BankTypeSelectionVisible := TRUE;
        */
        //end;
}

