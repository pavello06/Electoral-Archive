Unit ModifyCandidateUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
    CandidateListUnit, PositiveNumberComponentUnit, NameComponentUnit;

Type
    TModifyCandidateForm = Class(TForm)
        TitleLabel: TLabel;

        DistrictNumberLabel: TLabel;
        DistrictNumberEdit: TEdit;
        LastNameLabel: TLabel;
        LastNameEdit: TEdit;
        FirstNameLabel: TLabel;
        FirstNameEdit: TEdit;
        PatronymicLabel: TLabel;
        PatronymicEdit: TEdit;
        PartyLabel: TLabel;
        PartyEdit: TEdit;
        AgeLabel: TLabel;
        AgeEdit: TEdit;
        ProfessionLabel: TLabel;
        ProfessionEdit: TEdit;
        ModifyButton: TButton;
        CancelButton: TButton;

        Procedure CreateParams(Var Params: TCreateParams); override;
        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure FormShow(Sender: TObject);

        Procedure EditChange(Sender: TObject);
        Procedure ControlKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure PositiveNumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure PositiveNumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure PositiveNumberEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure PositiveNumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure NameEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure NameEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure NameEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure NameEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure ModifyButtonClick(Sender: TObject);
        Procedure CancelButtonClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    ModifyCandidateForm: TModifyCandidateForm;

Implementation

{$R *.dfm}

Uses
    MenuUnit, ViewCandidateListUnit;

Procedure SetCandidateData(OldCandidateData: TCandidateData);
Begin
    With ModifyCandidateForm, OldCandidateData Do
    Begin
        DistrictNumberEdit.Text := IntToStr(DistrictNumber);
        LastNameEdit.Text := String(LastName);
        FirstNameEdit.Text := String(FirstName);
        PatronymicEdit.Text := String(Patronymic);
        PartyEdit.Text := String(Party);
        AgeEdit.Text := IntToStr(Age);
        ProfessionEdit.Text := String(Profession);
    End;
End;

Function GetCandidateData(): TCandidateData;
Var
    NewCandidateData: TCandidateData;
Begin
    With NewCandidateData, ModifyCandidateForm Do
    Begin
        DistrictNumber := StrToInt(DistrictNumberEdit.Text);
        LastName := TName(Trim(LastNameEdit.Text));
        FirstName := TName(Trim(FirstNameEdit.Text));
        Patronymic := TName(Trim(PatronymicEdit.Text));
        Party := TPartyName(Trim(PartyEdit.Text));
        Age := StrToInt(AgeEdit.Text);
        Profession := TProfessionName(Trim(ProfessionEdit.Text));
    End;
    GetCandidateData := NewCandidateData;
End;


Procedure TModifyCandidateForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Function TModifyCandidateForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TModifyCandidateForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TModifyCandidateForm.FormShow(Sender: TObject);
Begin
    TitleLabel.Left := (ClientWidth - TitleLabel.Width) Div 2;
    If StateForm = Edit Then
        SetCandidateData(OldCandidateData);
End;


Function IsFullFields(): Boolean;
Begin
    With ModifyCandidateForm Do
        IsFullFields := (Trim(DistrictNumberEdit.Text) <> '') And
                        (Trim(LastNameEdit.Text) <> '') And
                        (Trim(FirstNameEdit.Text) <> '') And
                        (Trim(PartyEdit.Text) <> '') And
                        (Trim(AgeEdit.Text) <> '') And
                        (Trim(ProfessionEdit.Text) <> '');
End;

Procedure TModifyCandidateForm.EditChange(Sender: TObject);
Var
    NewCandidateData: TCandidateData;
Begin
    ModifyButton.Enabled := False;
    If IsFullFields() Then
    Begin
        NewCandidateData := GetCandidateData();
        ModifyButton.Enabled := Not IsExistCandidate(CandidateList, NewCandidateData);
    End;
End;

Procedure TModifyCandidateForm.ControlKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_UP Then
        SelectNext(TWinControl(Sender), False, True)
    Else If Key = VK_DOWN Then
        SelectNext(TWinControl(Sender), True, True)
    Else If (Key = Ord(ENTER)) And (ModifyButton.Enabled) Then
        ModifyButtonClick(ModifyButton);
End;


Procedure TModifyCandidateForm.PositiveNumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If Edit = DistrictNumberEdit Then
        Max := MAX_DISTRICT_NUMBER
    Else
        Max := MAX_AGE;
    PositiveNumberComponentContextPopup(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Handled);
End;

Procedure TModifyCandidateForm.PositiveNumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If Edit = DistrictNumberEdit Then
        Max := MAX_DISTRICT_NUMBER
    Else
        Max := MAX_AGE;
    PositiveNumberComponentKeyDown(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Key, Shift);
    ControlKeyDown(Sender, Key, Shift);
End;

Procedure TModifyCandidateForm.PositiveNumberEditKeyPress(Sender: TObject; Var Key: Char);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If Edit = DistrictNumberEdit Then
        Max := MAX_DISTRICT_NUMBER
    Else
        Max := MAX_AGE;
    PositiveNumberComponentKeyPress(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Key);
End;

Procedure TModifyCandidateForm.PositiveNumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    PositiveNumberComponentKeyUp();
End;


Procedure TModifyCandidateForm.NameEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If (Edit = LastNameEdit) Or (Edit = FirstNameEdit) Or (Edit = PatronymicEdit) Then
        Max := MAX_NAME_LENGTH
    Else If (Edit = PartyEdit) Then
        Max := MAX_PARTY_NAME_LENGTH
    Else
        Max := MAX_PROFESSION_NAME_LENGTH;
    NameComponentContextPopup(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Handled);
End;

Procedure TModifyCandidateForm.NameEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If (Edit = LastNameEdit) Or (Edit = FirstNameEdit) Or (Edit = PatronymicEdit) Then
        Max := MAX_NAME_LENGTH
    Else If (Edit = PartyEdit) Then
        Max := MAX_PARTY_NAME_LENGTH
    Else
        Max := MAX_PROFESSION_NAME_LENGTH;
    NameComponentKeyDown(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Key, Shift);
    ControlKeyDown(Sender, Key, Shift);
End;

Procedure TModifyCandidateForm.NameEditKeyPress(Sender: TObject; Var Key: Char);
Var
    Edit: TEdit;
    Max: Integer;
Begin
    Edit := TEdit(Sender);
    If (Edit = LastNameEdit) Or (Edit = FirstNameEdit) Or (Edit = PatronymicEdit) Then
        Max := MAX_NAME_LENGTH
    Else If (Edit = PartyEdit) Then
        Max := MAX_PARTY_NAME_LENGTH
    Else
        Max := MAX_PROFESSION_NAME_LENGTH;
    NameComponentKeyPress(Edit.Text, Edit.SelStart, Edit.SelLength, Max, Key);
End;

Procedure TModifyCandidateForm.NameEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    NameComponentKeyUp();
End;


Procedure TModifyCandidateForm.ModifyButtonClick(Sender: TObject);
Var
    NewCandidateData: TCandidateData;
Begin
    NewCandidateData := GetCandidateData();
    If StateForm = Add Then
        AddCandidate(CandidateList, NewCandidateData)
    Else
        EditCandidate(CandidateList, OldCandidateData, NewCandidateData);
    IsModified := True;
    Close;
End;

Procedure TModifyCandidateForm.CancelButtonClick(Sender: TObject);
Begin
    Close;
End;

End.
