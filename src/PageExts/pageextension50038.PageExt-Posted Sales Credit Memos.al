pageextension 50038 pageextension50038 extends "Posted Sales Credit Memos"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Sell-to Customer Name"(Control 6)".

        modify("Amount Including VAT")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }
        modify("Bill-to Name")
        {
            Visible = false;
        }
        modify("Bill-to Post Code")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Bill-to Contact")
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("Ship-to Name")
        {
            Visible = false;
        }
        modify("Ship-to Post Code")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Ship-to Contact")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Document Exchange Status")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("External Document No."; "External Document No.")
            {
            }
            field("Posting Date"; "Posting Date")
            {
            }
            field("Salesperson Code"; "Salesperson Code")
            {
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
            }
            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
            }
            field("Location Code"; "Location Code")
            {
            }
            field("Invoice Types"; "Invoice Types")
            {
            }
        }
        addafter(Amount)
        {
            field(TaxAmount; "Amount to Customer" - Amount)
            {
                Caption = 'Tax Amount';
            }
            field("Amount to Customer"; "Amount to Customer")
            {
            }
            field("Amt in LCY"; AmtinLCY)
            {
                Caption = 'Amount to Customer Local Currency';
            }
        }
    }

    var
        AmtinLCY: Decimal;
        DCLE: Record "Detailed Cust. Ledg. Entry";


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocExchStatusStyle := GetDocExchStatusStyle;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DocExchStatusStyle := GetDocExchStatusStyle;

        AmtinLCY:=0;
        DCLE.RESET;
        DCLE.SETRANGE(DCLE."Document No.","No.");
        DCLE.SETRANGE(DCLE."Initial Document Type",DCLE."Initial Document Type"::"Credit Memo");
        IF DCLE.FINDFIRST THEN
          AmtinLCY:=-DCLE."Amount (LCY)";
        */
        //end;
}

