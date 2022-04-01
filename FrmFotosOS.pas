unit FrmFotosOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,Jpeg, Vcl.Dialogs, Vcl.ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdExplicitTLSClientServerBase, IdFTP, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_fotos_os = class(TForm)
    Image1: TImage;
    IdFTP1: TIdFTP;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Qry_fotos: TFDQuery;
    Btn_concatenar_fotos: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Image2DblClick(Sender: TObject);
    procedure Image3DblClick(Sender: TObject);
    procedure Image4DblClick(Sender: TObject);
    procedure Image5DblClick(Sender: TObject);
    procedure Image6DblClick(Sender: TObject);
    procedure Image7DblClick(Sender: TObject);
    procedure Image8DblClick(Sender: TObject);
    procedure Image9DblClick(Sender: TObject);
    procedure Image10DblClick(Sender: TObject);
    procedure Image11DblClick(Sender: TObject);
    procedure Image12DblClick(Sender: TObject);
    procedure Image13DblClick(Sender: TObject);
    procedure Image14DblClick(Sender: TObject);
    procedure Image15DblClick(Sender: TObject);
    procedure Image16DblClick(Sender: TObject);
    procedure Image17DblClick(Sender: TObject);
    procedure Image18DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_concatenar_fotosClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  function UnirTudo(Imagens : array of TBitmap): TBitmap;
  function Unir(G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16, G17, G18: TGraphic): TBitmap;

  END;

var
  frm_fotos_os: Tfrm_fotos_os;
  VetorImagens: array [0..18] of TImage;
  VetorImagens2: array [0..18] of TBitmap;
  Caminhos: array [0..18] of string;

implementation

{$R *.dfm}

uses DataModule, Frm_Edt_Servicos, FrmExibirUnit12;

function Tfrm_fotos_os.Unir(G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16, G17, G18: TGraphic): TBitmap;
VAR TODAS: TGraphic;
begin
  Result := TBitmap.Create;
  with Result do
  try
    Width := G1.Width + G2.Width + G3.Width + G4.Width + G5.Width + G6.Width + G7.Width + G8.Width + G9.Width + G10.Width;
    TODAS:= G3; //G2 + G3 + G4 + G5 + G6 + G7 + G8 + G9 + G10;

    Height := G1.Width;
    Canvas.Draw(0, 0, G1);
    Canvas.Draw(G1.Width, 0, G2);


   // Canvas.Draw(0, 0, G2);
   // Canvas.Draw(G2.Width, 0, G3);


  except
    FreeAndNil(Result);
    raise;
  end;
end;


function Tfrm_fotos_os.UnirTudo(Imagens : array of TBitmap): TBitmap;
var
i : Integer;
begin
  Result := TBitmap.Create;
  with Result do
  try
    Width := Imagens[i].Width;
    Height := Imagens[i].Width;
    for i := 0 to Length(Imagens) - 1 do begin
      Canvas.Draw(0, 0, Imagens[i]);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure Tfrm_fotos_os.BitBtn1Click(Sender: TObject);
 var
  P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18: TPicture;
  B: TBitmap;
