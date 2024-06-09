object SearchForm: TSearchForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1081#1090#1080' '#1087#1072#1088#1090#1080#1102
  ClientHeight = 222
  ClientWidth = 622
  Color = clBtnFace
  Constraints.MaxHeight = 260
  Constraints.MaxWidth = 634
  Constraints.MinHeight = 260
  Constraints.MinWidth = 634
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  TextHeight = 28
  object TitleLabel: TLabel
    Left = 208
    Top = 24
    Width = 210
    Height = 35
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1088#1090#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SearchEdit: TEdit
    Left = 120
    Top = 88
    Width = 393
    Height = 36
    Hint = 'Ma'#1082#1089'. '#1076#1083#1080#1085#1072' 40'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = SearchEditChange
    OnContextPopup = SearchEditContextPopup
    OnKeyDown = SearchEditKeyDown
    OnKeyPress = SearchEditKeyPress
    OnKeyUp = SearchEditKeyUp
  end
  object SearchButton: TButton
    Left = 264
    Top = 152
    Width = 89
    Height = 33
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 1
    OnClick = SearchButtonClick
  end
end
