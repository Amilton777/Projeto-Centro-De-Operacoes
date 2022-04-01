unit Frmlog_tecnico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_log_interacao_tecnico = class(TForm)
    DBGrid1: TDBGrid;
    QRY_LOG_INTERACAO_TEC: TFDQuery;
    DS_LOG_INTERACAO: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_log_interacao_tecnico: Tfrm_log_interacao_tecnico;

implementation

{$R *.dfm}

uses Frm_Edt_Servicos, DataModule;


procedure Tfrm_log_interacao_tecnico.FormShow(Sender: TObject);
begin
    QRY_LOG_INTERACAO_TEC.Close;
    QRY_LOG_INTERACAO_TEC.Params.ParamByName('ID').AsString:= FRM_EDITAR_OS.DBEdit1.Text;
    QRY_LOG_INTERACAO_TEC.Open;
end;

end.