begin
  P1 := TPicture.Create;  P2 := TPicture.Create;  P3 := TPicture.Create;  P4 := TPicture.Create;
  P5 := TPicture.Create;  P6 := TPicture.Create;  P7 := TPicture.Create;  P8 := TPicture.Create;
  P9 := TPicture.Create;  P10 := TPicture.Create; P11 := TPicture.Create; P12 := TPicture.Create;
  P13 := TPicture.Create; P14 := TPicture.Create; P15 := TPicture.Create; P16 := TPicture.Create;
  P17 := TPicture.Create; P18 := TPicture.Create;

  try
    //Unir fotos
    P1.LoadFromFile(caminhos[1]);  P2.LoadFromFile(caminhos[2]);  P3.LoadFromFile(caminhos[3]);
    P4.LoadFromFile(caminhos[4]);  P5.LoadFromFile(caminhos[5]);  P6.LoadFromFile(caminhos[6]);
    P7.LoadFromFile(caminhos[7]);  P8.LoadFromFile(caminhos[8]);  P9.LoadFromFile(caminhos[9]);
    P10.LoadFromFile(caminhos[10]);P11.LoadFromFile(caminhos[11]);P12.LoadFromFile(caminhos[12]);
    P13.LoadFromFile(caminhos[13]);P14.LoadFromFile(caminhos[14]);P15.LoadFromFile(caminhos[15]);
    P16.LoadFromFile(caminhos[16]);P17.LoadFromFile(caminhos[17]);P18.LoadFromFile(caminhos[18]);

   //  P1.LoadFromFile('C:\Thunder\fotos_os\411\42d7a74b21a17e132a5accbe0f0fe2a3.jpg');
   //  P2.LoadFromFile('C:\Thunder\fotos_os\411\7a45e7c6ea97b24e73249d7487c68f5c.jpg');


    B := Unir(P1.Graphic, P2.Graphic, P3.Graphic, P4.Graphic,P5.Graphic, P6.Graphic,P7.Graphic, P8.Graphic,P9.Graphic, P10.Graphic,
    P11.Graphic, P12.Graphic,P13.Graphic, P14.Graphic,P15.Graphic, P16.Graphic,P17.Graphic, P18.Graphic);

    with TJPEGImage.Create do
    try
      Assign(B);
      SaveToFile('C:\Thunder\fotos_os\'+FRM_EDITAR_OS.DBEdit1.Text+'\'+FRM_EDITAR_OS.DBEdit1.Text+'.jpg');

    finally
      Free;
      B.Free;
    end;
  finally
    P1.Free;
    P2.Free;
  end;
end;

procedure Tfrm_fotos_os.Btn_concatenar_fotosClick(Sender: TObject);
VAR RESULTADO: TBitmap;

begin
   RESULTADO:= (UnirTudo(VetorImagens2));
 //Assign(RESULTADO);
   RESULTADO.SaveToFile('C:\Thunder\fotos_os\'+FRM_EDITAR_OS.DBEdit1.Text+'\'+FRM_EDITAR_OS.DBEdit1.Text+'.jpg');

end;

procedure Tfrm_fotos_os.FormClose(Sender: TObject; var Action: TCloseAction);
VAR I: INTEGER;
begin
     For I := 1 to 18 do
      begin
        VetorImagens[I].Picture.LoadFromFile('');
      end;
      Qry_fotos.Close;

end;

procedure Tfrm_fotos_os.FormShow(Sender: TObject);

var
  path:string;

  lab, i: integer;



  begin
      Lab:=0;
     For I := 0 to 18 do
      begin
        if (Components [I] is TImage) then
          begin
           Inc (Lab);
           VetorImagens[Lab] := TImage (Components [I]);
           VetorImagens2[Lab] := TBitmap (Components [I]);
          end;
      end;

      if not DirectoryExists('C:\Thunder\fotos_os\'+FRM_EDITAR_OS.DBEdit1.Text) then
        ForceDirectories('C:\Thunder\fotos_os\'+FRM_EDITAR_OS.DBEdit1.Text);


      IdFTP1.Connect;

      Qry_fotos.Close;
      Qry_fotos.SQL.Text:=('select arquivo from imagens where idoperacoes = :id');
      Qry_fotos.Params.ParamByName('id').AsString:= FRM_EDITAR_OS.DBEdit1.Text;
      Qry_fotos.Open;

      Lab:=1;

      while not Qry_fotos.Eof do
      begin
       path :=  ('C:\Thunder\fotos_os\'+FRM_EDITAR_OS.DBEdit1.Text+'\'+Qry_fotos.FieldByName('arquivo').AsString);
       if not fileExists (path) then
        IdFTP1.Get('imagens/'+Qry_fotos.FieldByName('arquivo').AsString, path, True, True);
         VetorImagens[lab].Picture.LoadFromFile(path);
         Caminhos[LAB]:= (path);
         inc(lab);
       Qry_fotos.Next;
      end;


       IdFTP1.Disconnect;



end;

procedure Tfrm_fotos_os.Image10DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[10]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image11DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[11]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image12DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[12]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image13DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[13]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image14DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[14]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image15DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[15]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image16DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[16]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image17DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[17]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image18DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[18]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image1DblClick(Sender: TObject);
begin
    frm_exibir.Image1.Picture.LoadFromFile(Caminhos[1]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image2DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[2]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image3DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[3]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image4DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[4]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image5DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[5]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image6DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[6]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image7DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[7]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image8DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[8]);

    frm_exibir.showmodal;
end;

procedure Tfrm_fotos_os.Image9DblClick(Sender: TObject);
begin
     frm_exibir.Image1.Picture.LoadFromFile(Caminhos[9]);

    frm_exibir.showmodal;
end;

end.
