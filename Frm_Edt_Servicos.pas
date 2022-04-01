unit Frm_Edt_Servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.WindowsStore, Vcl.Grids, Vcl.DBGrids,
  IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP;

type
  TFRM_EDITAR_OS = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit1: TDBEdit;
    DBEdT_CONTRATO: TDBEdit;
    DBEDT_LOGRADOURO: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    EDT_ESTATUS: TDBEdit;
    DBEdit11: TDBEdit;
    CB_TECNICOS: TComboBox;
    DBMemo1: TDBMemo;
    CB_ORIGEM: TComboBox;
    CB_SERVICOS: TComboBox;
    CB_TIPO_PLANO: TComboBox;
    btn_cancelar: TBitBtn;
    btn_salvar: TBitBtn;
    QRY_ORIGEM: TFDQuery;
    QRY_SERVICOS: TFDQuery;
    QRY_TECNICOS: TFDQuery;
    QRY_TIPO_PLANO: TFDQuery;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btn_status: TBitBtn;
    DB_GRID_ITENS_ADD: TDBGrid;
    DS_ITENS_ADD: TDataSource;
    QRY_ITENS_ADD: TFDQuery;
    Label15: TLabel;
    btn_adcionais: TButton;
    Label16: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    QRY_DELETAR_ADICIONAIS: TFDQuery;
    QRY_BUSCA_DADOS: TFDQuery;
    QRY_PONTUACAO: TFDQuery;
    btn_log_tec: TBitBtn;
    BitBtn1: TBitBtn;
    IdFTP1: TIdFTP;
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB_ORIGEMChange(Sender: TObject);
    procedure CB_TECNICOSChange(Sender: TObject);
    procedure CB_SERVICOSChange(Sender: TObject);
    procedure CB_TIPO_PLANOChange(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure btn_statusClick(Sender: TObject);
    procedure btn_adcionaisClick(Sender: TObject);
    procedure DB_GRID_ITENS_ADDDblClick(Sender: TObject);
    procedure EDT_ESTATUSChange(Sender: TObject);
    procedure DBEdT_CONTRATOExit(Sender: TObject);
    procedure btn_log_tecClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_EDITAR_OS: TFRM_EDITAR_OS;

implementation

{$R *.dfm}

uses FrmInserirAdicionais, Frmlog_tecnico, FrmPrincipal,
  FrmTrocaStatus, DataModule , FrmFotosOS;


procedure TFRM_EDITAR_OS.BitBtn1Click(Sender: TObject);
begin
    ;
end;

procedure TFRM_EDITAR_OS.btn_adcionaisClick(Sender: TObject);
begin

    frm_novo_adicionais.showmodal;
end;

procedure TFRM_EDITAR_OS.btn_cancelarClick(Sender: TObject);
begin
    close;
end;

procedure TFRM_EDITAR_OS.btn_log_tecClick(Sender: TObject);
begin
    frm_log_interacao_tecnico.showmodal;
end;

procedure TFRM_EDITAR_OS.btn_salvarClick(Sender: TObject);
begin
    //SALVAR A NOVA O.S NO BANCO DE DADOS E SEGUIDA FECHAR O FORM.
    frm_painel_servicos.DS_OPERACOES.DataSet.Post;
    MessageDLg ('CONCLUODO COM SUCESSO', mtInformation, [mbOK], 0);
      frm_painel_servicos.DB_GRID_SERVICOS.Refresh;
    CLOSE;
end;

procedure TFRM_EDITAR_OS.btn_statusClick(Sender: TObject);
begin
     frm_Troca_Status.showmodal;
     close;
end;

procedure TFRM_EDITAR_OS.CB_ORIGEMChange(Sender: TObject);
begin
    //
    DBEdit7.Text:=IntToStr(CB_ORIGEM.Items.IndexOf(CB_ORIGEM.text));

end;

procedure TFRM_EDITAR_OS.CB_SERVICOSChange(Sender: TObject);
var index: integer;
begin
    index:= (CB_SERVICOS.Items.IndexOf(CB_SERVICOS.text));
    DBEdit8.Text:=IntToStr(index);

    IF ((INDEX = 3) OR (INDEX = 4) or (index=5)or (index=6)) then
    Begin
      DBEdit7.Text:= IntToStr(7);
      CB_ORIGEM.ItemIndex:=7;

    End;
end;

procedure TFRM_EDITAR_OS.CB_TECNICOSChange(Sender: TObject);
var index: integer;
begin
  //Atribui um numero no DBEDIT 6 IDTECNICO A PARTIR DO COMBO BOX.
  dm.QRY_ID_TECNICO.Close;
  dm.QRY_ID_TECNICO.Params.ParamByName('nome').AsString:=CB_TECNICOS.Text;
  dm.QRY_ID_TECNICO.Open;


  DBEdit6.Text:=dm.QRY_ID_TECNICO.FieldByName('idtecnicos').AsString;
end;

procedure TFRM_EDITAR_OS.CB_TIPO_PLANOChange(Sender: TObject);
var index: integer;
begin
    index:= (CB_TIPO_PLANO.Items.IndexOf(CB_TIPO_PLANO.text));
    DBEdit9.Text:=IntToStr(index);
end;

procedure TFRM_EDITAR_OS.EDT_ESTATUSChange(Sender: TObject);
VAR Total_Pontos: REAL;
begin

end;

procedure TFRM_EDITAR_OS.DBEdT_CONTRATOExit(Sender: TObject);
begin
    btn_salvar.SetFocus;

      QRY_BUSCA_DADOS.Close;
      QRY_BUSCA_DADOS.SQL.Clear;
      QRY_BUSCA_DADOS.SQL.Add('select * from facilidade where contrato = :pcontrato');
      QRY_BUSCA_DADOS.ParamByName('pCONTRATO').AsString:= DBEdT_CONTRATO.Text;
      QRY_BUSCA_DADOS.Open;


      IF QRY_BUSCA_DADOS.RowsAffected> 0 then
        BEGIN

          DBMemo1.Lines.Add('NOME DO CLIENTE:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('NOME_CLIENTE').AsString);
          DBMemo1.Lines.Add('----------------------------------------------------');
          DBMemo1.Lines.Add('COMPLEMENTO:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('COMPLEMENTO').AsString);
          DBMemo1.Lines.Add('----------------------------------------------------');
          DBMemo1.Lines.Add('CIDADE DA O.S:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('CIDADE').AsString);
          DBMemo1.Lines.Add('----------------------------------------------------');


          DBEDT_LOGRADOURO.Text:=QRY_BUSCA_DADOS.fieldbyname('LOGRADOURO').AsString;
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+', ';
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+QRY_BUSCA_DADOS.fieldbyname('NUMERO').AsString;
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+' - ';
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+QRY_BUSCA_DADOS.fieldbyname('BAIRRO').AsString;

          frm_painel_servicos.DS_OPERACOES.DataSet.Post;
        END;
end;

procedure TFRM_EDITAR_OS.DBEdit6Exit(Sender: TObject);
begin
//Atribui um numero no DBEDIT 6 IDTECNICO A PARTIR DO COMBO BOX.
    DM.QRY_NOME_TECNICO.Close;
    DM.QRY_NOME_TECNICO.Params.ParamByName('id').AsString:= DBEdit6.Text;
    DM.QRY_NOME_TECNICO.Open;


    CB_TECNICOS.ItemIndex:=CB_TECNICOS.Items.IndexOf(DM.QRY_NOME_TECNICO.FieldByName('nome_tecnico').AsString);
end;

procedure TFRM_EDITAR_OS.DBEdit7Exit(Sender: TObject);
begin
    CB_ORIGEM.ItemIndex:=StrToInt(DBEdit7.Text);
end;

procedure TFRM_EDITAR_OS.DBEdit8Exit(Sender: TObject);
begin
    CB_SERVICOS.ItemIndex:=StrToInt(DBEdit8.Text);
end;

procedure TFRM_EDITAR_OS.DBEdit9Exit(Sender: TObject);
begin
    CB_TIPO_PLANO.ItemIndex:=StrToInt(DBEdit9.Text);
end;

procedure TFRM_EDITAR_OS.DB_GRID_ITENS_ADDDblClick(Sender: TObject);
begin

    if (Application.MessageBox('Deseja realmente excluir este registro?',
    'Confirmação', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
    DS_ITENS_ADD.DataSet.Delete;


end;

procedure TFRM_EDITAR_OS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      frm_painel_servicos.DS_OPERACOES.DataSet.Cancel;

      IF  DBEdT_CONTRATO.Text = '' Then
       Begin
          frm_painel_servicos.DS_OPERACOES.DataSet.Delete;
       End;

end;

procedure TFRM_EDITAR_OS.FormCreate(Sender: TObject);
VAR CONTADOR: INTEGER;
NOME_TECNICOS, ORIGEM, SERVICOS, TIPO_PLANO:array[0..100] of STRING;
begin
      CONTADOR:=0;
      QRY_TECNICOS.Close;
      QRY_TECNICOS.SQL.Clear;
      QRY_TECNICOS.SQL.Add('select * from tecnicos');
      QRY_TECNICOS.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_TECNICOS.RowsAffected > 0 then
        begin
        while not QRY_TECNICOS. eof do
         begin
          CONTADOR:= CONTADOR +1;
          CB_TECNICOS.items.add(QRY_TECNICOS.fieldbyname('NOME_TECNICO').AsString);
          NOME_TECNICOS[CONTADOR]:= (QRY_TECNICOS.fieldbyname('NOME_TECNICO').AsString);
          QRY_TECNICOS.next;
         end;
       end;
      CB_TECNICOS.Text:= NOME_TECNICOS[1];
      QRY_TECNICOS.Free;


      CONTADOR:=0;
      QRY_ORIGEM.Close;
      QRY_ORIGEM.SQL.Clear;
      QRY_ORIGEM.SQL.Add('select * from origem');
      QRY_ORIGEM.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_ORIGEM.RowsAffected > 0 then
        begin
        while not QRY_ORIGEM. eof do
         begin
          CONTADOR:= CONTADOR +1;
          CB_ORIGEM.items.add(QRY_ORIGEM.fieldbyname('DES_ORIGEM').AsString);
          ORIGEM[CONTADOR]:= (QRY_ORIGEM.fieldbyname('DES_ORIGEM').AsString);
          QRY_ORIGEM.next;
         end;
       end;
      CB_ORIGEM.Text:= ORIGEM[1];
      QRY_ORIGEM.Free;

     CONTADOR:=0;
     QRY_SERVICOS.Close;
     QRY_SERVICOS.SQL.Clear;
     QRY_SERVICOS.SQL.Add('select des_servico from servicos');
     QRY_SERVICOS.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_SERVICOS.RowsAffected > 0 then
        begin
        while not QRY_SERVICOS. eof do
         begin
          CONTADOR:= CONTADOR +1;
          CB_SERVICOS.items.add(QRY_SERVICOS.fieldbyname('DES_SERVICO').AsString);
          SERVICOS[CONTADOR]:= (QRY_SERVICOS.fieldbyname('DES_SERVICO').AsString);
          QRY_SERVICOS.next;
         end;
       end;
      CB_SERVICOS.Text:= SERVICOS[1];
      QRY_SERVICOS.Free;


     CONTADOR:=0;
     QRY_TIPO_PLANO.Close;
     QRY_TIPO_PLANO.SQL.Clear;
     QRY_TIPO_PLANO.SQL.Add('select desc_plano from planos');
     QRY_TIPO_PLANO.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_TIPO_PLANO.RowsAffected > 0 then
        begin
        while not QRY_TIPO_PLANO. eof do
         begin
          CONTADOR:= CONTADOR +1;
          CB_TIPO_PLANO.items.add(QRY_TIPO_PLANO.fieldbyname('DESC_PLANO').AsString);
          TIPO_PLANO[CONTADOR]:= (QRY_TIPO_PLANO.fieldbyname('DESC_PLANO').AsString);
          QRY_TIPO_PLANO.next;
         end;
       end;
      CB_TIPO_PLANO.Text:= TIPO_PLANO[1];
      QRY_TIPO_PLANO.Free;


end;

procedure TFRM_EDITAR_OS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     //FECHAR O FORM
      IF KEY = 27 then
        Close;

      //Salvar a nova O.S
  //    IF key = 13 then
  //      btn_salvar.Click;

      IF key = 121 then
        btn_status.Click;

      IF key = 122 then
        btn_adcionais.Click;
end;

procedure TFRM_EDITAR_OS.FormShow(Sender: TObject);
begin
    DM.QRY_NOME_TECNICO.Close;
    DM.QRY_NOME_TECNICO.Params.ParamByName('id').AsString:= DBEdit6.Text;
    DM.QRY_NOME_TECNICO.Open;


    CB_TECNICOS.ItemIndex:=CB_TECNICOS.Items.IndexOf(DM.QRY_NOME_TECNICO.FieldByName('nome_tecnico').AsString);

    CB_ORIGEM.ItemIndex:=StrToInt(DBEdit7.Text);
    CB_SERVICOS.ItemIndex:=StrToInt(DBEdit8.Text);
    CB_TIPO_PLANO.ItemIndex:=StrToInt(DBEdit9.Text);

    QRY_ITENS_ADD.Close;
    QRY_ITENS_ADD.SQL.Clear;
    QRY_ITENS_ADD.SQL.Add('select id.idoperacoes, id.idadicionais,ad.descricao, id.pontuacao');
    QRY_ITENS_ADD.SQL.Add('from itens_adicionais id, adicionais ad');
    QRY_ITENS_ADD.SQL.Add('where (id.idadicionais = ad.idadicionais) and (id.idoperacoes = :pid)');

    QRY_ITENS_ADD.ParamByName('pID').Value:= DBEdit1.Text;
    QRY_ITENS_ADD.Open;



end;

end.
