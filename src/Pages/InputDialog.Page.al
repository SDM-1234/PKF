page 50022 InputDialog
{
    ApplicationArea = All;
    Caption = 'InputDialog';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field("New Posting Date"; Postindate)
            {
                ApplicationArea = All;
                ToolTip = 'Enter the new posting date.';
                Importance = Promoted;
                Editable = true;
                ShowMandatory = true;
            }
        }
    }

    procedure GetUserPostingdateInput(): Date
    begin
        exit(Postindate);
    end;

    var
        Postindate: Date;
}
