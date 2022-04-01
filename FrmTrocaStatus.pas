unit FrmTrocaStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  Tfrm_Troca_Status = class(TForm)
    DB_GRID_STAUS: TDBGrid;
    QRY_STATUS: TFDQuery;
    DS_STATUS: TDataSource;
    EDT_CONTRATO: TDBEdit;
    EDT_ESTATUS: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    QRY_PONTUACAO: TFDQuery;
    QRY_DELETAR_REAGENDAMENTO: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DB_GRID_STAUSDblClick(Sender: TObject);
    procedure DB_GRID_STAUSDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Troca_Status: Tfrm_Troca_Status;

implementation

{$R *.dfm}

uses DataModule, FrmPrincipal, Frm_Edt_Servicos, FrmReagendamento;

procedure Tfrm_Troca_Status.DB_GRID_STAUSDblClick(Sender: TObject);
VAR Total_Pontos : real;
begin
     frm_painel_servicos.DS_OPERACOES.DataSet.Edit;

     EDT_ESTATUS.Text:=  DB_GRID_STAUS.Fields[1].TEXT;

     Total_Pontos:=0;

     //Deletar poss�vel reagendamento
     QRY_DELETAR_REAGENDAMENTO.Close;
     QRY_DELETAR_REAGENDAMENTO.SQL.Clear;
     QRY_DELETAR_REAGENDAMENTO.SQL.Add('Delete from operacoes where idOrigemOperacao =:id');
     QRY_DELETAR_REAGENDAMENTO.Params.ParamByName('ID').AsString:= frm_editar_os.DBEdit1.Text;

     QRY_DELETAR_REAGENDAMENTO.ExecSQL;

     if EDT_ESTATUS.Text ='FINALIZADO' then
      BEGIN
        QRY_PONTUACAO.Close;
        QRY_PONTUACAO.SQL.Clear;
        QRY_PONTUACAO.SQL.Add('select sum(pontuacao) from itens_adicionais where idoperacoes = :pidoperacao ');
        QRY_PONTUACAO.ParamByName('pIDOPERACAO').AsString:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[16].Text;
        QRY_PONTUACAO.Open;

        Total_Pontos:= QRY_PONTUACAO.FieldByName('SUM(PONTUACAO)').AsFloat;

        QRY_PONTUACAO.Close;
        QRY_PONTUACAO.SQL.Clear;
        QRY_PONTUACAO.SQL.Add('select pontuacao from servicos where des_servico = :pdesc_servico');
        QRY_PONTUACAO.ParamByName('pDESC_SERVICO').AsString:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[10].Text;
        QRY_PONTUACAO.Open;

        Total_Pontos:= Total_Pontos + QRY_PONTUACAO.FieldByName('PONTUACAO').AsFloat;



        FRM_EDITAR_OS.DBEdit11.Text:= FloatToStr(Total_Pontos);
        FRM_EDITAR_OS.DBEdit5.Text:= (DateToStr(date));

        frm_painel_servicos.DS_OPERACOES.DataSet.Post;

        MessageDLg ('CONCLUIDO COM SUCESSO', mtInformation, [mbOK], 0);

      END
     Else
      begin
        IF (EDT_ESTATUS.Text ='AUSENTE SEM CONTATO') or (EDT_ESTATUS.Text ='CHOVENDO') or (EDT_ESTATUS.Text ='RISCO P/ O TECNICO')
        or (EDT_ESTATUS.Text ='CLIENTE REAGENDOU') or (EDT_ESTATUS.Text ='TROCA DE EQUIPE')or (EDT_ESTATUS.Text ='FIM DO DIA') then
          begin
           frm_reagendamento.showmodal;

          end
          Else IF (EDT_ESTATUS.Text ='CLIENTE CANCELOU') or (EDT_ESTATUS.Text ='DISPENSOU A VISITA')
                or (EDT_ESTATUS.Text ='CONTRATO BLOQUEADO') or (EDT_ESTATUS.Text ='FORA DE COBERTURA')
                or (EDT_ESTATUS.Text ='NAP SEM PORTA') or (EDT_ESTATUS.Text ='COMERCIAL') OR (EDT_ESTATUS.Text ='INFRA') Then
                Begin
                    FRM_EDITAR_OS.DBEdit11.Text:= '00';
                    FRM_EDITAR_OS.DBEdit5.Text:=(DateToStr(date));
                    frm_painel_servicos.DS_OPERACOES.DataSet.Post;
                End
              else
                begin
                    FRM_EDITAR_OS.DBEdit11.Text:= '00';
                    FRM_EDITAR_OS.DBEdit5.Text:='';
                    frm_painel_servicos.DS_OPERACOES.DataSet.Post;
                end;



      end;

