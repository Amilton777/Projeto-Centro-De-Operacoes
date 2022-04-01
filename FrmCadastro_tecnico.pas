unit FrmCadastro_tecnico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  Tfrm_cadastro_tecnico = class(TForm)
    CB_EQUIPES: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    CB_CIDADES: TComboBox;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label1: TLabel;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    btn_salvar: TBitBtn;
    btn_sair: TBitBtn;
    QRY_EQUIPES: TFDQuery;
    QRY_CIDADES: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure CB_EQUIPESChange(Sender: TObject);
    procedure CB_CIDADESChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_sairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadastro_tecnico: Tfrm_cadastro_tecnico;

implementation

{$R *.dfm}

uses FrmNovo_tecnico, DataModule;

procedure Tfrm_cadastro_tecnico.btn_sairClick(Sender: TObject);
begin
    frm_novo_tecnico.QRY_CONSULTA_TECNICOS.Close;
    close;
end;

procedure Tfrm_cadastro_tecnico.btn_salvarClick(Sender: TObject);
begin
    frm_novo_tecnico.DS_CONSULTA_TECNICOS.DataSet.Post;

    //DS_CADASTRO_TEC.DataSet.Post;
    ShowMessage('CADASTRO FEITO COM SUCESSO!');
    close;
end;

procedure Tfrm_cadastro_tecnico.CB_CIDADESChange(Sender: TObject);
begin
    DBEdit6.Text:=IntToStr(CB_CIDADES.Items.IndexOf(CB_CIDADES.text));
end;

procedure Tfrm_cadastro_tecnico.CB_EQUIPESChange(Sender: TObject);
begin
     DBEdit5.Text:=IntToStr(CB_EQUIPES.Items.IndexOf(CB_EQUIPES.text));
end;

procedure Tfrm_cadastro_tecnico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     frm_novo_tecnico.QRY_CONSULTA_TECNICOS.close;
end;

procedure Tfrm_cadastro_tecnico.FormCreate(Sender: TObject);
begin
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
end;

procedure Tfrm_cadastro_tecnico.FormShow(Sender: TObject);
begin
    DBEdit2.SetFocus;

    

       IF DBEdit5.Text <> '' then
        CB_EQUIPES.ItemIndex:=StrToInt(DBEdit5.Text)
       else
         CB_EQUIPES.Text:='';

       IF DBEdit6.Text <> '' then
        CB_CIDADES.ItemIndex:=StrToInt(DBEdit6.Text)
       else
        CB_CIDADES.Text:='';


end;

end.
