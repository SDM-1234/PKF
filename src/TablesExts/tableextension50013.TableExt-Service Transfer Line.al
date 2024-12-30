tableextension 50013 tableextension50013 extends "Service Transfer Line"
{
    fields
    {

        //Unsupported feature: Property Deletion (CaptionML) on ""Document No."(Field 1)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Line No."(Field 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer From G/L Account No."(Field 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer To G/L Account No."(Field 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer Price"(Field 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship Control A/C No."(Field 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Receive Control A/C No."(Field 7)".


        //Unsupported feature: Property Deletion (CaptionML) on "Shipped(Field 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Shortcut Dimension 1 Code"(Field 9)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Shortcut Dimension 2 Code"(Field 10)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Group Code"(Field 11)".


        //Unsupported feature: Property Deletion (CaptionML) on ""SAC Code"(Field 12)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Base Amount"(Field 13)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST %"(Field 14)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Total GST Amount"(Field 15)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Rounding Type"(Field 16)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""GST Rounding Type"(Field 16)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Rounding Precision"(Field 17)".


        //Unsupported feature: Property Deletion (CaptionML) on ""From G/L Account Description"(Field 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""To G/L Account Description"(Field 19)".


        //Unsupported feature: Property Deletion (CaptionML) on "Exempted(Field 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Dimension Set ID"(Field 480)".

    }

    //Unsupported feature: Property Deletion (CaptionML).


    //Unsupported feature: Property Modification (TextConstString) on "DimChangeQst(Variable 1500004)".

    //var
    //>>>> ORIGINAL VALUE:
    //DimChangeQst : @@@="%1 = Document No";ENU=You have changed one or more dimensions on the %1, which is already shipped.\\Do you want to keep the changed dimension?;ENN=You have changed one or more dimensions on the %1, which is already shipped.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DimChangeQst : @@@="%1 = Document No";ENU=You have changed one or more dimensions on the %1, which is already shipped.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "CancellErr(Variable 1500003)".

    //var
    //>>>> ORIGINAL VALUE:
    //CancellErr : ENU=Cancelled.;ENN=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CancellErr : ENU=Cancelled.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "RenameErr(Variable 1500005)".

    //var
    //>>>> ORIGINAL VALUE:
    //RenameErr : @@@="%1 = Table Name";ENU=You cannot rename a %1.;ENN=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameErr : @@@="%1 = Table Name";ENU=You cannot rename a %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "TransPriceErr(Variable 1500010)".

    //var
    //>>>> ORIGINAL VALUE:
    //TransPriceErr : ENU=Transfer Price can not be Negative.;ENN=Transfer Price can not be Negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransPriceErr : ENU=Transfer Price can not be Negative.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "GSTGroupReverseChargeErr(Variable 1500012)".

    //var
    //>>>> ORIGINAL VALUE:
    //GSTGroupReverseChargeErr : @@@="%1 = GST Group Code";ENU=GST Group Code %1 with Reverse Charge cannot be selected for Service Transfers.;ENN=GST Group Code %1 with Reverse Charge cannot be selected for Service Transfers.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GSTGroupReverseChargeErr : @@@="%1 = GST Group Code";ENU=GST Group Code %1 with Reverse Charge cannot be selected for Service Transfers.;
    //Variable type has not been exported.
}

