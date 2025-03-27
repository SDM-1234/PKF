pageextension 50014 CurrenciesPageExtPkf extends Currencies
{
    layout
    {
        addlast(Control1)
        {
            field("Currency Numeric Description"; Rec."Currency Numeric Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Numeric Description field.';
            }
            field("Currency Decimal Description"; Rec."Currency Decimal Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Decimal Description field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}