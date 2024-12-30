tableextension 50014 tableextension50014 extends "Location Distribution"
{
    fields
    {

        //Unsupported feature: Property Deletion (CaptionML) on ""Distribution No."(Field 1)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Component Code"(Field 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""From GST Reg. No."(Field 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Line No."(Field 4)".


        //Unsupported feature: Property Deletion (CaptionML) on "Month(Field 5)".


        //Unsupported feature: Property Deletion (CaptionML) on "Year(Field 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Base Amount"(Field 7)".


        //Unsupported feature: Property Deletion (CaptionML) on ""GST Amount"(Field 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""To GST Reg. No."(Field 9)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Distribution %"(Field 10)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Distribution Amount"(Field 11)".

    }

    //Unsupported feature: Property Deletion (CaptionML).


    //Unsupported feature: Property Modification (TextConstString) on "ToGSTErr(Variable 1500002)".

    //var
    //>>>> ORIGINAL VALUE:
    //ToGSTErr : @@@="%1 = To GST Reg. No., %2 = Distribution No., %3 = GST Component Code";ENU=To GST Reg. No. %1 already exists for Distribution No. %2 Component %3.;ENN=To GST Reg. No. %1 already exists for Distribution No. %2 Component %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ToGSTErr : @@@="%1 = To GST Reg. No., %2 = Distribution No., %3 = GST Component Code";ENU=To GST Reg. No. %1 already exists for Distribution No. %2 Component %3.;ENN=Location Code %1 already exists for Document No. %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SameGSTErr(Variable 1500003)".

    //var
    //>>>> ORIGINAL VALUE:
    //SameGSTErr : ENU=GST Registration No. and To GST Reg. No. cannot be same.;ENN=GST Registration No. and To GST Reg. No. cannot be same.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SameGSTErr : ENU=GST Registration No. and To GST Reg. No. cannot be same.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DistributionPercentErr(Variable 1500004)".

    //var
    //>>>> ORIGINAL VALUE:
    //DistributionPercentErr : @@@="%1 = Field Name";ENU=%1 must be in between 0 and 100.;ENN=%1 must be in between 0 and 100.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DistributionPercentErr : @@@="%1 = Field Name";ENU=%1 must be in between 0 and 100.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DistrPerErr(Variable 1500006)".

    //var
    //>>>> ORIGINAL VALUE:
    //DistrPerErr : @@@="%1 = Distribution No., %2 = Component Code";ENU=%1 cannot be more than 100 for Distribution %1 Component %2.;ENN=%1 cannot be more than 100 for Distribution %1 Component %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DistrPerErr : @@@="%1 = Distribution No., %2 = Component Code";ENU=%1 cannot be more than 100 for Distribution %1 Component %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "GSTRegNoErr(Variable 1500009)".

    //var
    //>>>> ORIGINAL VALUE:
    //GSTRegNoErr : ENU=To GST Reg. No. must be same.;ENN=To GST Reg. No. must be same.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GSTRegNoErr : ENU=To GST Reg. No. must be same.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DistrErr(Variable 1500010)".

    //var
    //>>>> ORIGINAL VALUE:
    //DistrErr : ENU=Distribution % must be same.;ENN=Distribution % must be same.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DistrErr : ENU=Distribution % must be same.;
    //Variable type has not been exported.
}

