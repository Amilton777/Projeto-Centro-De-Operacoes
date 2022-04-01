unit FrmCad_Servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw;

type
  Tfrm_nova_ordem_servico = class(TForm)
    DBEdit1: TDBEdit;
    DBEdT_CONTRATO: TDBEdit;
    DBEDT_LOGRADOURO: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEDT_STATUS: TDBEdit;
    DBEdit11: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DS_OPERACAO: TDataSource;
    CB_TECNICOS: TComboBox;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CB_ORIGEM: TComboBox;
    Label9: TLabel;
    CB_SERVICOS: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    CB_TIPO_PLANO: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    btn_cancelar: TBitBtn;
    btn_salvar: TBitBtn;
    QRY_ORIGEM: TFDQuery;
    QRY_SERVICOS: TFDQuery;
    QRY_TECNICOS: TFDQuery;
    QRY_TIPO_PLANO: TFDQuery;
    bvl_campos: TBevel;
    bvl_botoes: TBevel;
    QRY_STATUS: TFDQuery;
    CB_STATUS: TComboBox;
    QRY_BUSCA_DADOS: TFDQuery;
    btn_minha_equipe: TBitBtn;
    btn_todos: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CB_TECNICOSChange(Sender: TObject);
    procedure CB_ORIGEMChange(Sender: TObject);
    procedure CB_SERVICOSChange(Sender: TObject);
    procedure CB_TIPO_PLANOChange(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CB_STATUSChange(Sender: TObject);
    procedure DBEdT_CONTRATOExit(Sender: TObject);
    procedure btn_minha_equipeClick(Sender: TObject);
    procedure btn_todosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_nova_ordem_servico: Tfrm_nova_ordem_servico;

implementation

{$R *.dfm}

uses DataModule, FrmLogin;

procedure Tfrm_nova_ordem_servico.btn_minha_equipeClick(Sender: TObject);
begin
     try
     //Selecionar tecnicos pela equipe se 0 todos se n�o pelo tecnico selecionado.

        QRY_TECNICOS.Close;
        QRY_TECNICOS.SQL.Clear;
        QRY_TECNICOS.SQL.Text:='select nome_tecnico from tecnicos tec where tec.idequipes = :pidtecnico';
        QRY_TECNICOS.Params.ParamByName('pidtecnico').AsInteger:= equipe_user;
        QRY_TECNICOS.Open;

    //limpando o combo box
    CB_TECNICOS.Items.Clear();

    //CARREGAR O COMBO BOX "TECNICOS"
    IF QRY_TECNICOS.RowsAffected > 0 then
        begin
        while not QRY_TECNICOS. eof do
         begin
          CB_TECNICOS.items.add(QRY_TECNICOS.fieldbyname('NOME_TECNICO').AsString);
          QRY_TECNICOS.next;
         end;
       end;

     Except on E: Exception do
        ShowMessage('Erro:' + E.Message );

     end;
end;

procedure Tfrm_nova_ordem_servico.btn_salvarClick(Sender: TObject);
begin
    //SALVAR A NOVA O.S NO BANCO DE DADOS E SEGUIDA FECHAR O FORM.

   try
    IF DBEDT_STATUS.Text <> 'PENDENTE' then
    BEGIN
         IF DBEdit6.Text <> '0' THEN
           begin
               DS_OPERACAO.DataSet.Edit;
               DS_OPERACAO.DataSet.Post;
               MessageDLg ('CONCLUODO COM SUCESSO', mtInformation, [mbOK], 0);

               //DS_OPERACAO.DataSet.Open;
               DS_OPERACAO.DataSet.Insert;

               DBEdit6.Text:=IntToStr(CB_TECNICOS.Items.IndexOf(CB_TECNICOS.text));

               DBEdit7.Text:=IntToStr(CB_ORIGEM.Items.IndexOf(CB_ORIGEM.text));
               DBEdit8.Text:=IntToStr(CB_SERVICOS.Items.IndexOf(CB_SERVICOS.text));
               DBEdit9.Text:=IntToStr(CB_TIPO_PLANO.Items.IndexOf(CB_TIPO_PLANO.text));


               DBEdit4.Text:= FormatDateTime('dd/mm/yyyy', Date);
               DBEDT_STATUS.Text:='';

               DS_OPERACAO.DataSet.Post;
               DS_OPERACAO.DataSet.Edit;

    DBEdT_CONTRATO.SetFocus;

           end
          else
           ShowMessage('Sua O.S esta sem tecnico definido!');

    END

    ELSE
     ShowMessage('STATUS DA O.S ESTA COMO PENDENTE!!!');

    Except on E: Exception do
        ShowMessage('Erro:' + E.Message );

     end;

end;

procedure Tfrm_nova_ordem_servico.btn_todosClick(Sender: TObject);
begin

    Try
     QRY_TECNICOS.Close;
     QRY_TECNICOS.SQL.Clear;
     QRY_TECNICOS.SQL.Text:='select nome_tecnico from tecnicos';
     QRY_TECNICOS.Open;

    //limpando o combo box
    CB_TECNICOS.Items.Clear();

    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_TECNICOS.RowsAffected > 0 then
        begin
        while not QRY_TECNICOS. eof do
         begin
          CB_TECNICOS.items.add(QRY_TECNICOS.fieldbyname('NOME_TECNICO').AsString);
          QRY_TECNICOS.next;
         end;
       end;

    Except on E: Exception do
        ShowMessage('Erro:'+E.Message);


    End;
end;

procedure Tfrm_nova_ordem_servico.CB_ORIGEMChange(Sender: TObject);
begin
  // Pegando posi��o no combobox ORIGEM e atribuindo.
  DBEdit7.Text:=IntToStr((CB_ORIGEM.Items.IndexOf(CB_ORIGEM.text)));
end;

procedure Tfrm_nova_ordem_servico.CB_SERVICOSChange(Sender: TObject);
VAR INDEX_COMBO_SERVICOS :INTEGER;
begin

  //Pegando o indice para conferir
  INDEX_COMBO_SERVICOS:=CB_SERVICOS.Items.IndexOf(CB_SERVICOS.text);

  // Pegando posi��o no combobox SERVI�OS e atribuindo.
  DBEdit8.Text:=IntToStr((CB_SERVICOS.Items.IndexOf(CB_SERVICOS.text)));


  IF ((INDEX_COMBO_SERVICOS = 3) OR (INDEX_COMBO_SERVICOS = 4) or (INDEX_COMBO_SERVICOS=5)or (INDEX_COMBO_SERVICOS=6)) then
    Begin

      //Se for INSTALA��O OU TRANSFERENCIA ATRIBUIR ORIGEM COMERCIAL
      DBEdit7.Text:= IntToStr(7);
      CB_ORIGEM.ItemIndex:=7;

    End;

end;

procedure Tfrm_nova_ordem_servico.CB_STATUSChange(Sender: TObject);
begin
    DBEDT_STATUS.Text:=(CB_STATUS.Text);
end;

procedure Tfrm_nova_ordem_servico.CB_TECNICOSChange(Sender: TObject);
begin

  //Atribui um numero no DBEDIT6 "IDTECNICO" A PARTIR DO COMBO BOX.
  dm.QRY_ID_TECNICO.Close;                               //Pegando nome selecionado no combo box
  dm.QRY_ID_TECNICO.Params.ParamByName('nome').AsString:=CB_TECNICOS.Text;
  dm.QRY_ID_TECNICO.Open;

  //....Atribuindo
  DBEdit6.Text:=dm.QRY_ID_TECNICO.FieldByName('idtecnicos').AsString;

end;

procedure Tfrm_nova_ordem_servico.CB_TIPO_PLANOChange(Sender: TObject);
begin

  // Pegando posi��o no combobox TIPO_DE_PLANO e atribuindo.
  DBEdit9.Text:=IntToStr((CB_TIPO_PLANO.Items.IndexOf(CB_TIPO_PLANO.text)));
end;

procedure Tfrm_nova_ordem_servico.DBEdT_CONTRATOExit(Sender: TObject);
begin
    Try
      //Selecionando o endere�o automaticamente a partir de dados herdados tabela FACILIDADE
      QRY_BUSCA_DADOS.Close;
      QRY_BUSCA_DADOS.SQL.Clear;
      QRY_BUSCA_DADOS.SQL.Add('select * from facilidade where contrato = :pcontrato');
      QRY_BUSCA_DADOS.ParamByName('pCONTRATO').AsString:= DBEdT_CONTRATO.Text;
      QRY_BUSCA_DADOS.Open;


      //Adicionando alguns dados herdados no campo de observa��o.
      IF QRY_BUSCA_DADOS.RowsAffected> 0 then
        BEGIN
          DBMemo1.Lines.Add('NOME DO CLIENTE:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('NOME_CLIENTE').AsString);
          DBMemo1.Lines.Add('      ');
          DBMemo1.Lines.Add('COMPLEMENTO:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('COMPLEMENTO').AsString);
          DBMemo1.Lines.Add('      ');
          DBMemo1.Lines.Add('CLIENTE DA O.S:');
          DBMemo1.Lines.Add(QRY_BUSCA_DADOS.fieldbyname('CIDADE').AsString);
          DBMemo1.Lines.Add('      ');

          DBEDT_LOGRADOURO.Text:= QRY_BUSCA_DADOS.fieldbyname('LOGRADOURO').AsString;
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+', ';
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+QRY_BUSCA_DADOS.fieldbyname('NUMERO').AsString;
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+' - ';
          DBEDT_LOGRADOURO.Text:= DBEDT_LOGRADOURO.Text+QRY_BUSCA_DADOS.fieldbyname('BAIRRO').AsString;

          //Gravando so dados
          DS_OPERACAO.DataSet.Post;
          // colocando a tabela novamente em Edita para continuar o cadastro.
          DS_OPERACAO.DataSet.Edit;

        END;

    Except on E:Exception do
        ShowMessage('Erro:'+ E.Message);

    End;


end;

procedure Tfrm_nova_ordem_servico.DBEdit6Exit(Sender: TObject);
var index: integer;
begin
     //Buscando o nome do t�cnico a partir de um ID.
    DM.QRY_NOME_TECNICO.Close;
    DM.QRY_NOME_TECNICO.Params.ParamByName('id').AsString:= DBEdit6.Text;
    DM.QRY_NOME_TECNICO.Open;

    //Atribuindo um nome ao combo box t�cnicos.
    CB_TECNICOS.ItemIndex:=CB_TECNICOS.Items.IndexOf(DM.QRY_NOME_TECNICO.FieldByName('nome_tecnico').AsString);

end;

procedure Tfrm_nova_ordem_servico.DBEdit7Exit(Sender: TObject);
begin
     //Atribui um numero no DBEDIT7 ORIGEM A PARTIR DO COMBO BOX.
    CB_ORIGEM.ItemIndex:=StrToInt(DBEdit7.Text);

end;

procedure Tfrm_nova_ordem_servico.DBEdit8Exit(Sender: TObject);
   var index: integer;
begin
     //Atribui um numero no DBEDIT 7 ORIGEM A PARTIR DO COMBO BOX.
    INDEX:= StrToInt(DBEdit8.Text);
    CB_SERVICOS.ItemIndex:=INDEX;

end;

procedure Tfrm_nova_ordem_servico.DBEdit9Exit(Sender: TObject);
begin
     //Atribui um numero no DBEDIT9 TIPO_SERVICO A PARTIR DO COMBO BOX.
        CB_TIPO_PLANO.ItemIndex:=StrToInt(DBEdit9.Text);

end;
procedure Tfrm_nova_ordem_servico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    //Caso o Usuario feche o form sem preencher o contrato OR o endere�o deletar o registro.
    DS_OPERACAO.DataSet.Cancel;

    IF (DBEdT_CONTRATO.Text = '') or (DBEDT_LOGRADOURO.Text ='') Then
       Begin
          DS_OPERACAO.DataSet.Delete;
       End;
end;

procedure Tfrm_nova_ordem_servico.FormCreate(Sender: TObject);
begin

      // Trazer os dados para o combox T�cnicos
      QRY_TECNICOS.Close;
      QRY_TECNICOS.SQL.Clear;
      QRY_TECNICOS.SQL.Add('Select * from tecnicos');
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


     // Trazer os dados para o combox Origem
      QRY_ORIGEM.Close;
      QRY_ORIGEM.SQL.Clear;
      QRY_ORIGEM.SQL.Add('Select * from origem');
      QRY_ORIGEM.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_ORIGEM.RowsAffected > 0 then
        begin
        while not QRY_ORIGEM. eof do
         begin
          CB_ORIGEM.items.add(QRY_ORIGEM.fieldbyname('DES_ORIGEM').AsString);
          QRY_ORIGEM.next;
         end;
       end;

      // Trazer os dados para o combox Servi�os
     QRY_SERVICOS.Close;
     QRY_SERVICOS.SQL.Clear;
     QRY_SERVICOS.SQL.Add('select des_servico from servicos');
     QRY_SERVICOS.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_SERVICOS.RowsAffected > 0 then
        begin
        while not QRY_SERVICOS. eof do
         begin
          CB_SERVICOS.items.add(QRY_SERVICOS.fieldbyname('DES_SERVICO').AsString);
          QRY_SERVICOS.next;
         end;
       end;

     // Trazer os dados para o combox Planos
     QRY_TIPO_PLANO.Close;
     QRY_TIPO_PLANO.SQL.Clear;
     QRY_TIPO_PLANO.SQL.Add('select desc_plano from planos');
     QRY_TIPO_PLANO.Open;

    //CARREGAR O COMBO BOX PLANOS
    IF QRY_TIPO_PLANO.RowsAffected > 0 then
        begin
        while not QRY_TIPO_PLANO. eof do
         begin
          CB_TIPO_PLANO.items.add(QRY_TIPO_PLANO.fieldbyname('DESC_PLANO').AsString);
          QRY_TIPO_PLANO.next;
         end;
       end;

    // Trazer os dados para o combox status
      QRY_STATUS.Close;
      QRY_STATUS.SQL.Clear;
      QRY_STATUS.SQL.Add('select status_os from status');
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



end;

procedure Tfrm_nova_ordem_servico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  //  ShowMessage(IntToStr(key));

      //FECHAR O FORM
      IF KEY = 27 then
        Close;

      //Salvar a nova O.S
      IF key = 107 then
        btn_salvar.Click;

end;

procedure Tfrm_nova_ordem_servico.FormShow(Sender: TObject);
begin

    //Inicializando o forma con data e outras informa��es padr�es
    DS_OPERACAO.DataSet.Open;
    DS_OPERACAO.DataSet.Insert;

    //Data no form
    DBEdit4.Text:= FormatDateTime('dd/mm/yyyy', Date);
    //Status inicial da ordem
    DBEDT_STATUS.Text:= 'PENDENTE';
    DBEdit11.Text:= '0';

    //Inicializando Origem, tipo, origem,tecnico
    DBEdit6.Text:= '0';
    DBEdit7.Text:= '1';
    DBEdit8.Text:= '1';
    DBEdit9.Text:= '1';


    CB_TECNICOS.ItemIndex:=0;
    CB_ORIGEM.ItemIndex:=1;
    CB_SERVICOS.ItemIndex:=1;
    CB_TIPO_PLANO.ItemIndex:=1;

    //Fim inicializa��o

    DS_OPERACAO.DataSet.Post;
    DS_OPERACAO.DataSet.Edit;

    DBEdT_CONTRATO.SetFocus;


end;

end.
