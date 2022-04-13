object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 497
  ClientWidth = 712
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 371
    Width = 89
    Height = 24
    Caption = #1058#1080#1087' '#1095#1072#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 22
    Top = 418
    Width = 115
    Height = 24
    Caption = 'ID '#1087#1088#1086#1092#1080#1083#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object VirtualStringTree1: TVirtualStringTree
    Left = 32
    Top = 40
    Width = 513
    Height = 305
    Header.AutoSizeIndex = 0
    Header.MainColumn = 1
    Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    TabOrder = 0
    OnAddToSelection = VirtualStringTree1AddToSelection
    OnGetText = VirtualStringTree1GetText
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus, coEditable, coStyleColor]
        Position = 0
        Text = 'Id'
      end
      item
        Position = 1
        Text = #1058#1080#1087' '#1095#1072#1090#1072
        Width = 81
      end
      item
        Position = 2
        Text = #1048#1084#1103
        Width = 83
      end
      item
        Position = 3
        Text = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103
        Width = 150
      end
      item
        Position = 4
        Text = #1058#1077#1083#1077#1092#1086#1085
        Width = 133
      end>
  end
  object Button1: TButton
    Left = 584
    Top = 104
    Width = 113
    Height = 49
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 584
    Top = 168
    Width = 113
    Height = 49
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 584
    Top = 232
    Width = 113
    Height = 49
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 160
    Top = 368
    Width = 89
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 160
    Top = 415
    Width = 129
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
end
