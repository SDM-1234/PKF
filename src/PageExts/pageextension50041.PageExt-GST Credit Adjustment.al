pageextension 50041 pageextension50041 extends "GST Credit Adjustment"
{
    layout
    {
        modify(AdjDocNo)
        {
            Caption = 'Adjustment  Document No.';
        }
        modify(GSTINNo)
        {
            Caption = 'GST Registration No.';
        }
        modify(PostingDate)
        {
            Caption = 'Posting Date';
        }
        modify(DocumentNo)
        {
            Caption = 'Document No.';
        }
    }
    actions
    {
        modify(ApplyEntries)
        {
            Caption = '&Apply Entries';
        }
    }

    //Unsupported feature: Property Modification (TextConstString) on "PostingDateErr(Variable 1500022)".

    //var
    //>>>> ORIGINAL VALUE:
    //PostingDateErr : ENU=Posting Date must not be blank.;ENN=Posting Date must not be blank.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostingDateErr : ENU=Posting Date must not be blank.;ENN=Adj. Document No. must not be blank.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "MonthFormatErr(Variable 1500019)".

    //var
    //>>>> ORIGINAL VALUE:
    //MonthFormatErr : ENU=Month must be within 1 to 12.;ENN=Month must be within 1 to 12.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MonthFormatErr : ENU=Month must be within 1 to 12.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "AdjDocErr(Variable 1500021)".

    //var
    //>>>> ORIGINAL VALUE:
    //AdjDocErr : ENU=Adjust Document No. must not be empty.;ENN=Adjust Document No. must not be empty.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AdjDocErr : ENU=Adjust Document No. must not be empty.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "NatureOfAdjErr(Variable 1500029)".

    //var
    //>>>> ORIGINAL VALUE:
    //NatureOfAdjErr : ENU=Nature of Adjustment can not be blank.;ENN=Nature of Adjustment can not be blank.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NatureOfAdjErr : ENU=Nature of Adjustment can not be blank.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "AdjPeriodErr(Variable 1500030)".

    //var
    //>>>> ORIGINAL VALUE:
    //AdjPeriodErr : ENU=Posting Date must be after Period Month & Period Year.;ENN=Posting Date must be after Period Month & Period Year.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AdjPeriodErr : ENU=Posting Date must be after Period Month & Period Year.;
    //Variable type has not been exported.

    //Unsupported feature: Property Deletion (CaptionML).

}

