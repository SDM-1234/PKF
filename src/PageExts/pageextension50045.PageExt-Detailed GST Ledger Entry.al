pageextension 50045 pageextension50045 extends "Detailed GST Ledger Entry"
{
    layout
    {
        addafter("Source No.")
        {
            field("Source Name"; SourceName)
            {
                Caption = 'Source Name';
            }
        }
        addafter("External Document No.")
        {
            field("Document Date"; DocDate)
            {
                Caption = 'Document Date';
            }
            field("Bank Payment No."; BankPaymentNo)
            {
                Caption = 'Bank Payment No.';
            }
            field("Bank Payment Date"; BankPaymentDate)
            {
                Caption = 'Bank Payment Date';
            }
        }
    }

    var
        SourceName: Text[130];
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
        DocDate: Date;
        RecGLEntry: Record "G/L Entry";
        BankPaymentNo: Code[20];
        BankPaymentDate: Date;
        RecDVLE: Record "Detailed Vendor Ledg. Entry";
        RecDVLE1: Record "Detailed Vendor Ledg. Entry";


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        SourceName := '';
        IF ("Source Type" = "Source Type"::Vendor) THEN
          RecVendor.RESET;
          RecVendor.SETRANGE(RecVendor."No.","Source No.");
          IF RecVendor.FINDFIRST THEN
            SourceName := RecVendor.Name;

        IF ("Source Type" = "Source Type"::Customer) THEN
          RecCustomer.RESET;
          RecCustomer.SETRANGE(RecCustomer."No.","Source No.");
          IF RecCustomer.FINDFIRST THEN
            SourceName := RecCustomer.Name;

        RecGLEntry.RESET;
        RecGLEntry.SETRANGE(RecGLEntry."Document No.","Document No.");
        IF RecGLEntry.FINDFIRST THEN
          DocDate := RecGLEntry."Document Date";

        BankPaymentDate := 0D;
        BankPaymentNo := '';
        RecDVLE.RESET;
        RecDVLE.SETRANGE(RecDVLE."Entry Type",RecDVLE."Entry Type"::"Initial Entry");
        RecDVLE.SETRANGE(RecDVLE."Document No.","Document No.");
        IF RecDVLE.FINDFIRST THEN BEGIN
          RecDVLE1.RESET;
          RecDVLE1.SETRANGE(RecDVLE1."Vendor Ledger Entry No.",RecDVLE."Vendor Ledger Entry No.");
          RecDVLE1.SETRANGE(RecDVLE1."Entry Type",RecDVLE1."Entry Type"::Application);
          IF RecDVLE1.FINDFIRST THEN BEGIN
            BankPaymentDate := RecDVLE1."Posting Date";
            BankPaymentNo := RecDVLE1."Document No.";
          END;
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML).

}

