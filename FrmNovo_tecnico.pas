unit FrmNovo_tecnico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_novo_tecnico = class(TForm)
    DBGrid1: TDBGrid;
    QRY_CONSULTA_TECNICOS: TFDQuery;
    DS_CONSULTA_TECNICOS: TDataSource;
    edt_pesquisa_nome: TEdit;
    Label1: TLabel;
    btn_novo_tecnico: TBitBtn;
    btn_excluir: TBitBtn;
    procedure edt_pesquisa_nomeChange(Sender: TObject);
    procedure btn_novo_tecnicoClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_novo_tecnico: Tfrm_novo_tecnico;

implementation

{$R *.dfm}

uses DataModule, FrmCadastro_tecnico;

procedure Tfrm_novo_tecnico.btn_excluirClick(Sender: TObject);
begin
    if (Application.MessageBox('Deseja realmente excluir este registro?',
  'Confirmação', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
    DS_CONSULTA_TECNICOS.DataSet.Delete;
end;

procedure Tfrm_novo_tecnico.btn_novo_tecnicoClick(Sender: TObject);
begin

    QRY_CONSULTA_TECNICOS.close;
    QRY_CONSULTA_TECNICOS.open;

    DS_CONSULTA_TECNICOS.DataSet.Insert;

    frm_cadastro_tecnico.showmodal;

end;

procedure Tfrm_novo_tecnico.DBGrid1DblClick(Sender: TObject);
begin

    if QRY_CONSULTA_TECNICOS.RowsAffected > 0 then
     begin
      DS_CONSULTA_TECNICOS.DataSet.Edit;
      frm_cadastro_tecnico.ShowModal;
     end;
end;

procedure Tfrm_novo_tecnico.edt_pesquisa_nomeChange(Sender: TObject);
begin
    QRY_CONSULTA_TECNICOS.close;
    QRY_CONSULTA_TECNICOS.params.parambyname('nome').asstring:='%'+edt_pesquisa_nome.text+'%';
    QRY_CONSULTA_TECNICOS.open;
end;

end.
