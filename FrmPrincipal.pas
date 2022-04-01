unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.CheckLst, Vcl.ButtonGroup, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,IdException,
  Vcl.DBCtrls, Vcl.Imaging.pngimage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,ShellAPI,inifiles,System.Zip,IdFTP;

type
  Tfrm_painel_servicos = class(TForm)
    Bevel1: TBevel;
    btn_nova_os: TBitBtn;
    DB_GRID_SERVICOS: TDBGrid;
    edt_data_inicio: TMaskEdit;
    edt_data_fim: TMaskEdit;
    lb_inicio: TLabel;
    Label2: TLabel;
    CB_TECNICOS: TComboBox;
    Label3: TLabel;
    CB_EQUIPES: TComboBox;
    Label4: TLabel;
    CB_CIDADES: TComboBox;
    Label5: TLabel;
    DS_OPERACOES: TDataSource;
    btn_carregar: TBitBtn;
    MC_DATA_INICIO: TMonthCalendar;
    SB_CALENDAR_DATA_INICIO: TSpeedButton;
    SB_CALENDAR_DATA_FIM: TSpeedButton;
    MC_DATA_FIM: TMonthCalendar;
    QRY_TECNICOS: TFDQuery;
    QRY_EQUIPES: TFDQuery;
    QRY_CIDADES: TFDQuery;
    SB_LOGIN: TStatusBar;
    btn_troca_status: TBitBtn;
    Image1: TImage;
    DBGrid2: TDBGrid;
    QRY_Adicionais: TFDQuery;
    Bevel3: TBevel;
    DB_GRID_ITENS_ADD: TDBGrid;
    QRY_ITENS_ADD: TFDQuery;
    DS_ITENS_ADD: TDataSource;
    DBEdit11: TDBEdit;
    Label6: TLabel;
    BTN_IMPORT: TSpeedButton;
    Panel1: TPanel;
    QRY_ITENS_DESLOCAMENTOS: TFDQuery;
    DS_DESLOCAMENTOS: TDataSource;
    Bevel2: TBevel;
    LB_TOTAL: TLabel;
    btn_contrato: TBitBtn;
    OpenDialog1: TOpenDialog;
    btn_adcionais: TBitBtn;
    Edt_deslocamento: TBitBtn;
    btn_escala: TBitBtn;
    btn_novo_tecnico: TBitBtn;
    btn_atualizacao: TBitBtn;
    IdFTP1: TIdFTP;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    btn_extrair: TBitBtn;
    memo_estrair: TMemo;
    procedure btn_tipo_servicoClick(Sender: TObject);
    procedure btn_carregarClick(Sender: TObject);
    procedure SB_CALENDAR_DATA_INICIOClick(Sender: TObject);
    procedure MC_DATA_INICIODblClick(Sender: TObject);
    procedure SB_CALENDAR_DATA_FIMClick(Sender: TObject);
    procedure MC_DATA_FIMDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btn_nova_osClick(Sender: TObject);
    procedure DB_GRID_SERVICOSDblClick(Sender: TObject);
    procedure btn_troca_statusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DB_GRID_SERVICOSDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DB_GRID_ITENS_ADDDblClick(Sender: TObject);
    procedure DB_GRID_SERVICOSEnter(Sender: TObject);
    procedure DB_GRID_SERVICOSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DB_GRID_SERVICOSKeyPress(Sender: TObject; var Key: Char);
    procedure DB_GRID_SERVICOSKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DB_GRID_SERVICOSCellClick(Column: TColumn);
    procedure BTN_IMPORTClick(Sender: TObject);
    procedure btn_contratoClick(Sender: TObject);
    procedure btn_adcionaisClick(Sender: TObject);
    procedure Edt_deslocamentoClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure btn_escalaClick(Sender: TObject);
    procedure CB_EQUIPESChange(Sender: TObject);
    procedure btn_novo_tecnicoClick(Sender: TObject);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure btn_atualizacaoClick(Sender: TObject);
    procedure btn_extrairClick(Sender: TObject);
  private
    { Private declarations }
   procedure Deslocamentos();
   procedure Adicionais();
   function ObterDiretorioDoExecutavel: string;
   function ConectarAoServidorFTP: boolean;
   function ObterNumeroVersaoLocal: smallint;
   function ObterNumeroVersaoFTP: smallint;
   procedure BaixarAtualizacao;
   procedure DescompactarAtualizacao;
   procedure AtualizarNumeroVersao;


  public
    { Public declarations }
  end;

