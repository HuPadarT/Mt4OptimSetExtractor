object frmMt4OptimSetExtractor: TfrmMt4OptimSetExtractor
  Left = 0
  Top = 0
  Caption = 'Mt4 optimization report Set Extractor'
  ClientHeight = 602
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 784
    Height = 529
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 575
    Width = 784
    Height = 27
    Panels = <
      item
        Width = 120
      end
      item
        Width = 100
      end
      item
        Alignment = taRightJustify
        Width = 100
      end>
    ExplicitWidth = 800
  end
  object Panel1: TPanel
    Left = 0
    Top = 529
    Width = 784
    Height = 40
    Align = alTop
    TabOrder = 2
    ExplicitTop = 527
    ExplicitWidth = 636
    DesignSize = (
      784
      40)
    object btnImport: TButton
      Left = 8
      Top = 6
      Width = 159
      Height = 25
      Caption = 'Import Mt4 optim report'
      TabOrder = 0
      OnClick = btnImportClick
    end
    object btnSaveSet: TButton
      Left = 617
      Top = 6
      Width = 159
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save selected to Set file'
      TabOrder = 1
      OnClick = btnSaveSetClick
      ExplicitLeft = 469
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 288
    Top = 256
  end
  object SaveDialog1: TSaveDialog
    Left = 424
    Top = 256
  end
  object DataSource1: TDataSource
    Left = 352
    Top = 400
  end
end
