unit FrmInserirAdicionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tfrm_novo_adicionais = class(TForm)
    Bevel1: TBevel;
    DB_GRID_ADICIONAIS: TDBGrid;
    QRY_ADICIONAIS_LISTAR: TFDQuery;
    DS_ADCIONAIS: TDataSource;
    QRY_INSERIR_ADICIONAIS: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure DB_GRID_ADICIONAISDblClick(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    function TrocaVirgulaPorPonto(Valor: string): String;

  end;

var
  frm_novo_adicionais: Tfrm_novo_adicionais;

implementation

{$R *.dfm}

uses DataModule, Frm_Edt_Servicos;

procedure Tfrm_novo_adicionais.DB_GRID_ADICIONAISDblClick(Sender: TObject);
var Ponto,chave: STRING;

begin
      //função para retirar a virgula exemplo 0,5 para 0.5
      Ponto:= TrocaVirgulaPorPonto((DB_GRID_ADICIONAIS.Fields[2].TEXT));

      //Chave somente para ativar o auto incremento;
      chave:='';

      // inserindo na tabela ITENS_ADICIONAIS
      QRY_INSERIR_ADICIONAIS.Close;
      QRY_INSERIR_ADICIONAIS.SQL.Clear;
      QRY_INSERIR_ADICIONAIS.SQL.Add('insert into itens_adicionais(iditens_adicionais, idadicionais, idoperacoes, pontuacao)');
      QRY_INSERIR_ADICIONAIS.SQL.Add('values('''+(CHAVE)+''','+DB_GRID_ADICIONAIS.Fields[0].TEXT+','+FRM_EDITAR_OS.DBEdit1.TEXT+','+Ponto+')');


      QRY_INSERIR_ADICIONAIS.ExecSQL;


      //Atualizar o itens adicionais de serviço
      FRM_EDITAR_OS.QRY_ITENS_ADD.Close;
      FRM_EDITAR_OS.QRY_ITENS_ADD.SQL.Clear;
      frm_editar_os.qry_itens_add.sql.add('select id.idoperacoes, id.idadicionais,ad.descricao, id.pontuacao');
      frm_editar_os.qry_itens_add.sql.add('from itens_adicionais id, adicionais ad');
      frm_editar_os.qry_itens_add.sql.add('where (id.idadicionais = ad.idadicionais) and (id.idoperacoes = :pid)');

      FRM_EDITAR_OS.QRY_ITENS_ADD.ParamByName('pID').Value:= FRM_EDITAR_OS.DBEdit1.Text;
      FRM_EDITAR_OS.QRY_ITENS_ADD.Open;




end;

procedure Tfrm_novo_adicionais.FormShow(Sender: TObject);
begin

  QRY_ADICIONAIS_LISTAR.Close;
  QRY_ADICIONAIS_LISTAR.Open;

end;

function Tfrm_novo_adicionais.TrocaVirgulaPorPonto(Valor: string): String;
var i:integer;
begin
    if Valor <>'' then begin
        for i := 0 to Length(Valor) do begin
            if Valor[i]=',' then Valor[i]:='.';

        end;
     end;
     Result := valor;
end;

end.
