Unit MenuUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
    Vcl.ExtCtrls,
    ViewCandidateListUnit, PartyUnit, SearchUnit, CandidateListUnit;

Type
    TStateForm = (Bulletin, Party, Add, Edit);

    TMenuForm = Class(TForm)
        DeveloperImage: TImage;
        CandidateListButton: TButton;
        BulletinButton: TButton;
        SearchPartyButton: TButton;
        InfoImage: TImage;

        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        Procedure FormDestroy(Sender: TObject);

        Procedure DeveloperImageClick(Sender: TObject);
        Procedure InfoImageClick(Sender: TObject);

        Procedure CandidateListButtonClick(Sender: TObject);
        Procedure BulletinButtonClick(Sender: TObject);
        Procedure SearchPartyButtonClick(Sender: TObject);

        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MenuForm: TMenuForm;
    CandidateList: PCandidate = Nil;
    IsSaved: Boolean = True;
    StateForm: TStateForm;

Implementation

{$R *.dfm}

Function TMenuForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TMenuForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_F1 Then
        InfoImageClick(InfoImage);
End;

Procedure TMenuForm.FormDestroy(Sender: TObject);
Begin
    ClearCandidates(CandidateList);
End;


Procedure CreateModalForm(CaptionText, LabelText: String; ModalWidth, ModalHeight: Integer);
Var
    ModalForm: TForm;
    ModalLabel: TLabel;
Begin
    ModalForm := TForm.Create(Nil);
    Try
        ModalForm.BorderIcons := [BiSystemMenu];
        ModalForm.BorderStyle := BsSingle;
        ModalForm.Caption := CaptionText;
        ModalForm.Height := ModalHeight;
        ModalForm.Icon := MenuForm.Icon;
        ModalForm.Position := PoScreenCenter;
        ModalForm.Width := ModalWidth;
        ModalForm.OnHelp := MenuForm.FormHelp;

        ModalLabel := TLabel.Create(ModalForm);
        ModalLabel.Caption := LabelText;
        ModalLabel.Font.Size := 12;
        ModalLabel.Left := (ModalForm.ClientWidth - ModalLabel.Width) Div 2;
        ModalLabel.Parent := ModalForm;
        ModalLabel.Top := (ModalForm.ClientHeight - ModalLabel.Height) Div 2;

        ModalForm.ShowModal;
    Finally
        ModalForm.Free;
    End;
End;

Procedure TMenuForm.DeveloperImageClick(Sender: TObject);
Begin
    CreateModalForm('� ������������', '������: 351005'#13#10 +
                                      '�����������: ������ ����� �������������'#13#10 +
                                      '���������: @pavello06', 500, 150);
End;

Procedure TMenuForm.InfoImageClick(Sender: TObject);
Begin
    CreateModalForm('����������',
                    '������ ����������:'#13#10 +
                    '1. ��� ���������� ��������� ������� ������ "��������" ��� ������� ������� Ins.'#13#10 +
                    '2. ��� ��������� ��������� ������� ������ "��������" ��� ������� ������ �� ������������ ���.'#13#10 +
                    '3. ��� �������� ��������� ������� ������ "�������" ��� ������� ������� Del.'#13#10 +
                    '4. ��� ��������� ��������� ��� ����� ���� ���������� �� ����.'#13#10#13#10 +
                    '�����:'#13#10 +
                    '1. ���� ����� ���������� .ea'#13#10#13#10 +
                    '�����:'#13#10 +
                    '��� ������������� ������ ������� �������� ������ � ������� ������ "�����".'#13#10#13#10 +
                    '�������� �� ������� ������� Windows.',
                     1000, 450);
End;


Procedure CreateForm(FormClass: TFormClass);
Var
    Form: TForm;
Begin
    MenuForm.Visible := False;
    Form := FormClass.Create(MenuForm);
    Form.Icon := MenuForm.Icon;
    Form.ShowModal;
    MenuForm.Visible := True;
End;

Procedure TMenuForm.CandidateListButtonClick(Sender: TObject);
Begin
    CreateForm(TViewCandidateListForm);
End;

Procedure TMenuForm.BulletinButtonClick(Sender: TObject);
Begin
    If CandidateList = Nil Then
        Application.MessageBox('�� ��� �� �������� ����������!', '��������������', MB_OK + MB_ICONWARNING)
    Else
    Begin
        StateForm := Bulletin;
        CreateForm(TPartyForm);
    End;
End;

Procedure TMenuForm.SearchPartyButtonClick(Sender: TObject);
Begin
    If CandidateList = Nil Then
        Application.MessageBox('�� ��� �� �������� ����������!', '��������������', MB_OK + MB_ICONWARNING)
    Else
    Begin
        StateForm := Party;
        CreateForm(TSearchForm);
    End;
End;


Procedure TMenuForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var
    Confirmation: Integer;
Begin
    If IsSaved Then
    Begin
        Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        CanClose := Confirmation = IDYES;
    End
    Else
    Begin
        Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ��������� ����?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
        Case Confirmation Of
            mrYes:
            Begin
                ViewCandidateListForm.SaveMenuItemClick(Sender);
                CanClose := IsSaved;
            End;
            mrNo:
                CanClose := True;
            mrCancel:
                CanClose := False;
        End;
    End;
End;

End.