var
  frm_painel_servicos: Tfrm_painel_servicos;
  Marcador:STRING;
  FnTamanhoTotal: integer;


implementation

{$R *.dfm}

uses DataModule, FrmDeslocamentos, Frm_Edt_Servicos,FrmImportTemporario, FrmCad_Servicos, FrmNovo_tecnico, FrmCadastroServicos,
  FrmTrocaStatus, FrmLogin, FrmEscalas
  ;


procedure Tfrm_painel_servicos.AtualizarNumeroVersao;
var
  oArquivoLocal, oArquivoFTP: TIniFile;
  sNumeroNovaVersao: string;
begin

  // abre os dois arquivos INI
  oArquivoFTP := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoFTP.ini');
  oArquivoLocal := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoLocal.ini');
  try
    // obt�m o n�mero da nova vers�o no arquivo "VersaoFTP.ini"...
    sNumeroNovaVersao := oArquivoFTP.ReadString('VersaoFTP', 'Numero', EmptyStr);

    // ... e grava este n�mero no arquivo "VersaoLocal.ini"
    oArquivoLocal.WriteString('VersaoLocal', 'Numero', sNumeroNovaVersao);
  finally
    FreeAndNil(oArquivoFTP);
    FreeAndNil(oArquivoLocal);
  end;
end;

procedure Tfrm_painel_servicos.DescompactarAtualizacao;
var
  sNomeArquivoAtualizacao: string;
  UnZipper: TZipFile;
begin
  // deleta o backup anterior, ou melhor, da vers�o anterior,
  // evitando erro de arquivo j� existente
  if FileExists(ObterDiretorioDoExecutavel + 'Sistema_Backup.exe') then
    DeleteFile(ObterDiretorioDoExecutavel + 'Sistema_Backup.exe');

  // Renomeia o execut�vel atual (desatualizado) para "Sistema_Backup.exe"
  RenameFile(ObterDiretorioDoExecutavel + 'Thunder.exe',
    ObterDiretorioDoExecutavel + 'Sistema_Backup.exe');

  // armazena o nome do arquivo de atualiza��o em uma vari�vel
  sNomeArquivoAtualizacao := ObterDiretorioDoExecutavel + 'Atualizacao.zip';

  UnZipper := TZipFile.Create();
  UnZipper.Open('C:\Thunder\Atualizacao.zip', zmRead);
  UnZipper.ExtractAll('C:\Thunder\');
  UnZipper.Close;

  // executa a linha de comando do 7-Zip para descompactar o arquivo baixado
 // ShellExecute(0, nil, '7z',  PWideChar(' e -aoa ' +
 //   sNomeArquivoAtualizacao + ' -o' + ObterDiretorioDoExecutavel), '', SW_SHOW);
end;

procedure Tfrm_painel_servicos.BaixarAtualizacao;
begin
  try
    // deleta o arquivo "Atualizacao.rar", caso exista,
    // evitando erro de arquivo j� existente
    if FileExists(ObterDiretorioDoExecutavel + 'Atualizacao.zip') then
      DeleteFile(ObterDiretorioDoExecutavel + 'Atualizacao.zip');

    // obt�m o tamanho da atualiza��o e preenche a vari�vel "FnTamanhoTotal"
    FnTamanhoTotal := IdFTP1.Size('atualizacao/Atualizacao.zip');

    // faz o download do arquivo "Atualizacao.zip"
    IdFTP1.Get('atualizacao/Atualizacao.zip',
      ObterDiretorioDoExecutavel + 'Atualizacao.zip', True, True);
  except
    On E:Exception do
    begin
      // ignora a exce��o "Connection Closed Gracefully"
      if E is EIdConnClosedGracefully then
        Exit;

      ShowMessage('Erro ao baixar a atualiza��o: ' + E.Message);

      // interrompe a atualiza��o
      Abort;
    end;
  end;
end;

function Tfrm_painel_servicos.ObterNumeroVersaoFTP: smallint;
var
  sNumeroVersao: string;
  oArquivoINI: TIniFile;
begin
  // deleta o arquivo "VersaoFTP.ini" do computador, caso exista,
  // evitando erro de arquivo j� existente
  if FileExists(ObterDiretorioDoExecutavel + 'VersaoFTP.ini') then
    DeleteFile(ObterDiretorioDoExecutavel + 'VersaoFTP.ini');

  // baixa o arquivo "VersaoFTP.ini" para o computador
  IdFTP1.Get('atualizacao/VersaoFTP.ini', ObterDiretorioDoExecutavel + 'VersaoFTP.ini', True, True);

  // abre o arquivo "VersaoFTP.ini"
  oArquivoINI := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoFTP.ini');
  try
    // l� o n�mero da vers�o
    sNumeroVersao := oArquivoINI.ReadString('VersaoFTP', 'Numero', EmptyStr);

    // retira os pontos (exemplo: de "1.0.1" para "101")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);

    // converte o n�mero da vers�o para n�mero
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoINI);
  end;
