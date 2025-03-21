
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
                }
                field("BLR Hide"; Rec."BLR Hide")
                {
                    ApplicationArea = All;
                }
                field("CHN FO Hide"; Rec."CHN FO Hide")
                {
                    ApplicationArea = All;
                }
                field("DEL Hide"; Rec."DEL Hide")
                {
                    ApplicationArea = All;
                }
                field("HYD Hide"; Rec."HYD Hide")
                {
                    ApplicationArea = All;
                }
                field("Invoice Hide"; Rec."Invoice Hide")
                {
                    ApplicationArea = All;
                }
                field("MUM Hide"; Rec."MUM Hide")
                {
                    ApplicationArea = All;
                }
                field("Normal User Hide"; Rec."Normal User Hide")
                {
                    ApplicationArea = All;
                }
                field("Super User Hide"; Rec."Super User Hide")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