end;

procedure Tfrm_Troca_Status.DB_GRID_STAUSDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

VAR Nome : string;
begin

   IF QRY_status.RowsAffected > 0  then
     Nome:= (DB_GRID_STAUS.Columns[1].Field.Text);

 {  IF Nome = 'PENDENTE' then
    begin
     DB_GRID_SERVICOS.Canvas.Brush.Color:= CLSILVER;
     DB_GRID_SERVICOS.Canvas.FillRect(Rect);
     DB_GRID_SERVICOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;     }

    IF (Nome = 'CLUSTER - MANHA')OR (Nome = 'AGENDADO - MANHA' ) then
    begin
     //DB_GRID_SERVICOS.Canvas.Brush.Color:= CLskyblue;
     DB_GRID_STAUS.Canvas.Brush.Color:=CLskyblue;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

    IF (Nome = 'AGENDADO - TARDE')OR(Nome = 'CLUSTER - TARDE') then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= CLHighlight;
     DB_GRID_STAUS.Canvas.Font.Color:= CLWhite;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

   IF Nome = 'EM ANDAMENTO' then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= CLTeal;
     DB_GRID_STAUS.Canvas.Font.Color:= CLINFOBK;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;


    IF Nome = 'NAO AGENDADO' then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= $00FFE6E6;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);

    end;

    IF (Nome = 'CLIENTE CANCELOU') or (Nome = 'AUSENTE SEM CONTATO')or (Nome = 'CHOVENDO')
    or (Nome = 'RISCO P/ O TECNICO')or (Nome = 'CLIENTE REAGENDOU')or (Nome = 'DISPENSOU A VISITA')
    or (Nome = 'TROCA DE EQUIPE') then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= CLInfobk;
     DB_GRID_STAUS.Canvas.Font.Color:= CLblack;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

  IF (Nome = 'CONTRATO BLOQUEADO')or(Nome = 'FORA DE COBERTURA')or(Nome = 'NAP SEM PORTA')
   or(Nome = 'FIM DO DIA') or(Nome = 'FORA DE ROTA')  then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= $008080FF; //$00C4C4FF;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

   IF (Nome = 'SEM EFEITO') then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= CLblack;
     DB_GRID_STAUS.Canvas.Font.Color:= CLinfobk;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

  IF (Nome = 'COMERCIAL')or (Nome = 'INFRA')or (Nome = 'ALMOXARIFADO')  then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= $00B8C7C1; //$000E7DC2;
     DB_GRID_STAUS.Canvas.Font.Color:= CLinfobk;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

    IF (Nome = 'FINALIZADO') then
    begin
     DB_GRID_STAUS.Canvas.Brush.Color:= CLGreen;
     DB_GRID_STAUS.Canvas.Font.Color:= CLWhite;
     DB_GRID_STAUS.Canvas.FillRect(Rect);
     DB_GRID_STAUS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

end;


procedure Tfrm_Troca_Status.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key = 27 then
     close;
end;

procedure Tfrm_Troca_Status.FormShow(Sender: TObject);
begin
      //CARREGAR A LISTA DE STATUS
      QRY_STATUS.Close;
      QRY_STATUS.Open;
end;

end.