end;

function Tfrm_painel_servicos.ObterNumeroVersaoLocal: smallint;
var
  sNumeroVersao: string;
  oArquivoINI: TIniFile;
begin
  // abre o arquivo "VersaoLocal.ini"
  oArquivoINI := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoLocal.ini');
  try
    // l� o n�mero da vers�o
    sNumeroVersao := oArquivoINI.ReadString('VersaoLocal', 'Numero', EmptyStr);

    // retira os pontos (exemplo: de "1.0.0" para "100")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);

    // converte o n�mero da vers�o para n�mero
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoINI);
  end;
end;

function Tfrm_painel_servicos.ConectarAoServidorFTP: boolean;
begin
  // desconecta, caso tenha sido conectado anteriormente
  if IdFTP1.Connected then
    IdFTP1.Disconnect;
  try
    IdFTP1.Connect;
    result := True;
  except
    On E:Exception do
    begin
      ShowMessage('Erro ao acessar o servidor de atualiza��o: ' + E.Message);
      result := False;
    end;
  end;
end;

function  Tfrm_painel_servicos.ObterDiretorioDoExecutavel: string;
begin
  result := ExtractFilePath(Application.ExeName);
end;

procedure Tfrm_painel_servicos.Adicionais();
begin
   //Selecionar Os adicionais do servi�o "Exemplo cabeamento longp"
   IF DM.QRY_Operacoes.RowsAffected > 0  then
     BEGIN
      qry_itens_add.close;
      qry_itens_add.sql.clear;
      qry_itens_add.sql.add('select id.idoperacoes, id.idadicionais,ad.descricao, id.pontuacao');
      qry_itens_add.sql.add('from itens_adicionais id, adicionais ad');
      qry_itens_add.sql.add('where (id.idadicionais = ad.idadicionais) and (id.idoperacoes = :pid)');

      qry_itens_add.parambyname('pid').value:= db_grid_servicos.fields[16].text;
      qry_itens_add.open;
     END;
end;


procedure Tfrm_painel_servicos.Deslocamentos();
VAR MARCADOR, DATA : STRING;
begin
 IF (DM.QRY_Operacoes.RowsAffected >0) AND ((MARCADOR <> DB_GRID_SERVICOS.Fields[1].Text) OR (DATA <> DB_GRID_SERVICOS.Fields[3].Text)) then
   BEGIN

      //As duas Linhas abaixo evitam as frequentes atualiza��es dos DESLOCAMENTOS.
      MARCADOR:= DB_GRID_SERVICOS.Fields[1].Text;
      DATA:=DB_GRID_SERVICOS.Fields[3].Text;

      //Buscando os DESLOCAMENTO PARA EXIBIR NO GRID.
      QRY_ITENS_DESLOCAMENTOS.Close;
      QRY_ITENS_DESLOCAMENTOS.SQL.Clear;
      qry_itens_deslocamentos.sql.add('select des.iddeslocamentos,des.descricao_deslocamento, tec.nome_tecnico, id.pontuacao, id.data_deslocamento from itens_deslocamentos id, deslocamentos des, tecnicos tec');
      qry_itens_deslocamentos.sql.add('where id.idtecnicos = tec.idtecnicos and id.idtecnicos = :pid and id.data_deslocamento = :pdata and id.iddeslocamentos = des.iddeslocamentos');

      //Passando os parametros ID E DATA.
      qry_itens_deslocamentos.parambyname('pid').value:= db_grid_servicos.fields[1].text;
      qry_itens_deslocamentos.parambyname('pdata').value:= formatdatetime('yyyy-mm-dd',strtodate(db_grid_servicos.fields[3].text));
      qry_itens_deslocamentos.open;

   END;
