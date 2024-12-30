pageextension 50099 pageextension50099 extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Allow Document Deletion Before")
        {
            field("RCM Exempt Start Date (Unreg)"; "RCM Exempt Start Date (Unreg)")
            {
            }
            field("RCM Exempt End Date (Unreg)"; "RCM Exempt End Date (Unreg)")
            {
            }
        }
    }
}

