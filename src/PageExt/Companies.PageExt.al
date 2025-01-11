pageextension 50080 Companies extends Companies
{

    //Unsupported feature: Property Insertion (InsertAllowed) on "Companies(Page 357)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on "Companies(Page 357)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on "Companies(Page 357)".

    layout
    {
        modify("Display Name")
        {
            HideValue = false;
        }
        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(CopyCompany)
        {
            Enabled = true;
        }
    }
}

