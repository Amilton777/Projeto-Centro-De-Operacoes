object frm_Troca_Status: Tfrm_Troca_Status
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'TROCA DE STATUS'
  ClientHeight = 605
  ClientWidth = 239
  Color = clMenu
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 561
    Width = 56
    Height = 13
    Caption = 'CONTRATO'
  end
  object Label2: TLabel
    Left = 95
    Top = 561
    Width = 38
    Height = 13
    Caption = 'STATUS'
  end
  object DB_GRID_STAUS: TDBGrid
    Left = 8
    Top = 8
    Width = 227
    Height = 547
    BorderStyle = bsNone
    DataSource = DS_STATUS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DB_GRID_STAUSDrawColumnCell
    OnDblClick = DB_GRID_STAUSDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'idSTATUS'
        Title.Caption = 'ID'
        Width = 29
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS_OS'
        Title.Caption = 'STATUS DA OS'
        Width = 147
        Visible = True
      end>
  end
  object EDT_CONTRATO: TDBEdit
    Left = 8
    Top = 576
    Width = 73
    Height = 21
    CharCase = ecUpperCase
    Color = clInfoBk
    DataField = 'CONTRATO'
    DataSource = frm_painel_servicos.DS_OPERACOES
    Enabled = False
    TabOrder = 1
  end
  object EDT_ESTATUS: TDBEdit
    Left = 95
    Top = 576
    Width = 140
    Height = 21
    CharCase = ecUpperCase
    Color = clInfoBk
    DataField = 'STATUS'
    DataSource = frm_painel_servicos.DS_OPERACOES
    Enabled = False
    TabOrder = 2
  end
  object QRY_STATUS: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select * from status st where st.idstatus <> '#39'1'#39)
    Left = 80
    Top = 208
  end
  object DS_STATUS: TDataSource
    DataSet = QRY_STATUS
    Left = 88
    Top = 128
  end
  object QRY_PONTUACAO: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select sum(pontuacao) from itens_adicionais')
    Left = 119
    Top = 472
  end
  object QRY_DELETAR_REAGENDAMENTO: TFDQuery
    Connection = DM.FDConnection1
    Left = 104
    Top = 344
  end
end
