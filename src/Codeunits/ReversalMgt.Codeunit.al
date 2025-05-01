

codeunit 50008 "Reversal Mgt"
{
    Permissions = TableData "Reversal Entry" = RIMD,
                TableData "G/L Entry" = RIMD,
                TableData "Gen. Journal Line" = RIMD,
                TableData "Cust. Ledger Entry" = RIMD,
                TableData "Vendor Ledger Entry" = RIMD,
                TableData "Employee Ledger Entry" = RIMD,
                TableData "Bank Account Ledger Entry" = RIMD;


    #region Setting up UserInput Posting date
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", OnRunOnAfterConfirm, '', false, false)]
    local procedure "Reversal-Post_OnRunOnAfterConfirm"(var ReversalEntry: Record "Reversal Entry"; var Handled: Boolean; PrintRegister: Boolean; HideDialog: Boolean)
    var
        SingleInstance: Codeunit SingleInstance;
        InputDialogPage: Page InputDialog;
        PostingDate: Date;
    begin
        Clear(InputDialogPage);
        if InputDialogPage.RunModal() = Action::OK then begin
            PostingDate := InputDialogPage.GetUserPostingdateInput();
            if PostingDate = 0D then
                Error('Please enter a valid posting date.');

            SingleInstance.SetPostingdate(PostingDate, ReversalEntry."Document No.");
        end;

    end;

    #endregion Setting up UserInput Posting date

    #region GL Entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseGLEntryOnBeforeInsertGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseGLEntryOnBeforeInsertGLEntry"(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> GLEntry."Document No." then
            exit;
        GLEntry."Posting Date" := PostingDate;
        GenJnlLine."Posting Date" := PostingDate;

    end;
    #endregion GL Entry


    #region Vendor and detailed vendor ledger entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry"(var NewVendLedgEntry: Record "Vendor Ledger Entry"; VendLedgEntry: Record "Vendor Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewVendLedgEntry."Document No." then
            exit;
        NewVendLedgEntry."Posting Date" := PostingDate;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseVendLedgEntryOnBeforeInsertDtldVendLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseVendLedgEntryOnBeforeInsertDtldVendLedgEntry"(var NewDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; var IsHandled: Boolean; NewVendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewDtldVendLedgEntry."Document No." then
            exit;
        NewDtldVendLedgEntry."Posting Date" := PostingDate;
    end;

    #endregion Vendor and detailed vendor ledger entry


    #region customer and detailed custpmer ledger entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry"(var NewCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewCustLedgerEntry."Document No." then
            exit;
        NewCustLedgerEntry."Posting Date" := PostingDate;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeInsertDtldCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseCustLedgEntryOnBeforeInsertDtldCustLedgEntry"(var NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; var IsHandled: Boolean; NewCustLedgerEntry: Record "Cust. Ledger Entry")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewDtldCustLedgEntry."Document No." then
            exit;
        NewDtldCustLedgEntry."Posting Date" := PostingDate;
    end;

    #endregion customer and detailed custpmer ledger entry


    #region Bank Account Ledger Entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseBankAccLedgEntryOnBeforeInsert, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseBankAccLedgEntryOnBeforeInsert"(var NewBankAccLedgEntry: Record "Bank Account Ledger Entry"; BankAccLedgEntry: Record "Bank Account Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewBankAccLedgEntry."Document No." then
            exit;
        NewBankAccLedgEntry."Posting Date" := PostingDate;
    end;

    #endregion Bank Account Ledger Entry


    #region Employee Ledger Entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseEmplLedgEntryOnBeforeInsertEmplLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseEmplLedgEntryOnBeforeInsertEmplLedgEntry"(var NewEmployeeLedgerEntry: Record "Employee Ledger Entry"; EmployeeLedgerEntry: Record "Employee Ledger Entry")
    var
        SingleInstance: Codeunit SingleInstance;
        PostingDate: Date;
        DocumentNo: Code[20];
    begin
        SingleInstance.GetPostingdate(PostingDate, DocumentNo);
        if DocumentNo <> NewEmployeeLedgerEntry."Document No." then
            exit;
        NewEmployeeLedgerEntry."Posting Date" := PostingDate;
    end;

    #endregion Employee Ledger Entry
}
