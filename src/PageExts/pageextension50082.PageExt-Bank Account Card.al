pageextension 50082 pageextension50082 extends "Bank Account Card"
{
    layout
    {
        modify("Bank Acc. Posting Group")
        {
            Editable = false;
        }
        addafter(General)
        {
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Normal User Hide"; "Normal User Hide")
                {
                }
                field("Super User Hide"; "Super User Hide")
                {
                }
                field("BLR Hide"; "BLR Hide")
                {
                }
                field("HYD Hide"; "HYD Hide")
                {
                }
                field("AUDIT Hide"; "AUDIT Hide")
                {
                }
                field("DEL Hide"; "DEL Hide")
                {
                }
                field("MUM Hide"; "MUM Hide")
                {
                }
                field("CHN FO Hide"; "CHN FO Hide")
                {
                }
                field("Invoice Hide"; "Invoice Hide")
                {
                }
            }
        }
    }
}