end;

procedure Tfrm_painel_servicos.Edt_deslocamentoClick(Sender: TObject);
begin
   //Abrindo formul�ario de deslocamentos de cidades
   IF DM.QRY_Operacoes.RowsAffected >0 then
      FrmDeslocamento.Showmodal
   else
    ShowMessage('N�o h� nenhum tecnico selecionado!');
end;

procedure Tfrm_painel_servicos.btn_adcionaisClick(Sender: TObject);
begin
    //Adicionais de servi�os abrindo outro form.
    IF DM.QRY_Operacoes.RowsAffected >0 then
     Begin
      DS_OPERACOES.DataSet.Edit;
      frm_editar_os.showmodal;
      btn_carregar.Click;
     End;
end;

procedure Tfrm_painel_servicos.btn_atualizacaoClick(Sender: TObject);
begin
  var
  nNumeroVersaoLocal, nNumeroVersaoFTP: smallint;
begin
  if not ConectarAoServidorFTP then
    Exit;

  //Obtendo as duas ves�es
  nNumeroVersaoLocal := ObterNumeroVersaoLocal;
  nNumeroVersaoFTP := ObterNumeroVersaoFTP;

  ProgressBar1.Visible:=true;
  Label1.Visible:=true;

  //Verificando se � necessario atualizar
  IF nNumeroVersaoLocal < nNumeroVersaoFTP then
  begin
   //Processo de atualiza��o
    BaixarAtualizacao();
    DescompactarAtualizacao();
    AtualizarNumeroVersao();
   //fim

    ShowMessage('O sistema foi atualizado com sucesso!');
    ProgressBar1.Visible:=false;
    Label1.Visible:=false;
    ShellExecute(Handle,'open',pchar('c:\Thunder\Thunder.exe'),nil,nil,sw_show);
    close;

  end
  else
    //Se a vers�o n�o for menor finalizar processo.
    begin
     ShowMessage('O sistema j� est� atualizado.');
     ProgressBar1.Visible:=false;
     Label1.Visible:=false;
    end;
end;
end;

