pageextension 50123 pageextension50123 extends "Location Card"
{
    layout
    {
        modify(General)
        {
            Caption = 'General';
        }
        modify(Communication)
        {
            Caption = 'Communication';
        }
        modify(Warehouse)
        {
            Caption = 'Warehouse';
        }
        modify("Customized Calendar")
        {
            Caption = 'Customized Calendar';
        }
        modify(Bins)
        {
            Caption = 'Bins';
        }
        modify(Receipt)
        {
            Caption = 'Receipt';
        }
        modify(Shipment)
        {
            Caption = 'Shipment';
        }
        modify(Production)
        {
            Caption = 'Production';
        }
        modify(Adjustment)
        {
            Caption = 'Adjustment';
        }
        modify("Cross-Dock")
        {
            Caption = 'Cross-Dock';
        }
        modify(Assembly)
        {
            Caption = 'Assembly';
        }
        modify("Bin Policies")
        {
            Caption = 'Bin Policies';
        }
        modify("Put-away")
        {
            Caption = 'Put-away';
        }
        modify(Pick)
        {
            Caption = 'Pick';
        }
        modify(Numbering)
        {
            Caption = 'Numbering';
        }
        modify(GST)
        {
            Caption = 'GST';
        }
        modify("Tax Information")
        {
            Caption = 'Tax Information';
        }
        modify("T.C.A.N. No.")
        {
            Caption = 'T.C.A.N. No.';
        }
        modify(Control1500004)
        {
            Caption = 'GST';
        }
        addafter("Service Tax Registration No.")
        {
            field("MSME No."; "MSME No.")
            {
            }
        }
        addafter("Bonded warehouse")
        {
            field("Cleartax Owner ID"; "Cleartax Owner ID")
            {
            }
        }
    }
    actions
    {
        modify("&Location")
        {
            Caption = '&Location';
        }
        modify("&Resource Locations")
        {
            Caption = '&Resource Locations';
        }
        modify("&Zones")
        {
            Caption = '&Zones';
        }
        modify("&Bins")
        {
            Caption = '&Bins';
        }
        modify("Voucher No. Series")
        {
            Caption = 'Voucher No. Series';
        }
        modify("Online Map")
        {
            Caption = 'Online Map';
        }
    }

    //Unsupported feature: Property Deletion (CaptionML).

}

