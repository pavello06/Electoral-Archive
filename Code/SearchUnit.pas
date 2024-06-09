Unit SearchUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    CandidateListUnit, PartyUnit, NameComponentUnit;

Type
    TSearchForm = Class(TForm)
        TitleLabel: TLabel;
        SearchEdit: TEdit;
        SearchButton: TButton;

        Procedure CreateParams(Var Params: TCreateParams); override;
        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure SearchEditChange(Sender: TObject);
        Procedure SearchEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure SearchEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure SearchEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure SearchEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure SearchButtonClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    SearchForm: TSearchForm;
    PartyName: TPartyName;

Implementation

{$R *.dfm}

Uses
    MenuUnit;

Procedure TSearchForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Function TSearchForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TSearchForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;


Procedure TSearchForm.SearchEditChange(Sender: TObject);
Begin
    PartyName := TPartyName(Trim(SearchEdit.Text));
    SearchButton.Enabled := Trim(SearchEdit.Text) <> '';
End;

Procedure TSearchForm.SearchEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    NameComponentContextPopup(SearchEdit.Text, SearchEdit.SelStart, SearchEdit.SelLength, MAX_PARTY_NAME_LENGTH, Handled);
End;

Procedure TSearchForm.SearchEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    NameComponentKeyDown(SearchEdit.Text, SearchEdit.SelStart, SearchEdit.SelLength, MAX_PARTY_NAME_LENGTH, Key, Shift);
End;

Procedure TSearchForm.SearchEditKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Key = ENTER Then
        SearchButtonClick(SearchButton)
    Else
        NameComponentKeyPress(SearchEdit.Text, SearchEdit.SelStart, SearchEdit.SelLength, MAX_PARTY_NAME_LENGTH, Key);
End;

Procedure TSearchForm.SearchEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    NameComponentKeyUp();
End;


Procedure TSearchForm.SearchButtonClick(Sender: TObject);
Begin
    If IsExistParty(CandidateList, PartyName) Then
    Begin
        PartyForm := TPartyForm.Create(Self);
        PartyForm.Icon := SearchForm.Icon;
        PartyForm.ShowModal;
    End
    Else
        Application.MessageBox('Такой партии не найдено!', 'Предупреждение', MB_OK + MB_ICONWARNING)
End;

End.
