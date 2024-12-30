page 50008 "Beneficiary List"
{
    PageType = List;
    SourceTable = Beneficiary;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Beneficiary Code"; Rec."Beneficiary Code")
                {
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                }
                field("Beneficiary A/C No."; Rec."Beneficiary A/C No.")
                {
                }
                field("Beneficiary Bank Name"; Rec."Beneficiary Bank Name")
                {
                }
                field("Beneficiary IFS Code"; Rec."Beneficiary IFS Code")
                {
                }
                field("Beneficiary Branch Address"; Rec."Beneficiary Branch Address")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000009; Outlook)
            {
            }
            systempart(Control1000000010; Notes)
            {
            }
            systempart(Control1000000011; Links)
            {
            }
        }
    }

    actions
    {
    }
}

