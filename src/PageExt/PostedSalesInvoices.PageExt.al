pageextension 50037 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
            field("Invoice Types"; Rec."Invoice Types")
            {
                ApplicationArea = All;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Amount)
        {
            field(TaxAmount; Rec."Amount Including VAT" - Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Tax Amount';
            }
            field("Amt in LCY"; AmtinLCY)
            {
                ApplicationArea = All;
                Caption = 'Amount to Customer Local Currency';
            }
        }
        addlast(Control1)
        {
            field("QR Code_"; Rec."QR Code".HasValue)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'QR Code';
                Caption = 'QR Code';
            }
        }

        addafter(IncomingDocAttachFactBox)
        {
            part("QR Code"; "Sales Invoice QR Code")
            {
                Caption = 'QR Code';
                SubPageLink = "No." = field("No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter(Statistics)
        {
            fileuploadaction(BulkAttachment)
            {
                ApplicationArea = All;
                Caption = 'Upload Bulk Attachments';
                ToolTip = 'Upload Bulk Attachments';
                AllowMultipleFiles = true;
                AllowedFileExtensions = '.pdf';
                Image = Import;
                trigger OnAction(Files: List of [FileUpload])
                var
                    SalesInv: Record "Sales Invoice Header";
                    DocAttach: Record "Document Attachment";
                    RecRef: RecordRef;
                    CurrentFile: FileUpload;
                    TempInStream: InStream;
                    FileName: Text;
                begin
                    foreach CurrentFile in Files do begin
                        FileName := CopyStr(ConvertStr(CurrentFile.FileName, '_', '/'), 1, StrLen(CurrentFile.FileName) - 4);
                        Message('FileName: %1', FileName);
                        if SalesInv.Get(FileName) then begin
                            CurrentFile.CreateInStream(TempInStream, TEXTENCODING::UTF8);
                            DocAttach.Init();
                            DocAttach.ID := 0;
                            RecRef.Open(Database::"Sales Invoice Header");
                            RecRef.GetBySystemId(SalesInv.SystemId);
                            DocAttach.SaveAttachmentFromStream(TempInStream, RecRef, CurrentFile.FileName, true);
                            RecRef.Close();
                        end;
                    end;
                end;
            }
        }
        addlast(Category_Category4)
        {
            actionref(BulkAttachment_Promoted; BulkAttachment)
            {
            }
        }
    }


    var
        DCLE: Record "Detailed Cust. Ledg. Entry";
        AmtinLCY: Decimal;

    trigger OnAfterGetRecord()
    begin
        AmtinLCY := 0;
        DCLE.RESET();
        DCLE.SETRANGE(DCLE."Document No.", Rec."No.");
        DCLE.SETRANGE(DCLE."Initial Document Type", DCLE."Initial Document Type"::Invoice);
        IF DCLE.FINDFIRST() THEN
            AmtinLCY := DCLE."Amount (LCY)";
    end;
}

