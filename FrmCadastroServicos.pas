unit FrmCadastroServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons;

type
  Tfrm_servicos = class(TForm)
    DS_SERVICOS: TDataSource;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    EDT_DESCRICAO: TDBEdit;
    EDT_PONTUACAO: TDBEdit;
    btn_novo: TBitBtn;
    btn_alterar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_excluir: TBitBtn;
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_excluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_servicos: Tfrm_servicos;

implementation

{$R *.dfm}

uses DataModule;

procedure Tfrm_servicos.btn_excluirClick(Sender: TObject);
begin

    IF (Application.MessageBox('Deseja realmente excluir este registro?',
     'Confirmação', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
     begin
        DS_SERVICOS.DataSet.Delete;
        EDT_DESCRICAO.Enabled:=FALSE;
        EDT_PONTUACAO.Enabled:=FALSE;
     end;

end;

procedure Tfrm_servicos.btn_alterarClick(Sender: TObject);
begin
    DS_SERVICOS.DataSet.Edit;
    EDT_DESCRICAO.Enabled:=TRUE;
    EDT_PONTUACAO.Enabled:=TRUE;
    EDT_DESCRICAO.SetFocus;

end;

procedure Tfrm_servicos.btn_salvarClick(Sender: TObject);
begin
    DS_SERVICOS.DataSet.Append;
    DS_SERVICOS.DataSet.Cancel;
    EDT_DESCRICAO.SetFocus;
    EDT_DESCRICAO.Enabled:=FALSE;
    EDT_PONTUACAO.Enabled:=FALSE;
end;

procedure Tfrm_servicos.btn_novoClick(Sender: TObject);
begin
    DS_SERVICOS.DataSet.Append;
    EDT_DESCRICAO.Enabled:=TRUE;
    EDT_PONTUACAO.Enabled:=TRUE;
    EDT_DESCRICAO.SetFocus;
end;

procedure Tfrm_servicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    DS_SERVICOS.DataSet.Cancel;
    EDT_DESCRICAO.Enabled:=false;
    EDT_PONTUACAO.Enabled:=FALSE;
end;

procedure Tfrm_servicos.FormShow(Sender: TObject);
begin
    EDT_DESCRICAO.Enabled:=false;
    EDT_PONTUACAO.Enabled:=FALSE;
end;

end.