procedure Tfrm_painel_servicos.btn_carregarClick(Sender: TObject);
VAR NUMERO, I :integer;
begin
  Try
    dm.qry_operacoes.close;
    dm.qry_operacoes.sql.clear;
    dm.qry_operacoes.sql.add('select * from operacoes op, origem ori, tecnicos tec,planos pl, servicos ser, cidades cid, equipes eq ');
    dm.qry_operacoes.sql.add('where op.idtecnicos = tec.idtecnicos and op.idorigem = ori.idorigem and op.idservicos = ser.idservicos ');
    dm.qry_operacoes.sql.add('and op.idplanos = pl.idplanos and tec.idequipes = eq.idequipes and tec.idcidades = cid.idcidades ');
    dm.qry_operacoes.sql.add('and op.data_inicial between :pdata_inicio and :pdata_fim');
    dm.qry_operacoes.parambyname('pdata_inicio').value:=formatdatetime('yyyy-mm-dd',strtodate(edt_data_inicio.text));
    dm.qry_operacoes.parambyname('pdata_fim').value:=formatdatetime('yyyy-mm-dd',strtodate(edt_data_fim.text));

    if (cb_tecnicos.text <> '') then
    begin
      dm.qry_operacoes.sql.add('and op.idtecnicos = :pidtecnico');
      dm.QRY_ID_TECNICO.Close;
      dm.QRY_ID_TECNICO.Params.ParamByName('nome').AsString:=CB_TECNICOS.Text;
      dm.QRY_ID_TECNICO.Open;

      dm.qry_operacoes.parambyname('pidtecnico').value:= dm.QRY_ID_TECNICO.FieldByName('idtecnicos').AsString;
    end;

    if (cb_equipes.text <> '') then
    begin
      dm.qry_operacoes.sql.add('and tec.idequipes = :pidequipe');
      dm.qry_operacoes.parambyname('pidequipe').value:=cb_equipes.items.indexof(cb_equipes.text);
      //showmessage(inttostr(cb_tecnicos.items.indexof(cb_equipes.text)));
    end;

    if (cb_cidades.text <> '') then
    begin
      dm.qry_operacoes.sql.add('and tec.idcidades = :pidcidade');
      dm.qry_operacoes.parambyname('pidcidade').value:=cb_cidades.items.indexof(cb_cidades.text);
      //showmessage(inttostr(cb_cidades.items.indexof(cb_cidades.text)));
    end;

    dm.qry_operacoes.sql.add('order by op.idtecnicos, op.status');

    //Executar os comandos montados
    dm.qry_operacoes.open;


    //Atualiza os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
    Adicionais();

    //Atualiza os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
    Deslocamentos();
  Except on E: Exception do
    ShowMessage('Erro:'+e.Message);
  end

end;

procedure Tfrm_painel_servicos.btn_contratoClick(Sender: TObject);
var Entrada: string;
begin
    //Guardando o contrato desejado.
    Entrada:= InputBox('Entrada de dados', 'CONTRATO:', '000000');

    //Atendendo aos requisitos Selecionar todas as intera��es com o contrato.
   Try
    IF (Entrada <> '') and (Entrada <> '000000')  THEN
     BEGIN
      DM.QRY_Operacoes.Close;
      dm.qry_operacoes.close;
      dm.qry_operacoes.sql.clear;
      dm.qry_operacoes.sql.add('select * from operacoes op, origem ori, tecnicos tec,planos pl, servicos ser, cidades cid, equipes eq ');
      dm.qry_operacoes.sql.add('where op.idtecnicos = tec.idtecnicos and op.idorigem = ori.idorigem and op.idservicos = ser.idservicos ');
      dm.qry_operacoes.sql.add('and op.idplanos = pl.idplanos and tec.idequipes = eq.idequipes and tec.idcidades = cid.idcidades ');
      dm.qry_operacoes.sql.add('and op.contrato = :pcontrato');
      dm.qry_operacoes.parambyname('pcontrato').value:=entrada;

      dm.qry_operacoes.sql.add('order by op.data_inicial');

      //Executar todos os comandos
      DM.QRY_Operacoes.OPEN;

     end
     Else
      ShowMessage('Sua busca n�o retornou nenhum resultado!');
   Except on E: Exception do
      ShowMessage('Erro:' + E.Message );
   end;
end;

procedure Tfrm_painel_servicos.btn_escalaClick(Sender: TObject);
begin
    FrmEscala.showmodal;
end;

procedure Tfrm_painel_servicos.btn_extrairClick(Sender: TObject);
begin
 //Extrair valores em tela para mandar para o t�cnico que n�o usa o app
  if DM.QRY_Operacoes.RowsAffected > 0 then
   begin
    if memo_estrair.Visible = FALSE then
     BEGIN
       memo_estrair.Visible:= TRUE;

     END
    ELSE
     begin
      memo_estrair.Visible:= FALSE;
      Exit;
     end;

    memo_estrair.Clear;
    DM.QRY_Operacoes.First;

    While not DM.QRY_Operacoes.Eof do
     begin
        memo_estrair.Lines.Add(DB_GRID_SERVICOS.Columns[4].Field.Text + ' - ' +DB_GRID_SERVICOS.Columns[5].Field.Text+' - '+DB_GRID_SERVICOS.Columns[10].Field.Text+' - '+DB_GRID_SERVICOS.Columns[11].Field.Text);
        memo_estrair.Lines.Add('');
        DM.QRY_Operacoes.Next;
     end;
   end
  Else
   ShowMessage('N�o existe dados para extra��o!');
