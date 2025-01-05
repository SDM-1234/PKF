page 50021 "E-Invoice Requests"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "E-Invoicing Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Acknowledgement No."; Rec."Acknowledgement No.")
                {
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                }
                field("IRN No."; Rec."IRN No.")
                {
                }
                field("Signed QR Code"; Rec."Signed QR Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field("Request ID"; Rec."Request ID")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Request Time"; Rec."Request Time")
                {
                }
                field("Signed Invoice"; Rec."Signed Invoice")
                {
                }
                field("Signed QR Code2"; Rec."Signed QR Code2")
                {
                }
                field("Signed QR Code3"; Rec."Signed QR Code3")
                {
                }
                field("QR Image"; Rec."QR Image")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("E-Invoice Generated"; Rec."E-Invoice Generated")
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("E-Invoice Canceled"; Rec."E-Invoice Canceled")
                {
                }
                field("Cancel Date"; Rec."Cancel Date")
                {
                }
                field("Cancel Time"; Rec."Cancel Time")
                {
                }
                field("Cancel User Id"; Rec."Cancel User Id")
                {
                }
                field("Signed QR Code4"; Rec."Signed QR Code4")
                {
                }
                field("Error Message2"; Rec."Error Message2")
                {
                }
                field("Error Message3"; Rec."Error Message3")
                {
                }
                field("Info Details"; Rec."Info Details")
                {
                }
                field("Info Details2"; Rec."Info Details2")
                {
                }
                field("QR Code URL"; Rec."QR Code URL")
                {
                }
                field("E Invoice PDF URL"; Rec."E Invoice PDF URL")
                {
                }
            }
        }
    }

    actions
    {
    }
}

