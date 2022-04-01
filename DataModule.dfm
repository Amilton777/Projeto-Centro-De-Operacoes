object DM: TDM
  OldCreateOrder = False
  Height = 859
  Width = 1397
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=tecnicos'
      'User_Name=root'
      'Password=ap7880'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 48
    Top = 64
  end
  object DRIVE: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Windows\System32\libmysql.dll'
    Left = 48
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 8
  end
  object QRY_LOGIN: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from login')
    Left = 48
    Top = 120
  end
  object DS_LOGIN: TDataSource
    DataSet = QRY_LOGIN
    Left = 48
    Top = 184
  end
  object QRY_SERVICOS: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'Select * from SERVICOS')
    Left = 152
    Top = 121
  end
  object QRY_Operacoes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'Select * from Operacoes OP, Origem ORI, tecnicos TEC,planos PL, ' +
        'servicos SER, Cidades CID, EQUIPES EQ'
      
        #10'WHERE OP.IDTECNICOS = TEC.IDTECNICOS and OP.IDORIGEM = ORI.IDOR' +
        'IGEM AND OP.IDSERVICOS = SER.IDSERVICOS AND'
      'OP.IDPLANOS = PL.IDPLANOS AND TEC.IDEQUIPES = EQ.IDEQUIPES'
      'and'#10' TEC.idCidades = CID.idCidades')
    Left = 248
    Top = 120
    ParamData = <
      item
        Name = 'CONTRATO'
      end>
  end
  object QRY_Cad_Operacoes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'Select * from operacoes')
    Left = 360
    Top = 120
  end
  object FDConnection2: TFDConnection
    Left = 208
    Top = 192
  end
  object QRY_ID_TECNICO: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select idtecnicos from tecnicos where nome_tecnico = :nome')
    Left = 240
    Top = 288
    ParamData = <
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
        Value = 'DONISETE SILVA'
      end>
  end
  object QRY_NOME_TECNICO: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select nome_tecnico from tecnicos where idtecnicos = :id')
    Left = 240
    Top = 360
    ParamData = <
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
  end
end
