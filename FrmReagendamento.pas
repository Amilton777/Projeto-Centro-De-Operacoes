unit FrmReagendamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  Tfrm_reagendamento = class(TForm)
    btn_reagendar: TBitBtn;
    QueryTemp: TFDQuery;
    MC_CALENDAR: TMonthCalendar;
    Edt_Data_reagendamento: TMaskEdit;
    Label1: TLabel;
    Memo_Obs: TMemo;
    Label2: TLabel;
    QryDuplicar: TFDQuery;
    DS_Duplicar: TDataSource;
    CB_STATUS: TComboBox;
    Label3: TLabel;
    QRY_STATUS: TFDQuery;
    CB_TECNICOS: TComboBox;
    Label4: TLabel;
    Bevel1: TBevel;
    QRY_TECNICOS: TFDQuery;
    procedure btn_reagendarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MC_CALENDARDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_reagendamento: Tfrm_reagendamento;

implementation

{$R *.dfm}

uses DataModule, FrmPrincipal, Frm_Edt_Servicos;

procedure Tfrm_reagendamento.btn_reagendarClick(Sender: TObject);
var x:integer;
Campo :string;
begin


  IF ((CB_STATUS.Text <> '') AND (CB_TECNICOS.TEXT <> '')) then
   BEGIN

    QueryTemp.Close;
    querytemp.sql.text := 'select * from operacoes op where op.idoperacoes = :pid';
    QueryTemp.Params.ParamByName('pID').AsString:= frm_painel_servicos.DB_GRID_SERVICOS.Fields[16].Text;
    QueryTemp.Open;

    // CLONA O REGISTRO
    QryDuplicar.Open;
    QryDuplicar.Insert;
    For x := 0 to Pred(QueryTemp.Fields.count) do
    begin
     Campo := QueryTemp.Fields[x].FieldName;
     QryDuplicar.FieldByName(CAmpo).Value := QueryTemp.FieldByName(Campo).Value;
   end;

    //Altera��es depois de clonar
    QryDuplicar.FieldByName('IDOPERACOES').Clear;
    QryDuplicar.FieldByName('OBSERVACAO').Clear;
    QryDuplicar.FieldByName('OBSERVACAO').Text:='REAGENDADO: '+ frm_painel_servicos.SB_LOGIN.Panels[2].Text+' REAGENDADO PARA: '+Edt_Data_reagendamento.Text;
    QryDuplicar.FieldByName('OBSERVACAO').Text:= QryDuplicar.FieldByName('OBSERVACAO').Text+' '+ Memo_Obs.Text;
    QryDuplicar.FieldByName('DATA_INICIAL').Clear;
    QryDuplicar.FieldByName('DATA_INICIAL').Text:=Edt_Data_reagendamento.Text;  //FormatDateTime('yyyy-mm-dd',StrToDate(Edt_Data_reagendamento.Text));
    QryDuplicar.FieldByName('STATUS').Clear;
    QryDuplicar.FieldByName('STATUS').Text:=CB_STATUS.TEXT;
    QryDuplicar.FieldByName('idtecnicos').clear;

    //Atribui um numero no DBEDIT 6 IDTECNICO A PARTIR DO COMBO BOX.
    dm.QRY_ID_TECNICO.Close;
    dm.QRY_ID_TECNICO.Params.ParamByName('nome').AsString:=CB_TECNICOS.Text;
    dm.QRY_ID_TECNICO.Open;

    QryDuplicar.FieldByName('idtecnicos').Text:= dm.QRY_ID_TECNICO.FieldByName('idtecnicos').AsString;
    QryDuplicar.FieldByName('idOrigemOperacao').Text:= QueryTemp.FieldByName('IDOPERACOES').Text;

    QryDuplicar.Post;


    FRM_EDITAR_OS.DBEdit11.Text:= '00';
    FRM_EDITAR_OS.DBEdit5.Text:=(DateToStr(date));
    frm_painel_servicos.DS_OPERACOES.DataSet.Post;

    messagedlg('REAGENDAMENTO CONCLU�DO COM SUCESSO! DATA: '+Edt_Data_reagendamento.Text+'',mtcustom,[mbok],0);
    CLOSE;
   END
    ELSE messagedlg('EXISTEM CAMPOS N�O PREENCHIDOS!'+Edt_Data_reagendamento.Text+'',mtcustom,[mbok],0);
end;

procedure Tfrm_reagendamento.FormShow(Sender: TObject);
begin
    MC_CALENDAR.Date:=(date+1);
    Edt_Data_reagendamento.Text:= DateToStr(date+1);


    QRY_STATUS.Close;
    QRY_STATUS.SQL.Clear;
    qry_status.sql.add('select status_os from status where (idstatus >= 1) and (idstatus <= 5)');
    QRY_STATUS.Open;
    //CARREGAR O COMBO BOX STATUS
    IF QRY_STATUS.RowsAffected > 0 then
        begin
        while not QRY_STATUS. eof do
         begin
          CB_STATUS.items.add(QRY_STATUS.fieldbyname('STATUS_OS').AsString);
          QRY_STATUS.next;
         end;
       end;
      QRY_STATUS.Free;

    QRY_TECNICOS.Close;
    QRY_TECNICOS.SQL.Clear;
    qry_tecnicos.sql.add('select nome_tecnico from tecnicos tec where tec.idtecnicos <> :pidtecnico');
    QRY_TECNICOS.Params.ParamByName('pIDtecnico').AsInteger:=0;
    QRY_TECNICOS.Open;

   //CARREGAR O COMBO BOX TECNICOS
    IF QRY_TECNICOS.RowsAffected > 0 then
        begin
        while not QRY_TECNICOS. eof do
         begin
          CB_TECNICOS.items.add(QRY_TECNICOS.fieldbyname('NOME_TECNICO').AsString);
          QRY_TECNICOS.next;
         end;
       end;
      QRY_TECNICOS.Free;

     //Seta o tecnico que estava na ultima O.S para reagendar no mesmo se for o caso.
     CB_TECNICOS.ItemIndex:=StrToInt(frm_editar_os.DBEDIT6.TEXT);
end;

procedure Tfrm_reagendamento.MC_CALENDARDblClick(Sender: TObject);
begin
    Edt_Data_reagendamento.Text:= DateToStr(MC_CALENDAR.Date);
end;

end.
