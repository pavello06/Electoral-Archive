Unit PartyUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    CandidateListUnit, PartyListUnit, Vcl.Menus, Vcl.ExtDlgs;

Type
    TPartyForm = Class(TForm)
        MainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        SaveMenuItem: TMenuItem;
        SaveTextFileDialog: TSaveTextFileDialog;

        ContentEdit: TEdit;
        PartyStringGrid: TStringGrid;

        Procedure CreateParams(Var Params: TCreateParams); Override;
        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure CreateBulletinForm();
        Procedure CreatePartyForm();
        Procedure FormShow(Sender: TObject);

        Procedure SaveMenuItemClick(Sender: TObject);

        Procedure PartyStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    PartyForm: TPartyForm;

Implementation

{$R *.dfm}

Uses
    MenuUnit, SearchUnit;

Procedure TPartyForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Function TPartyForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TPartyForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;


Procedure TPartyForm.CreateBulletinForm();
Begin
    PartyForm.Caption := '���������';
    With PartyStringGrid Do
    Begin
        ColCount := 4;
        DefaultColWidth := 211;
        Cells[0, 0] := '������';
        Cells[1, 0] := '���������';
        Cells[2, 0] := '�������';
        Cells[3, 0] := '���������';
        FillBulletinStringGrid(CandidateList, PartyStringGrid);
    End;
End;

Procedure TPartyForm.CreatePartyForm();
Begin
    PartyForm.Caption := '������ ' + String(PartyName);
    With PartyStringGrid Do
    Begin
        ColCount := 6;
        DefaultColWidth := 140;
        Cells[0, 0] := '� ������';
        Cells[1, 0] := '�������';
        Cells[2, 0] := '���';
        Cells[3, 0] := '��������';
        Cells[4, 0] := '�������';
        Cells[5, 0] := '���������';
        FillPartyStringGrid(CandidateList, PartyStringGrid, PartyName);
    End;
End;

Procedure TPartyForm.FormShow(Sender: TObject);
Begin
    If StateForm = Bulletin Then
        CreateBulletinForm()
    Else
        CreatePartyForm();
End;


procedure TPartyForm.SaveMenuItemClick(Sender: TObject);
Var
    OutputFile: TextFile;
    Row: Integer;
Begin
    If SaveTextFileDialog.Execute Then
    Begin
        AssignFile(OutputFile, SaveTextFileDialog.FileName);
        Rewrite(OutputFile);
        If PartyStringGrid.ColCount = 4 Then
            For Row := 0 To PartyStringGrid.RowCount - 1 Do
                WriteLn(OutputFile, Format('%-40s %-9s %-7s %-30s', [PartyStringGrid.Cells[0, Row], PartyStringGrid.Cells[1, Row], PartyStringGrid.Cells[2, Row], PartyStringGrid.Cells[3, Row]]))
        Else
            For Row := 0 To PartyStringGrid.RowCount - 1 Do
                WriteLn(OutputFile, Format('%-8s %-30s %-30s %-30s %-7s %-30s', [PartyStringGrid.Cells[0, Row], PartyStringGrid.Cells[1, Row], PartyStringGrid.Cells[2, Row], PartyStringGrid.Cells[3, Row], PartyStringGrid.Cells[4, Row], PartyStringGrid.Cells[5, Row]]));
        CloseFile(OutputFile);
    End;
end;


Procedure TPartyForm.PartyStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);
Begin
    If ARow > 0 Then
        ContentEdit.Text := PartyStringGrid.Cells[ACol, ARow]
    Else
        ContentEdit.Text := '';
End;

End.
