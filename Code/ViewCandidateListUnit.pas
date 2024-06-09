Unit ViewCandidateListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Grids,
    Vcl.ExtDlgs,
    ModifyCandidateUnit, CandidateListUnit, FileUnit;

Type
    TViewCandidateListForm = Class(TForm)
        MainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        OpenMenuItem: TMenuItem;
        SaveMenuItem: TMenuItem;

        OpenTextFileDialog: TOpenTextFileDialog;
        SaveTextFileDialog: TSaveTextFileDialog;

        AddButton: TButton;
        EditButton: TButton;
        DeleteButton: TButton;
        ContentEdit: TEdit;
        CandidateListStringGrid: TStringGrid;

        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormShow(Sender: TObject);

        Procedure OpenMenuItemClick(Sender: TObject);
        Procedure SaveMenuItemClick(Sender: TObject);

        Procedure AddButtonClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure EditButtonClick(Sender: TObject);
        Procedure CandidateListStringGridDblClick(Sender: TObject);
        Procedure DeleteButtonClick(Sender: TObject);
        Procedure CandidateListStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure CandidateListStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    ViewCandidateListForm: TViewCandidateListForm;
    OldCandidateData: TCandidateData;
    IsModified: Boolean = False;

Implementation

{$R *.dfm}

Uses
    MenuUnit;

Procedure TViewCandidateListForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Procedure TViewCandidateListForm.FormCreate(Sender: TObject);
Begin
    With CandidateListStringGrid Do
    Begin
        Cells[0, 0] := '№ округа';
        Cells[1, 0] := 'Фамилия';
        Cells[2, 0] := 'Имя';
        Cells[3, 0] := 'Отчество';
        Cells[4, 0] := 'Партия';
        Cells[5, 0] := 'Возраст';
        Cells[6, 0] := 'Профессия';
    End;
End;

Function TViewCandidateListForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TViewCandidateListForm.FormShow(Sender: TObject);
Var
    CandidateCount: Integer;
Begin
    CandidateCount := CountCandidates(CandidateList);
    CandidateListStringGrid.RowCount := CountCandidates(CandidateList) + 1;
    SaveMenuItem.Enabled := CandidateCount > 0;
    FillCandidateListStringGrid(CandidateList, CandidateListStringGrid);
End;


Procedure TViewCandidateListForm.OpenMenuItemClick(Sender: TObject);
Var
    InputFile: TCandidateDataFile;
    TempCandidateList: PCandidate;
    IsCorrect: Boolean;
Begin
    If OpenTextFileDialog.Execute Then
    Begin
        AssignFile(InputFile, OpenTextFileDialog.FileName);
        TempCandidateList := Nil;
        IsCorrect := ReadFileData(InputFile, TempCandidateList);
        If IsCorrect Then
        Begin
            ClearCandidates(CandidateList);
            RecordFileData(CandidateList, TempCandidateList, CandidateListStringGrid);
            IsSaved := True;
            SaveMenuItem.Enabled := True;
        End
        Else
        Begin
            ClearCandidates(TempCandidateList);
            Application.MessageBox('Содержимое файла повреждено!', 'Ошибка', MB_OK + MB_ICONERROR);
        End;
    End;
End;

Procedure TViewCandidateListForm.SaveMenuItemClick(Sender: TObject);
Var
    OutputFile: TCandidateDataFile;
Begin
    If SaveTextFileDialog.Execute Then
    Begin
        AssignFile(OutputFile, SaveTextFileDialog.FileName);
        WriteFileData(OutputFile, CandidateList);
        IsSaved := True;
    End;
End;


Function GetCandidateData(CandidateListStringGrid: TStringGrid): TCandidateData;
Var
    OldCandidateData: TCandidateData;
Begin
    With OldCandidateData, CandidateListStringGrid Do
    Begin
        DistrictNumber := StrToInt(Cells[0, Row]);
        LastName := TName(Cells[1, Row]);
        FirstName := TName(Cells[2, Row]);
        Patronymic := TName(Cells[3, Row]);
        Party := TPartyName(Cells[4, Row]);
        Age := StrToInt(Cells[5, Row]);
        Profession := TProfessionName(Cells[6, Row]);
    End;
    GetCandidateData := OldCandidateData;
