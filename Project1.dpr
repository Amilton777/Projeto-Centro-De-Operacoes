program Project1;

uses
  Vcl.Forms,
  FrmLogin in 'FrmLogin.pas' {Login},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  FrmCadastroServicos in 'FrmCadastroServicos.pas' {frm_servicos},
  FrmPrincipal in 'FrmPrincipal.pas' {frm_painel_servicos},
  FrmCad_Servicos in 'FrmCad_Servicos.pas' {frm_nova_ordem_servico},
  Frm_Edt_Servicos in 'Frm_Edt_Servicos.pas' {FRM_EDITAR_OS},
  FrmTrocaStatus in 'FrmTrocaStatus.pas' {frm_Troca_Status},
  FrmInserirAdicionais in 'FrmInserirAdicionais.pas' {frm_novo_adicionais},
  FrmImportTemporario in 'FrmImportTemporario.pas' {frm_import},
  FrmDeslocamentos in 'FrmDeslocamentos.pas' {FrmDeslocamento},
  FrmReagendamento in 'FrmReagendamento.pas' {frm_reagendamento},
  FrmEscalas in 'FrmEscalas.pas' {FrmEscala},
  Frmlog_tecnico in 'Frmlog_tecnico.pas' {frm_log_interacao_tecnico},
  FrmNovo_tecnico in 'FrmNovo_tecnico.pas' {frm_novo_tecnico},
  FrmCadastro_tecnico in 'FrmCadastro_tecnico.pas' {frm_cadastro_tecnico},
  FrmFotosOS in 'FrmFotosOS.pas' {frm_fotos_os},
  FrmExibirUnit12 in 'FrmExibirUnit12.pas' {frm_exibir};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(Tfrm_servicos, frm_servicos);
  Application.CreateForm(Tfrm_painel_servicos, frm_painel_servicos);
  Application.CreateForm(Tfrm_nova_ordem_servico, frm_nova_ordem_servico);
  Application.CreateForm(TFRM_EDITAR_OS, FRM_EDITAR_OS);
  Application.CreateForm(Tfrm_Troca_Status, frm_Troca_Status);
  Application.CreateForm(Tfrm_novo_adicionais, frm_novo_adicionais);
  Application.CreateForm(Tfrm_import, frm_import);
  Application.CreateForm(TFrmDeslocamento, FrmDeslocamento);
  Application.CreateForm(Tfrm_reagendamento, frm_reagendamento);
  Application.CreateForm(TFrmEscala, FrmEscala);
  Application.CreateForm(Tfrm_log_interacao_tecnico, frm_log_interacao_tecnico);
  Application.CreateForm(Tfrm_novo_tecnico, frm_novo_tecnico);
  Application.CreateForm(Tfrm_cadastro_tecnico, frm_cadastro_tecnico);
  Application.CreateForm(Tfrm_fotos_os, frm_fotos_os);
  Application.CreateForm(Tfrm_exibir, frm_exibir);
  Application.Run;
end.
