unit FrmImportTemporario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons, ComObj,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  Tfrm_import = class(TForm)
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    btn_importar: TBitBtn;
    QRY_INSERIR_MIGRACAO: TFDQuery;
    ProgressBar1: TProgressBar;
    procedure btn_importarClick(Sender: TObject);
  private
    { Private declarations }

function XlsToStringGrid(XStringGrid: TStringGrid; xFileXLS: string): Boolean;

  public
    { Public declarations }
  end;

var
  frm_import: Tfrm_import;

implementation

{$R *.dfm}

uses DataModule;

Function Tfrm_import.XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
const
   xlCellTypeLastCell = $0000000B;
var
   XLSAplicacao, AbaXLS: OLEVariant;
   RangeMatrix: Variant;
   x, y, k, r,I,z, LINHA, COLUNA: Integer;
   REGISTRO : ARRAY [1..9] OF STRING;
begin
   Result := False;
   // Cria Excel- OLE Object
   XLSAplicacao := CreateOleObject('Excel.Application');
   try
   // Esconde Excel
      XLSAplicacao.Visible := False;

      // Abre o Workbook
      XLSAplicacao.Workbooks.Open(xFileXLS);

      {Selecione aqui a aba que voc� deseja abrir primeiro - 1,2,3,4....}
      XLSAplicacao.WorkSheets[1].Activate;

      {Selecione aqui a aba que voc� deseja ativar - come�ando sempre no 1 (1,2,3,4) }
      AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];

      AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
      // Pegar o n�mero da �ltima linha
      x := XLSAplicacao.ActiveCell.Row;
      // Pegar o n�mero da �ltima coluna
      y := XLSAplicacao.ActiveCell.Column;
      // Seta xStringGrid linha e coluna
      XStringGrid.RowCount := x;
      XStringGrid.ColCount := y;
      // Associaca a variant WorkSheet com a variant do Delphi
      RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
      // Cria o loop para listar os registros no TStringGrid
      k := 1;
      repeat
         for r := 1 to y do
           Begin
             XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
             ProgressBar1.Position:=k;
           end;
         Inc(k, 1);
      until k > x;
      RangeMatrix := Unassigned;
      finally
            // Fecha o Microsoft Excel
            if not VarIsEmpty(XLSAplicacao) then
            begin
                  XLSAplicacao.Quit;
                  XLSAplicacao := Unassigned;
                  AbaXLS := Unassigned;
                  Result := True;
            end;
     R:=1;
     K:=1;
     I:=1;
     LINHA:=0;
     COLUNA:=0;
     ProgressBar1.Position:=0;

    for I := 1 to 67247 do
     BEGIN
      ProgressBar1.Position:=I;
      IF COLUNA > 0 then
       BEGIN
          QRY_INSERIR_MIGRACAO.Close;
          QRY_INSERIR_MIGRACAO.SQL.Clear;
          QRY_INSERIR_MIGRACAO.SQL.Add('INSERT INTO FACILIDADE(idfacilidade, contrato, nome_cliente, logradouro, numero, bairro, complemento, cidade, uf, status ) ');
          QRY_INSERIR_MIGRACAO.SQL.Add('values('+IntToStr(I-1)+','''+REGISTRO[1]+''','''+REGISTRO[2]+''','''+REGISTRO[3]+''','''+REGISTRO[4]+''','''+REGISTRO[5]+''','''+REGISTRO[6]+''','''+REGISTRO[7]+''','''+REGISTRO[8]+''','''+REGISTRO[9]+''')');


         //QRY_INSERIR_ADICIONAIS.SQL.Add('INSERT INTO ITENS_ADICIONAIS(iditens_adicionais, idadicionais, idoperacoes, pontuacao)');
         //QRY_INSERIR_ADICIONAIS.SQL.Add('values('+IntToStr(CHAVE)+','+DB_GRID_ADICIONAIS.Fields[0].TEXT+','+FRM_EDITAR_OS.DBEdit1.TEXT+','+Ponto+')');
         QRY_INSERIR_MIGRACAO.ExecSQL;

           For Z := 1 to 9 do
            begin
              REGISTRO[z]:=(' ');
            end;
       END;

       COLUNA:=0;
       INC(LINHA);
     For R := 1 to 9 do
       BEGIN
        Inc(COLUNA);
        REGISTRO[R]:= StringGrid1.Cells[(COLUNA-1),(LINHA-1)];

       END;
     END;

    End;


end;


procedure Tfrm_import.btn_importarClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
            XlsToStringGrid(StringGrid1,OpenDialog1.FileName);
end;

end.
