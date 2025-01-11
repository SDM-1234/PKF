pageextension 50045 DetailedGSTLedgerEntry extends "Detailed GST Ledger Entry"
{
    layout
    {
        addafter("Source No.")
        {
            field("Source Name"; SourceName)
            {
                Caption = 'Source Name';
                ApplicationArea = All;

            }
        }
        addafter("External Document No.")
        {
            field("Document Date"; DocDate)
            {
                Caption = 'Document Date';
                ApplicationArea = All;

            }
            field("Bank Payment No."; BankPaymentNo)
            {
                Caption = 'Bank Payment No.';
                ApplicationArea = All;

            }
            field("Bank Payment Date"; BankPaymentDate)
            {
                Caption = 'Bank Payment Date';
                ApplicationArea = All;

            }
        }
    }

    var
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
        RecGLEntry: Record "G/L Entry";
        RecDVLE: Record "Detailed Vendor Ledg. Entry";
        RecDVLE1: Record "Detailed Vendor Ledg. Entry";
        SourceName: Text[130];
        DocDate: Date;
        BankPaymentNo: Code[20];
        BankPaymentDate: Date;

    trigger OnAfterGetRecord()
    begin

        SourceName := '';
        IF (Rec."Source Type" = "Source Type"::Vendor) THEN
            RecVendor.RESET();
        RecVendor.SETRANGE(RecVendor."No.", Rec."Source No.");
        IF RecVendor.FINDFIRST() THEN
            SourceName := RecVendor.Name;

        IF (Rec."Source Type" = "Source Type"::Customer) THEN
            RecCustomer.RESET();
        RecCustomer.SETRANGE(RecCustomer."No.", Rec."Source No.");
        IF RecCustomer.FINDFIRST() THEN
            SourceName := RecCustomer.Name;

        RecGLEntry.RESET();
        RecGLEntry.SETRANGE(RecGLEntry."Document No.", Rec."Document No.");
        IF RecGLEntry.FINDFIRST() THEN
            DocDate := RecGLEntry."Document Date";

        BankPaymentDate := 0D;
        BankPaymentNo := '';
        RecDVLE.RESET();
        RecDVLE.SETRANGE(RecDVLE."Entry Type", RecDVLE."Entry Type"::"Initial Entry");
        RecDVLE.SETRANGE(RecDVLE."Document No.", Rec."Document No.");
        IF RecDVLE.FINDFIRST() THEN BEGIN
            RecDVLE1.RESET();
            RecDVLE1.SETRANGE(RecDVLE1."Vendor Ledger Entry No.", RecDVLE."Vendor Ledger Entry No.");
            RecDVLE1.SETRANGE(RecDVLE1."Entry Type", RecDVLE1."Entry Type"::Application);
            IF RecDVLE1.FINDFIRST() THEN BEGIN
                BankPaymentDate := RecDVLE1."Posting Date";
                BankPaymentNo := RecDVLE1."Document No.";
            END;
        END;
    end;

}

