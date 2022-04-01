object frm_import: Tfrm_import
  Left = 0
  Top = 0
  Caption = 'frm_import'
  ClientHeight = 657
  ClientWidth = 1095
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 56
    Width = 1036
    Height = 593
    ColCount = 9
    RowCount = 10000
    TabOrder = 0
    ColWidths = (
      64
      207
      154
      51
      114
      156
      121
      41
      88)
  end
  object btn_importar: TBitBtn
    Left = 8
    Top = 8
    Width = 153
    Height = 42
    Caption = 'DADOS NO DBGRID'
    TabOrder = 1
    OnClick = btn_importarClick
  end
  object ProgressBar1: TProgressBar
    Left = 167
    Top = 8
    Width = 877
    Height = 42
    Max = 67247
    BarColor = clLime
    BackgroundColor = clGray
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    FileName = 
      'C:\Users\Projeto 05\Desktop\AGENDAMENTO_DELPHI\IMPORT\IMPORTACAO' +
      '.xlsx'
    Left = 592
    Top = 112
  end
  object QRY_INSERIR_MIGRACAO: TFDQuery
    Connection = DM.FDConnection1
    Left = 800
    Top = 8
  end
end
