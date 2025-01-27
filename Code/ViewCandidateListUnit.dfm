object ViewCandidateListForm: TViewCandidateListForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
  ClientHeight = 515
  ClientWidth = 883
  Color = clBtnFace
  Constraints.MaxHeight = 578
  Constraints.MaxWidth = 895
  Constraints.MinHeight = 578
  Constraints.MinWidth = 895
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 28
  object AddButton: TButton
    Left = 24
    Top = 16
    Width = 241
    Height = 49
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = AddButtonClick
  end
  object EditButton: TButton
    Left = 320
    Top = 16
    Width = 241
    Height = 49
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = EditButtonClick
  end
  object DeleteButton: TButton
    Left = 616
    Top = 16
    Width = 241
    Height = 49
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
    OnClick = DeleteButtonClick
  end
  object CandidateListStringGrid: TStringGrid
    Left = 24
    Top = 136
    Width = 833
    Height = 347
    ColCount = 7
    DefaultColWidth = 115
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 3
    OnDblClick = CandidateListStringGridDblClick
    OnKeyDown = CandidateListStringGridKeyDown
    OnSelectCell = CandidateListStringGridSelectCell
  end
  object ContentEdit: TEdit
    Left = 24
    Top = 94
    Width = 833
    Height = 36
    Hint = #1050#1083#1080#1082#1085#1080#1090#1077' '#1085#1072' '#1103#1095#1077#1081#1082#1091' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1087#1086#1083#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 4
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 488
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenMenuItem: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenMenuItemClick
      end
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
    end
  end
  object OpenTextFileDialog: TOpenTextFileDialog
    DefaultExt = 'ea'
    Filter = '(*.ea)|*.ea'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 488
  end
  object SaveTextFileDialog: TSaveTextFileDialog
    DefaultExt = 'ea'
    Filter = '(*.ea)|*.ea'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 88
    Top = 488
  end
end
