unit FrmEscalas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmEscala = class(TForm)
    MC_CALENDARIO: TMonthCalendar;
    CB_TECNICOS: TComboBox;
    Label3: TLabel;
    Panel1: TPanel;
    QRY_TECNICOS: TFDQuery;
    DBGRID_ESCALA: TDBGrid;
    QRY_ESCALA: TFDQuery;
    DS_ESCALA: TDataSource;
    Edt_data: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edt_dia_semana: TEdit;
    btn_incluir: TBitBtn;
    QRY_INSERIR_ESCALA: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure MC_CALENDARIODblClick(Sender: TObject);
    procedure btn_incluirClick(Sender: TObject);
    procedure DBGRID_ESCALADblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function GerarData():string;
  public
    { Public declarations }
  end;

var
  FrmEscala: TFrmEscala;

implementation

{$R *.dfm}

uses datamodule;

procedure TFrmEscala.btn_incluirClick(Sender: TObject);
begin
    if (Edt_data.Text <> '')and (Edt_dia_semana.Text<> '')and (CB_TECNICOS.Text <> '') then
     BEGIN
         QRY_INSERIR_ESCALA.Open;
         QRY_INSERIR_ESCALA.Insert;
         QRY_INSERIR_ESCALA.FieldByName('idESCALAS').AsString:='';
         QRY_INSERIR_ESCALA.FieldByName('DATA_TRABALHO').AsString:=Edt_data.Text;//FormatDateTime('yyyy-mm-dd',StrToDate(Edt_data.Text));
         QRY_INSERIR_ESCALA.FieldByName('DIA_SEMANA').AsString:=Edt_dia_semana.Text;

         //Busca o id do tecnico para a inser��o na escala.
         DM.QRY_ID_TECNICO.CLOSE;
         DM.QRY_ID_TECNICO.Params.ParamByName('nome').ASSTRING := CB_TECNICOS.Text;
         DM.QRY_ID_TECNICO.OPEN;

         QRY_INSERIR_ESCALA.FieldByName('idtecnicos').AsString:= DM.QRY_ID_TECNICO.fieldbyname('idtecnicos').AsString;

         QRY_INSERIR_ESCALA.POST;

         DS_ESCALA.DataSet.Refresh;
         DBGRID_ESCALA.Refresh;

     END
    ELSE
     ShowMessage('Existem campos n�o preenchidos!')
end;

procedure TFrmEscala.DBGRID_ESCALADblClick(Sender: TObject);
begin
    if (Application.MessageBox('Deseja realmente excluir este registro?',
  'Confirma��o', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
    DS_ESCALA.DataSet.Delete;
end;

procedure TFrmEscala.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       DS_ESCALA.DataSet.Cancel;
end;

procedure TFrmEscala.FormShow(Sender: TObject);
begin
    //Alimenta grid com as datas de escala a partir da data de hoje.
    QRY_ESCALA.Close;
    QRY_ESCALA.Params.ParamByName('DATA').AsDate :=DATE;
    QRY_ESCALA.Open;


    MC_CALENDARIO.Date:=DATE;
    Edt_data.Text:= DateToStr(date);

    QRY_TECNICOS.Close;
    QRY_TECNICOS.SQL.Clear;
    QRY_TECNICOS.SQL.Add('select nome_tecnico from tecnicos tec where tec.idtecnicos <> :pidtecnico');
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
end;

procedure TFrmEscala.MC_CALENDARIODblClick(Sender: TObject);
begin
    Edt_data.Text:=DateToStr(MC_CALENDARIO.Date);
    Edt_dia_semana.Text:= GerarData();

end;

function TFrmEscala.GerarData():string;
var
dias: array[1..7] of string;
begin
  dias[1]:='Domingo';
  dias[2]:='Segunda-feira';
  dias[3]:='Ter�a-feira';
  dias[4]:='Quarta-feira';
  dias[5]:='Quinta-feira';
  dias[6]:='Sexta-feira';
  dias[7]:='Sabado';

   //Pulo do gato;
  Result:=(dias[DayOfWeek(StrToDate(Edt_data.Text))]);

end;

end.
