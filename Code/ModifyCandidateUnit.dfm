object ModifyCandidateForm: TModifyCandidateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1085#1076#1080#1076#1072#1090
  ClientHeight = 532
  ClientWidth = 533
  Color = clBtnFace
  Constraints.MaxHeight = 571
  Constraints.MaxWidth = 546
  Constraints.MinHeight = 570
  Constraints.MinWidth = 545
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 28
  object TitleLabel: TLabel
    Left = 136
    Top = 24
    Width = 282
    Height = 35
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1072#1085#1076#1080#1076#1072#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DistrictNumberLabel: TLabel
    Left = 16
    Top = 80
    Width = 133
    Height = 28
    Caption = #1053#1086#1084#1077#1088' '#1086#1082#1088#1091#1075#1072':'
  end
  object LastNameLabel: TLabel
    Left = 16
    Top = 136
    Width = 88
    Height = 28
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object FirstNameLabel: TLabel
    Left = 16
    Top = 190
    Width = 43
    Height = 28
    Caption = #1048#1084#1103':'
  end
  object PatronymicLabel: TLabel
    Left = 16
    Top = 247
    Width = 88
    Height = 28
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object PartyLabel: TLabel
    Left = 16
    Top = 299
    Width = 70
    Height = 28
    Caption = #1055#1072#1088#1090#1080#1103':'
  end
  object AgeLabel: TLabel
    Left = 16
    Top = 348
    Width = 75
    Height = 28
    Caption = #1042#1086#1079#1088#1072#1089#1090':'
  end
  object ProfessionLabel: TLabel
    Left = 16
    Top = 400
    Width = 106
    Height = 28
    Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103':'
  end
  object DistrictNumberEdit: TEdit
    Left = 168
    Top = 77
    Width = 350
    Height = 36
    Hint = #1044#1080#1072#1087#1072#1079#1086#1085' '#1086#1090' 1 '#1076#1086' 100000'
    MaxLength = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = '12'
    OnChange = EditChange
    OnContextPopup = PositiveNumberEditContextPopup
    OnKeyDown = PositiveNumberEditKeyDown
    OnKeyPress = PositiveNumberEditKeyPress
    OnKeyUp = PositiveNumberEditKeyUp
  end
  object LastNameEdit: TEdit
    Left = 168
    Top = 136
    Width = 350
    Height = 36
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' 30'
    MaxLength = 30
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = #1048#1074#1072#1085#1086#1074
    OnChange = EditChange
    OnContextPopup = NameEditContextPopup
    OnKeyDown = NameEditKeyDown
    OnKeyPress = NameEditKeyPress
    OnKeyUp = NameEditKeyUp
  end
  object FirstNameEdit: TEdit
    Left = 168
    Top = 190
    Width = 350
    Height = 36
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' 30'
    MaxLength = 30
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TextHint = #1048#1074#1072#1085
    OnChange = EditChange
    OnContextPopup = NameEditContextPopup
    OnKeyDown = NameEditKeyDown
    OnKeyPress = NameEditKeyPress
    OnKeyUp = NameEditKeyUp
  end
  object PatronymicEdit: TEdit
    Left = 168
    Top = 247
    Width = 350
    Height = 36
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' 30, '#1085#1077#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086#1077' '#1087#1086#1083#1077
    MaxLength = 30
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TextHint = #1048#1074#1072#1085#1086#1074#1080#1095
    OnChange = EditChange
    OnContextPopup = NameEditContextPopup
    OnKeyDown = NameEditKeyDown
    OnKeyPress = NameEditKeyPress
    OnKeyUp = NameEditKeyUp
  end
  object PartyEdit: TEdit
    Left = 168
    Top = 299
    Width = 350
    Height = 36
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' 40'
    MaxLength = 40
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    TextHint = #1051#1080#1073#1077#1088#1072#1083#1100#1085#1086'-'#1076#1077#1084#1086#1082#1088#1072#1090#1080#1095#1077#1089#1082#1072#1103
    OnChange = EditChange
    OnContextPopup = NameEditContextPopup
    OnKeyDown = NameEditKeyDown
    OnKeyPress = NameEditKeyPress
    OnKeyUp = NameEditKeyUp
  end
  object AgeEdit: TEdit
    Left = 168
    Top = 348
    Width = 350
    Height = 36
    Hint = #1044#1080#1072#1087#1072#1079#1086#1085' '#1086#1090' 1 '#1076#1086' 100'
    MaxLength = 3
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TextHint = '35'
    OnChange = EditChange
    OnContextPopup = PositiveNumberEditContextPopup
    OnKeyDown = PositiveNumberEditKeyDown
    OnKeyPress = PositiveNumberEditKeyPress
    OnKeyUp = PositiveNumberEditKeyUp
  end
  object ProfessionEdit: TEdit
    Left = 168
    Top = 400
    Width = 350
    Height = 36
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' 30'
    MaxLength = 30
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    TextHint = #1048#1085#1078#1077#1085#1077#1088
    OnChange = EditChange
    OnKeyDown = NameEditKeyDown
    OnKeyPress = NameEditKeyPress
    OnKeyUp = NameEditKeyUp
  end
  object ModifyButton: TButton
    Left = 32
    Top = 464
    Width = 169
    Height = 42
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 7
    OnClick = ModifyButtonClick
    OnKeyDown = ControlKeyDown
  end
  object CancelButton: TButton
    Left = 320
    Top = 464
    Width = 169
    Height = 42
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 8
    OnClick = CancelButtonClick
    OnKeyDown = ControlKeyDown
  end
end
