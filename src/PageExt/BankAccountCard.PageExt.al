
/// <summary>
/// PageExtension BankAccountCard (ID 50010) extends Record Bank Account Card.
/// </summary>
pageextension 50010 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        addafter(General)
        {
            group(AddionalInfo)
            {
                Caption = 'Additioanl Information';

                field("AUDIT Hide"; Rec."AUDIT Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AUDIT Hide field.', Comment = '%';
                }
                field("BLR Hide"; Rec."BLR Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BLR Hide field.', Comment = '%';
                }
                field("CHN FO Hide"; Rec."CHN FO Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CHN FO Hide field.', Comment = '%';
                }
                field("DEL Hide"; Rec."DEL Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DEL Hide field.', Comment = '%';
                }
                field("HYD Hide"; Rec."HYD Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HYD Hide field.', Comment = '%';
                }
                field("Invoice Hide"; Rec."Invoice Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Hide field.', Comment = '%';
                }
                field("MUM Hide"; Rec."MUM Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MUM Hide field.', Comment = '%';
                }
                field("Normal User Hide"; Rec."Normal User Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Normal User Hide field.', Comment = '%';
                }
                field("Super User Hide"; Rec."Super User Hide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Super User Hide field.', Comment = '%';
                }
            }
        }
    }
}