end;

procedure Tfrm_painel_servicos.BTN_IMPORTClick(Sender: TObject);
begin
    frm_import.ShowModal;

end;



procedure Tfrm_painel_servicos.btn_nova_osClick(Sender: TObject);
begin
    frm_nova_ordem_servico.ShowModal;
end;

procedure Tfrm_painel_servicos.btn_novo_tecnicoClick(Sender: TObject);
begin
    frm_novo_tecnico.showmodal;
end;

procedure Tfrm_painel_servicos.btn_tipo_servicoClick(Sender: TObject);
begin
    frm_servicos.showmodal;
end;

procedure Tfrm_painel_servicos.btn_troca_statusClick(Sender: TObject);
begin
   IF DM.QRY_Operacoes.RowsAffected> 0 then
    BEGIN
      DS_OPERACOES.DataSet.Edit;
      frm_Troca_Status.showmodal;
    END;
end;

procedure Tfrm_painel_servicos.CB_EQUIPESChange(Sender: TObject);
begin
    //Selecionar tecnicos pela equipe.
   IF cb_equipes.items.indexof(cb_equipes.text) <> 0 then
     Begin
        QRY_TECNICOS.Close;
        QRY_TECNICOS.SQL.Clear;
        QRY_TECNICOS.SQL.Text:='select nome_tecnico from tecnicos tec where tec.idequipes = :pidtecnico order by nome_tecnico';
                                                                  //Pegando dados do Combobox indice do mesmo.
        QRY_TECNICOS.Params.ParamByName('pidtecnico').AsInteger:= cb_equipes.items.indexof(cb_equipes.text);
        QRY_TECNICOS.Open;
     End
     else
      begin
        QRY_TECNICOS.Close;
        QRY_TECNICOS.SQL.Clear;
        QRY_TECNICOS.SQL.Text:='select nome_tecnico from tecnicos';
        QRY_TECNICOS.Open;
      end;


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

end;

