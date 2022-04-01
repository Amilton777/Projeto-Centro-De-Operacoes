unit FrmDeslocamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TFrmDeslocamento = class(TForm)
    Edt_pesquisa: TEdit;
    DB_GRID_DESLOCAMENTOS: TDBGrid;
    Qry_Deslocamentos: TFDQuery;
    DS_Deslocamentos: TDataSource;
    Edt_idtecnico: TEdit;
    Edt_nome_tecnico: TEdit;
    edt_cidade_origem: TEdit;
    Edt_data: TEdit;
    Qry_INSERIR_DESLOCAMENTO: TFDQuery;
    DB_GRID_ITENS: TDBGrid;
    DS_INSERIR_DESLOCAMENTO: TDataSource;
    Qry_MaxDeslocamento: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure Edt_pesquisaChange(Sender: TObject);
    procedure DB_GRID_DESLOCAMENTOSDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DB_GRID_DESLOCAMENTOSDblClick(Sender: TObject);
    procedure DB_GRID_ITENSDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DB_GRID_ITENSDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDeslocamento: TFrmDeslocamento;

implementation

{$R *.dfm}

uses FrmPrincipal;

procedure TFrmDeslocamento.DB_GRID_ITENSDblClick(Sender: TObject);
begin
     IF (Application.MessageBox('Deseja realmente excluir este deslocamento?','Confirmação', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
      DS_INSERIR_DESLOCAMENTO.DataSet.Delete;
end;

procedure TFrmDeslocamento.DB_GRID_ITENSDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
VAR Balizador:INTEGER;
begin


    IF Qry_INSERIR_DESLOCAMENTO.RowsAffected > 0  then
     Balizador:=StrToInt(DB_GRID_ITENS.Columns[0].Field.Text);

    IF Balizador mod 2 = 0 Then
     BEGIN
        DB_GRID_ITENS.Canvas.Brush.Color:= CLInfobk;
        DB_GRID_ITENS.Canvas.FillRect(Rect);
        DB_GRID_ITENS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
     END
     ELSE
      BEGIN
         DB_GRID_ITENS.Canvas.Brush.Color:= CLMenu;
        DB_GRID_ITENS.Canvas.FillRect(Rect);
        DB_GRID_ITENS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      END;
end;

procedure TFrmDeslocamento.DB_GRID_DESLOCAMENTOSDblClick(Sender: TObject);
begin

    DS_INSERIR_DESLOCAMENTO.DataSet.Insert;

    DS_INSERIR_DESLOCAMENTO.DataSet.FieldByName('idItens_Deslocamentos').AsString:='';
    DS_INSERIR_DESLOCAMENTO.DataSet.FieldByName('idtecnicos').AsString:= Edt_idtecnico.Text;
    DS_INSERIR_DESLOCAMENTO.DataSet.FieldByName('iddeslocamentos').AsString:= DB_GRID_DESLOCAMENTOS.Columns[0].Field.Text;
    DS_INSERIR_DESLOCAMENTO.DataSet.FieldByName('Pontuacao').AsString:= DB_GRID_DESLOCAMENTOS.Columns[2].Field.Text;
    DS_INSERIR_DESLOCAMENTO.DataSet.FieldByName('data_deslocamento').AsString:= Edt_data.Text;
    DS_INSERIR_DESLOCAMENTO.DataSet.Post;

end;

procedure TFrmDeslocamento.DB_GRID_DESLOCAMENTOSDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var Balizador: integer;
begin
     Balizador:=StrToInt(DB_GRID_DESLOCAMENTOS.Columns[0].Field.Text);

    IF Qry_Deslocamentos.RowsAffected > 0  then
     IF Balizador mod 2 = 0 Then
     BEGIN
        DB_GRID_DESLOCAMENTOS.Canvas.Brush.Color:= CLInfobk;
        DB_GRID_DESLOCAMENTOS.Canvas.FillRect(Rect);
        DB_GRID_DESLOCAMENTOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
     END
     ELSE
      BEGIN
         DB_GRID_DESLOCAMENTOS.Canvas.Brush.Color:= CLMenu;
        DB_GRID_DESLOCAMENTOS.Canvas.FillRect(Rect);
        DB_GRID_DESLOCAMENTOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      END;
end;

procedure TFrmDeslocamento.Edt_pesquisaChange(Sender: TObject);
begin
      qry_deslocamentos.close;
      qry_deslocamentos.sql.clear;
      qry_deslocamentos.sql.add('select * from deslocamentos');
      qry_deslocamentos.sql.add('where descricao_deslocamento like :pdados');

      qry_deslocamentos.params.parambyname('pdados').asstring:='%'+edt_pesquisa.text+'%';
      qry_deslocamentos.open;
end;

procedure TFrmDeslocamento.FormShow(Sender: TObject);
begin

    Edt_pesquisa.SetFocus;

    Edt_idtecnico.Text:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[1].Text;
    Edt_nome_tecnico.Text:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[2].Text;
    edt_cidade_origem.Text:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[0].Text;
    Edt_data.Text:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[3].Text;


    qry_inserir_deslocamento.close;
    qry_inserir_deslocamento.sql.clear;
    qry_inserir_deslocamento.sql.add('select * from itens_deslocamentos id');
    qry_inserir_deslocamento.sql.add('where id.idtecnicos = :pid and id.data_deslocamento = :pdata');

    Qry_INSERIR_DESLOCAMENTO.ParamByName('pID').Value:= Edt_idtecnico.Text;
    Qry_INSERIR_DESLOCAMENTO.ParamByName('pData').Value:= FormatDateTime('yyyy-mm-dd',StrToDate(Edt_data.Text));
    Qry_INSERIR_DESLOCAMENTO.Open;


end;

end.
