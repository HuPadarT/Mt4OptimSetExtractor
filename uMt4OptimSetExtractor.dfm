object frmMt4OptimSetExtractor: TfrmMt4OptimSetExtractor
  Left = 0
  Top = 0
  Caption = 'Mt4 optimization report Set Extractor'
  ClientHeight = 699
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    835
    699)
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 835
    Height = 649
    Align = alTop
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object btnImport: TButton
    Left = 0
    Top = 666
    Width = 159
    Height = 25
    Caption = 'Import Mt4 optim report'
    TabOrder = 1
    OnClick = btnImportClick
  end
  object btnSaveSet: TButton
    Left = 674
    Top = 666
    Width = 159
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save selected to Set file'
    TabOrder = 2
    OnClick = btnSaveSetClick
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
