object FrmDeslocamento: TFrmDeslocamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'INSERIR DESLOCAMENTOS'
  ClientHeight = 397
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Edt_pesquisa: TEdit
    Left = 8
    Top = 16
    Width = 393
    Height = 27
    CharCase = ecUpperCase
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = Edt_pesquisaChange
  end
  object DB_GRID_DESLOCAMENTOS: TDBGrid
    Left = 8
    Top = 49
    Width = 393
    Height = 160
    DataSource = DS_Deslocamentos
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DB_GRID_DESLOCAMENTOSDrawColumnCell
    OnDblClick = DB_GRID_DESLOCAMENTOSDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'idDESLOCAMENTOS'
        Title.Caption = 'ID'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_DESLOCAMENTO'
        Title.Caption = 'Descri'#231#227'o do Deslocamento'
        Width = 282
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pontuacao'
        Title.Caption = 'Pontua'#231#227'o'
        Width = 54
        Visible = True
      end>
  end
  object Edt_idtecnico: TEdit
    Left = 8
    Top = 223
    Width = 25
    Height = 21
    Color = clInfoBk
    TabOrder = 2
  end
  object Edt_nome_tecnico: TEdit
    Left = 39
    Top = 223
    Width = 170
    Height = 21
    Color = clInfoBk
    TabOrder = 3
  end
  object edt_cidade_origem: TEdit
    Left = 215
    Top = 223
    Width = 90
    Height = 21
    Color = clInfoBk
    TabOrder = 4
  end
  object Edt_data: TEdit
    Left = 311
    Top = 223
    Width = 90
    Height = 21
    Color = clInfoBk
    TabOrder = 5
  end
  object DB_GRID_ITENS: TDBGrid
    Left = 8
    Top = 250
    Width = 393
    Height = 139
    DataSource = DS_INSERIR_DESLOCAMENTO
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DB_GRID_ITENSDrawColumnCell
    OnDblClick = DB_GRID_ITENSDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'idItens_Deslocamentos'
        Title.Caption = 'ID'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'idtecnicos'
        Title.Caption = 'ID TEC.'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iddeslocamentos'
        Title.Caption = 'ID DES.'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pontuacao'
        Title.Caption = 'Pontuac'#227'o'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_DESLOCAMENTO'
        Title.Caption = 'Data Deslocamento'
        Width = 142
        Visible = True
      end>
  end
  object Qry_Deslocamentos: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'Select * from Deslocamentos')
    Left = 344
    Top = 104
  end
  object DS_Deslocamentos: TDataSource
    DataSet = Qry_Deslocamentos
    Left = 344
    Top = 160
  end
  object Qry_INSERIR_DESLOCAMENTO: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'SELECT * FROM ITENS_DESLOCAMENTOS')
    Left = 96
    Top = 128
  end
  object DS_INSERIR_DESLOCAMENTO: TDataSource
    DataSet = Qry_INSERIR_DESLOCAMENTO
    Left = 96
    Top = 176
  end
  object Qry_MaxDeslocamento: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'Select Max(idItens_deslocamentos) from itens_deslocamentos')
    Left = 224
    Top = 104
  end
end
