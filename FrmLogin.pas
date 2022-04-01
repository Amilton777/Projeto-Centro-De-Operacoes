unit FrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TLogin = class(TForm)
    btn_entrar: TBitBtn;
    Edt_user: TMaskEdit;
    Edt_senha: TMaskEdit;
    btn_sair: TBitBtn;
    bvl_painel_login: TBevel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_entrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_sairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;
  equipe_user :integer;

implementation

{$R *.dfm}

uses DataModule, FrmPrincipal;

procedure TLogin.btn_entrarClick(Sender: TObject);

begin

  try
    DM.Qry_login.Close;
    DM.Qry_login.SQL.Clear;
    DM.Qry_login.SQL.Add('Select * from login where login.user = :pUser and login.password = :pPassword');
    DM.Qry_login.ParamByName('pUser').Value :=Edt_user.Text;
    DM.Qry_login.ParamByName('pPassword').Value :=Edt_senha.Text;
    DM.Qry_login.OPEN;

    //vERIFICANDO O RESULTADO DA QUERY ANTERIOR
    IF DM.Qry_login.RowsAffected >= 1 then
    Begin

      Login.Visible:= False;

      //Atribuindo o id da equipe a partir do longin em uma variavel global
      Equipe_user:= DM.Qry_login.FieldByName('idequipes').AsInteger;

      //Abrindo FrmPrincipal
      frm_painel_servicos.ShowModal;

      close;
    End
    ELSE
      ShowMessage('Usuario ou senha, INCORRETOS!!!');

      Edt_user.Clear;
      Edt_senha.Clear;


  Except on E: Exception do
     ShowMessage('Erro:' + E.Message );

  end;








end;

procedure TLogin.btn_sairClick(Sender: TObject);
begin
     CLOSE;
end;

procedure TLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var texto : string;
begin

end;

end.