procedure Tfrm_painel_servicos.DBGrid2DblClick(Sender: TObject);
begin
    IF (Application.MessageBox('Deseja realmente excluir este registro?','Confirma��o', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
      DS_DESLOCAMENTOS.DataSet.Delete;
end;

procedure Tfrm_painel_servicos.DB_GRID_ITENS_ADDDblClick(Sender: TObject);
begin
    IF (Application.MessageBox('Deseja realmente excluir este registro?','Confirma��o', MB_ICONQUESTION + MB_USEGLYPHCHARS) = mrYes) then
      DS_ITENS_ADD.DataSet.Delete;
end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSCellClick(Column: TColumn);
begin

      //Buscar os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
      Adicionais();

      //Buscar os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
      Deslocamentos();
end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSDblClick(Sender: TObject);
begin
      DS_OPERACOES.DataSet.Edit;
      frm_editar_os.showmodal;
      btn_carregar.Click;
end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
VAR Nome : string;
begin
   IF DM.QRY_Operacoes.RowsAffected > 0  then
     Nome:= (DB_GRID_SERVICOS.Columns[11].Field.Text);

     DB_GRID_SERVICOS.Columns[11].Color:= clmenu;
     DB_GRID_SERVICOS.Columns[2].Color:= clmenu;

   IF Nome = 'PENDENTE' then
   begin
     DB_GRID_SERVICOS.Canvas.Font.Color := clblack;
     DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

    IF (Nome = 'CLUSTER - MANHA')OR (Nome = 'AGENDADO - MANHA' ) then
    begin
     DB_GRID_SERVICOS.Canvas.Font.Color := CLHighlight;
     DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

    IF (Nome = 'AGENDADO - TARDE')OR(Nome = 'CLUSTER - TARDE') then
    begin
     DB_GRID_SERVICOS.Canvas.Font.Color := clblue;
     DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

   IF (Nome = 'EM ANDAMENTO') OR (Nome = 'TEC ANDAMENTO')then
    begin
       DB_GRID_SERVICOS.Canvas.Font.Color := CLTeal;
       DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

    IF Nome = 'NAO AGENDADO' then
    begin
     DB_GRID_SERVICOS.Canvas.Font.Color := clPurple;
     DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

    IF (Nome = 'CLIENTE CANCELOU') or (Nome = 'AUSENTE SEM CONTATO')or (Nome = 'CHOVENDO')
    or (Nome = 'RISCO P/ O TECNICO')or (Nome = 'CLIENTE REAGENDOU')or (Nome = 'DISPENSOU A VISITA')
    or (Nome = 'TROCA DE EQUIPE') then
    begin
     DB_GRID_SERVICOS.Canvas.Brush.Color:= CLInfobk;
     DB_GRID_SERVICOS.Canvas.FillRect(Rect);
     DB_GRID_SERVICOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

  IF (Nome = 'CONTRATO BLOQUEADO')or(Nome = 'FORA DE COBERTURA')or(Nome = 'NAP SEM PORTA')
   or(Nome = 'FIM DO DIA') or(Nome = 'FORA DE ROTA')  then
    begin
      DB_GRID_SERVICOS.Canvas.Font.Color := clred;
      DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);


    end;

   IF (Nome = 'SEM EFEITO') then
    begin
     DB_GRID_SERVICOS.Canvas.Font.Color := CLblack;
     DB_GRID_SERVICOS.Canvas.Font.Style:= DB_GRID_SERVICOS.Canvas.Font.Style + [fsBold];
     DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

  IF (Nome = 'COMERCIAL')or (Nome = 'INFRA')or (Nome = 'ALMOXARIFADO')  then
    begin
      DB_GRID_SERVICOS.Canvas.Font.Color := CLOLIVE;
      DB_GRID_SERVICOS.DefaultDrawDataCell(rect,Column.Field,State);

    end;

    IF (Nome = 'FINALIZADO') then
    begin

     DB_GRID_SERVICOS.Canvas.Font.Color:= CLGreen;
     DB_GRID_SERVICOS.Canvas.FillRect(Rect);
     DB_GRID_SERVICOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;


     IF (Nome = 'TEC VALIDACAO') OR (Nome = 'TEC AUSENTE') OR (Nome = 'TEC REAGENDAR') then
    begin

     DB_GRID_SERVICOS.Canvas.Font.Color:= CLRed;
     DB_GRID_SERVICOS.Canvas.FillRect(Rect);
     DB_GRID_SERVICOS.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSEnter(Sender: TObject);
begin

    //Buscar os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
    Adicionais();

    //Buscar os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
    Deslocamentos();
end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

    //Buscar os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
    Adicionais();

    //Buscar os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
    Deslocamentos();

end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSKeyPress(Sender: TObject;
  var Key: Char);
begin
    //Buscar os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
    Adicionais();

    //Buscar os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
    Deslocamentos();
end;

procedure Tfrm_painel_servicos.DB_GRID_SERVICOSKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   //Buscar os adicionais do servi�o exemplo RETIRADA DE PAINEL, CABEAMENTO LONGO.
    Adicionais();

    //Buscar os Deslocamentos do servi�o exemplo ANDRADINA/ NOVA INDEPENDENCIA.
    Deslocamentos();
end;

procedure Tfrm_painel_servicos.FormCreate(Sender: TObject);
begin
    //Atribuindo data incial no create.
    edt_data_inicio.Text:=(DateToStr(date));
    edt_data_fim.Text:=(DateToStr(date));


    MARCADOR:='-1';

    QRY_TECNICOS.Close;
    QRY_TECNICOS.SQL.Clear;
    QRY_TECNICOS.SQL.Add('select nome_tecnico from tecnicos tec where tec.idtecnicos <> :pidtecnico order by nome_tecnico');
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


      QRY_EQUIPES.Close;
      QRY_EQUIPES.SQL.Clear;
      QRY_EQUIPES.SQL.Add('Select * from equipes');
      QRY_EQUIPES.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_EQUIPES.RowsAffected > 0 then
        begin
        while not QRY_EQUIPES.eof do
         begin
          CB_EQUIPES.items.add(QRY_EQUIPES.fieldbyname('DESCRICAO_EQUIPES').AsString);
          QRY_EQUIPES.next;
         end;
       end;
      QRY_EQUIPES.Free;

     QRY_CIDADES.Close;
     QRY_CIDADES.SQL.Clear;
     QRY_CIDADES.SQL.Add('select * from cidades');
     QRY_CIDADES.Open;
    //CARREGAR O COMBO BOX TECNICOS
    IF QRY_CIDADES.RowsAffected > 0 then
        begin
        while not QRY_CIDADES. eof do
         begin
          CB_CIDADES.items.add(QRY_CIDADES.fieldbyname('NOME_CIDADE').AsString);
          QRY_CIDADES.next;
         end;
       end;
      QRY_CIDADES.Free;

end;

procedure Tfrm_painel_servicos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


   // Acionando o bot�o carregar dados com ENTER
   IF KEY = 13 then
    btn_carregar.Click;

   // Acionando o bot�o nova os com F1
   IF key = 112 then
    btn_nova_os.Click;

   //Fechar o PAINEL c/ ESC
   IF key = 27 then
    Close;

   IF key = 121 then
    btn_troca_status.Click;


end;

procedure Tfrm_painel_servicos.FormShow(Sender: TObject);
begin
    //Atualizado calendario com data de hoje
    MC_DATA_INICIO.Date:=date;
    MC_DATA_FIM.Date:=date;

    btn_carregar.SetFocus;

    SB_LOGIN.Panels[0].Text:= FormatDateTime(' dddd ", " dd " de " mmmm " de " yyyy', Now);
    SB_LOGIN.Panels[1].Text:= TimeToStr(time);
    SB_LOGIN.Panels[2].Text :='USER:'+Login.Edt_user.Text;
    SB_LOGIN.Panels[3].Text := 'USU�RIO:ATIVO';

end;

procedure Tfrm_painel_servicos.IdFTP1Work(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
var
  nTamanhoTotal, nTransmitidos, nPorcentagem: real;
begin
  if FnTamanhoTotal = 0 then
    Exit;

  Application.ProcessMessages;

  // obt�m o tamanho total do arquivo em bytes
  nTamanhoTotal := FnTamanhoTotal div 1024;

  // obt�m a quantidade de bytes j� baixados
  nTransmitidos := AWorkCount div 1024;

  // calcula a porcentagem de download
  nPorcentagem := (nTransmitidos * 100) / nTamanhoTotal;

  // atualiza o componente TLabel com a porcentagem
  Label1.Caption := Format('%s%%', [FormatFloat('##0', nPorcentagem)]);

  // atualiza a barra de preenchimento do componente TProgressBar
  ProgressBar1.Position := AWorkCount div 1024;
end;

procedure Tfrm_painel_servicos.IdFTP1WorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
    ProgressBar1.Max := FnTamanhoTotal div 1024;
end;

procedure Tfrm_painel_servicos.MC_DATA_FIMDblClick(Sender: TObject);
begin
    edt_data_fim.Text := DateToStr(MC_DATA_FIM.Date);
    edt_data_fim.Text := DateToStr(MC_DATA_FIM.Date);
    MC_DATA_FIM.Visible:=False;
end;

procedure Tfrm_painel_servicos.MC_DATA_INICIODblClick(Sender: TObject);
begin
    edt_data_inicio.Text := DateToStr(MC_DATA_INICIO.Date);
    MC_DATA_INICIO.Visible:=False;

end;

procedure Tfrm_painel_servicos.SB_CALENDAR_DATA_INICIOClick(Sender: TObject);
begin
    //Seleciornar dadas e a visibilidade do calendario
    IF MC_DATA_INICIO.Visible =TRUE then
      Begin
        MC_DATA_INICIO.Visible:=False;
      End
    else
      Begin
        MC_DATA_INICIO.Visible:=True;
      end;
end;

procedure Tfrm_painel_servicos.SB_CALENDAR_DATA_FIMClick(Sender: TObject);
begin
    //Seleciornar dadas e a visibilidade do calendario
    IF MC_DATA_FIM.Visible =TRUE then
      Begin
        MC_DATA_FIM.Visible:=False;
      End
    else
      Begin
        MC_DATA_FIM.Visible:=True;
      end;
end;

end.
