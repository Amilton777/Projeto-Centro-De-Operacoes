object frm_fotos_os: Tfrm_fotos_os
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FOTO DA O.S'
  ClientHeight = 540
  ClientWidth = 1004
  Color = clBtnFace
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
  object Image1: TImage
    Left = 24
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image1DblClick
  end
  object Image2: TImage
    Left = 176
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image2DblClick
  end
  object Image3: TImage
    Left = 336
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image3DblClick
  end
  object Image4: TImage
    Left = 504
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image4DblClick
  end
  object Image5: TImage
    Left = 672
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image5DblClick
  end
  object Image6: TImage
    Left = 840
    Top = 24
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image6DblClick
  end
  object Image7: TImage
    Left = 24
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image7DblClick
  end
  object Image8: TImage
    Left = 176
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image8DblClick
  end
  object Image9: TImage
    Left = 336
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image9DblClick
  end
  object Image10: TImage
    Left = 504
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image10DblClick
  end
  object Image11: TImage
    Left = 672
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image11DblClick
  end
  object Image12: TImage
    Left = 840
    Top = 184
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image12DblClick
  end
  object Image13: TImage
    Left = 24
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image13DblClick
  end
  object Image14: TImage
    Left = 176
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image14DblClick
  end
  object Image15: TImage
    Left = 336
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image15DblClick
  end
  object Image16: TImage
    Left = 504
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image16DblClick
  end
  object Image17: TImage
    Left = 672
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image17DblClick
  end
  object Image18: TImage
    Left = 840
    Top = 344
    Width = 129
    Height = 129
    Proportional = True
    OnDblClick = Image18DblClick
  end
  object Btn_concatenar_fotos: TBitBtn
    Left = 840
    Top = 488
    Width = 129
    Height = 33
    Caption = 'CONCATENAR FOTOS'
    TabOrder = 0
    OnClick = Btn_concatenar_fotosClick
  end
  object BitBtn1: TBitBtn
    Left = 704
    Top = 492
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object IdFTP1: TIdFTP
    Host = 'ftp.tecnicos.kinghost.net'
    Passive = True
    ConnectTimeout = 0
    Password = 'ap7880'
    TransferType = ftBinary
    Username = 'tecnicos'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 704
    Top = 80
  end
  object Qry_fotos: TFDQuery
    Connection = DM.FDConnection1
    Left = 656
    Top = 104
  end
end
