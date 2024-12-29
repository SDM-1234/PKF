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
                field("Beneficiary Code"; "Beneficiary Code")
                {
                }
                field("Beneficiary Name"; "Beneficiary Name")
                {
                }
                field("Beneficiary A/C No."; "Beneficiary A/C No.")
                {
                }
                field("Beneficiary Bank Name"; "Beneficiary Bank Name")
                {
                }
                field("Beneficiary IFS Code"; "Beneficiary IFS Code")
                {
                }
                field("Beneficiary Branch Address"; "Beneficiary Branch Address")
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

