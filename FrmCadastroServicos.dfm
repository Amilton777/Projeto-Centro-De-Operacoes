object frm_servicos: Tfrm_servicos
  AlignWithMargins = True
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  Caption = 'CADASTRO DE SERVI'#199'OS'
  ClientHeight = 333
  ClientWidth = 421
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 112
    Width = 401
    Height = 213
    DataSource = DS_SERVICOS
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'idSERVICOS'
        Title.Caption = 'ID'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DES_SERVICO'
        Title.Caption = 'DESCRI'#199#195'O DO SERVI'#199'O'
        Width = 242
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pontuacao'
        Title.Caption = 'Pontua'#231#227'o'
        Width = 76
        Visible = True
      end>
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 16
    Width = 57
    Height = 21
    DataField = 'idSERVICOS'
    DataSource = DS_SERVICOS
    Enabled = False
    TabOrder = 1
  end
  object EDT_DESCRICAO: TDBEdit
    Left = 88
    Top = 16
    Width = 325
    Height = 21
    DataField = 'DES_SERVICO'
    DataSource = DS_SERVICOS
    TabOrder = 2
  end
  object EDT_PONTUACAO: TDBEdit
    Left = 8
    Top = 64
    Width = 81
    Height = 21
    DataField = 'Pontuacao'
    DataSource = DS_SERVICOS
    TabOrder = 3
  end
  object btn_novo: TBitBtn
    Left = 95
    Top = 62
    Width = 75
    Height = 25
    Caption = 'NOVO'
    TabOrder = 4
    OnClick = btn_novoClick
  end
  object btn_alterar: TBitBtn
    Left = 176
    Top = 62
    Width = 75
    Height = 25
    Caption = 'ALTERAR'
    TabOrder = 5
    OnClick = btn_alterarClick
  end
  object btn_salvar: TBitBtn
    Left = 334
    Top = 62
    Width = 75
    Height = 25
    Caption = 'SALVAR'
    TabOrder = 6
    OnClick = btn_salvarClick
  end
  object btn_excluir: TBitBtn
    Left = 257
    Top = 62
    Width = 75
    Height = 25
    Caption = 'EXCLUIR'
    TabOrder = 7
    OnClick = btn_excluirClick
  end
  object DS_SERVICOS: TDataSource
    DataSet = DM.QRY_SERVICOS
    Left = 672
    Top = 200
  end
end
