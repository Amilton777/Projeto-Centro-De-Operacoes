object frm_log_interacao_tecnico: Tfrm_log_interacao_tecnico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'LOG DE INTERA'#199#195'O DO T'#201'CNICO'
  ClientHeight = 355
  ClientWidth = 474
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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 465
    Height = 337
    DataSource = DS_LOG_INTERACAO
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'contrato'
        Title.Caption = 'CONTRATO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data_interacao'
        Title.Caption = 'DATA INTERA'#199#195'O'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_tecnico'
        Title.Caption = 'NOME DO T'#201'CNCO'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'observacao'
        Title.Caption = 'OBSERVA'#199#195'O'
        Width = 226
        Visible = True
      end>
  end
  object QRY_LOG_INTERACAO_TEC: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      
        'select nome_tecnico,contrato, observacao, data_interacao from in' +
        'teracao_os it, tecnicos tec '
      'where it.idtecnicos = tec.idtecnicos'
      'and it.idoperacoes = :id')
    Left = 96
    Top = 248
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 206
      end>
  end
  object DS_LOG_INTERACAO: TDataSource
    DataSet = QRY_LOG_INTERACAO_TEC
    Left = 264
    Top = 240
  end
end