End;


Procedure CreateModifyForm(Const TitleLabelCaption, ModifyButtonCaption: String);
Begin
    ModifyCandidateForm := TModifyCandidateForm.Create(ViewCandidateListForm);
    ModifyCandidateForm.Icon := ViewCandidateListForm.Icon;
    ModifyCandidateForm.TitleLabel.Caption := TitleLabelCaption;
    ModifyCandidateForm.ModifyButton.Caption := ModifyButtonCaption;
    ModifyCandidateForm.ShowModal;
End;


Procedure TViewCandidateListForm.AddButtonClick(Sender: TObject);
Begin
    If CountCandidates(CandidateList) < MAX_CANDIDATE_COUNT Then
    Begin
        StateForm := Add;
        CreateModifyForm('Добавление кандидата', 'Добавить');
        If IsModified Then
        Begin
            CandidateListStringGrid.RowCount := CandidateListStringGrid.RowCount + 1;
            FillCandidateListStringGrid(CandidateList, CandidateListStringGrid);
            IsModified := False;
            IsSaved := False;
            SaveMenuItem.Enabled := True;
            ContentEdit.Text := '';
        End;
    End
    Else
        Application.MessageBox(PWideChar('Количество кандидатов не может превышать ' + IntToStr(MAX_CANDIDATE_COUNT) + ' !'), 'Предупреждение', MB_OK + MB_ICONWARNING);
End;

Procedure TViewCandidateListForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_INSERT Then
        AddButtonClick(AddButton)
    Else If Key = VK_ESCAPE Then
        Close;
End;

Procedure TViewCandidateListForm.EditButtonClick(Sender: TObject);
Begin
    If CandidateListStringGrid.Row > 0 Then
    Begin
        StateForm := Edit;
        OldCandidateData := GetCandidateData(CandidateListStringGrid);
        CreateModifyForm('Изменение кандидата', 'Изменить');
        If IsModified Then
        Begin
            FillCandidateListStringGrid(CandidateList, CandidateListStringGrid);
            IsModified := False;
            IsSaved := False;
            SaveMenuItem.Enabled := True;
            ContentEdit.Text := '';
        End;
    End
    Else
        Application.MessageBox('Не выбрано редактируемое поле!', 'Предупреждение', MB_OK + MB_ICONWARNING);
End;

Procedure TViewCandidateListForm.CandidateListStringGridDblClick (Sender: TObject);
Begin
    EditButtonClick(EditButton);
End;

Procedure TViewCandidateListForm.DeleteButtonClick(Sender: TObject);
Var
    Confirmation, CandidateCount: Integer;
Begin
    If CandidateListStringGrid.Row > 0 Then
    Begin
        Confirmation := Application.MessageBox('Вы действительно хотите удалить кандидата?', 'Удаление кандидата', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
        Begin
            DeleteCandidate(CandidateList, GetCandidateData(CandidateListStringGrid));
            CandidateListStringGrid.RowCount := CandidateListStringGrid.RowCount - 1;
            FillCandidateListStringGrid(CandidateList, CandidateListStringGrid);
            CandidateCount := CountCandidates(CandidateList);
            IsSaved := CandidateCount = 0;
            SaveMenuItem.Enabled := CandidateCount > 0;
            ContentEdit.Text := '';
        End;
    End
    Else
        Application.MessageBox('Не выбрано редактируемое поле!', 'Предупреждение', MB_OK + MB_ICONWARNING);
End;

Procedure TViewCandidateListForm.CandidateListStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_DELETE Then
        DeleteButtonClick(DeleteButton);
End;


Procedure TViewCandidateListForm.CandidateListStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);
Begin
    If ARow > 0 Then
        ContentEdit.Text := CandidateListStringGrid.Cells[ACol, ARow]
    Else
        ContentEdit.Text := '';
End;

End.
