object PartyForm: TPartyForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1041#1102#1083#1083#1077#1090#1077#1085#1100
  ClientHeight = 367
  ClientWidth = 696
  Color = clBtnFace
  Constraints.MaxHeight = 450
  Constraints.MaxWidth = 708
  Constraints.MinHeight = 430
  Constraints.MinWidth = 708
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 28
  object PartyStringGrid: TStringGrid
    Left = 0
    Top = 51
    Width = 696
    Height = 316
    Align = alBottom
    ColCount = 6
    DefaultColWidth = 112
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedRowDefAlign]
    TabOrder = 0
    OnSelectCell = PartyStringGridSelectCell
    ExplicitTop = 42
    ExplicitWidth = 690
  end
  object ContentEdit: TEdit
    Left = 0
    Top = 8
    Width = 696
    Height = 36
    Hint = #1050#1083#1080#1082#1085#1080#1090#1077' '#1085#1072' '#1103#1095#1077#1081#1082#1091' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1087#1086#1083#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 332
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
    end
  end
  object SaveTextFileDialog: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 332
  end
end
