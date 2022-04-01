object frm_novo_adicionais: Tfrm_novo_adicionais
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'INSERIR ADICIONAIS DE SERVI'#199'O'
  ClientHeight = 505
  ClientWidth = 290
  Color = clMenu
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
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 489
  end
  object DB_GRID_ADICIONAIS: TDBGrid
    Left = 17
    Top = 16
    Width = 257
    Height = 457
    DataSource = DS_ADCIONAIS
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DB_GRID_ADICIONAISDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'idAdicionais'
        Title.Caption = 'ID'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pontuacao'
        Title.Caption = 'PONTO'
        Width = 49
        Visible = True
      end>
  end
  object QRY_ADICIONAIS_LISTAR: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select * from adicionais')
    Left = 160
    Top = 128
  end
  object DS_ADCIONAIS: TDataSource
    DataSet = QRY_ADICIONAIS_LISTAR
    Left = 144
    Top = 184
  end
  object QRY_INSERIR_ADICIONAIS: TFDQuery
    Connection = DM.FDConnection1
    Left = 136
    Top = 312
    ParamData = <
      item
        Name = 'IDAD'
      end
      item
        Name = 'IDOP'
      end
      item
        Name = 'PONTO'
      end>
  end
end
