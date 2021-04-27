{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Jurisato Junior                           }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatu� - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit pcnConversaoBPe;

interface

uses
  SysUtils, StrUtils, Classes,
  pcnConversao;

type
  TVersaoBPe = (ve100);

  TModeloBPe = (moBPe, moBPeTM);

  TTipoBPe = (tbNormal, tbSubstituicao, tbBPeTM);

  TModalBPe = (moRodoviario, moAquaviario, moFerroviario);

  TSchemaBPe = (schErro, schBPe, schBPeTM, schconsSitBPe, schconsStatServ, schEventoBPe,
                schdistDFeInt, schevCancBPe, schevNaoEmbBPe, schevAlteracaoPoltrona,
                schevExcessoBagagem{,
                schresBPe, schresEventoBPe, schprocBPe, schprocEventoBPe});

  TLayOutBPe = (LayBPeRecepcao, LayBPeRecepcaoTM, LayBPeRetRecepcao, LayBPeConsulta,
                LayBPeStatusServico, LayBPeEvento, LayBPeEventoAN, LayDistDFeInt);

  TStatusACBrBPe = (stIdleBPe, stBPeRecepcao, stBPeRetRecepcao, stBPeConsulta,
                    stBPeStatusServico, stBPeEvento, stBPeEmail,
                    stDistDFeInt, stEnvioWebService);

  TTipoSubstituicao = (tsRemarcacao, tsTransferencia, tsTransfRemarcacao);

  TTipoDocumento = (tdRG, tdTituloEleitor, tdPassaporte, tdCNH, tdOutros);

  TTipoViagem = (tvRegular, tvExtra);

  TTipoServico = (tsConvencionalComSanitario, tsConvencionalSemSanitario,
                  tsSemileito, tsLeitoComAr, tsLeitoSemAr, tsExecutivo,
                  tsSemiurbano, tsLongitudinal, tsTravessia, tsCama,
                  tsMicroOnibus);

  TTipoAcomodacao = (taAssento, taRede, taRedeComAr, taCabine, taOutros);

  TTipoTrecho = (ttNormal, ttTrechoInicial, ttConexao);

  TTipoVeiculo = (tvNenhum, tvMotocicleta, tvAutomovel, tvAtomovelComReboque,
                  tvCaminhonete, tvCaminhoneteComReboque, tvMicroOnibus,
                  tvVan, tvOnibus2ou3Eixos, tvOnibus4Eixos, tvCaminhao34,
                  tvCaminhaoToco, tvCaminhaoTruck, tvCarreta, tvBiTrem,
                  tvRodoTrem, tvRomeuJulieta, tvJamanta6Eixos, tvJamanta5Eixos,
                  tvJamanta4Eixos, tvTratorEsteira, tvPaMecanica, tvPatrol,
                  tvTratorPneuGrande, tvTratorPneuComReboque, tvPneuSemReboque,
                  tvCarroca, tvMobilete, tvBicicleta, tvPassageiro, tvOutros);

  TSitVeiculo = (svVazio, svCarregado, svNaoSeAplica);

  TTipoDesconto = (tdNenhum, tdTarifaPromocional, tdIdoso, tdCrianca, tdDeficiente,
                   tdEstudante, tdAnimalDomestico, tdAcordoColetivo,
                   tdProfissionalemDeslocamento, tdProfissionaldaEmpresa,
                   tdJovem, tdOutrosDesc);

  TTipoComponente = (tcTarifa, tcPedagio, tcTaxaEmbarque, tcSeguro, tcTRM,
                     tcSVI, tcOutros);

  TBandeiraCard = (bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred, bcElo,
                   bcDinersClub, bcHipercard, bcAura, bcCabal, bcOutros);

  TFormaPagamento = (fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                     fpValeTransporte, fpPIX, fpOutro);

  TTipoEmissao = (teNormal, teOffLine);

function StrToVersaoBPe(out ok: Boolean; const s: String): TVersaoBPe;
function VersaoBPeToStr(const t: TVersaoBPe): String;

function tpBPeToStr(const t: TTipoBPe): String;
function StrToTpBPe(out ok: Boolean; const s: String): TTipoBPe;

function ModalBPeToStr(const t: TModalBPe): String;
function StrToModalBPe(out ok: Boolean; const s: String): TModalBPe;

function DblToVersaoBPe(out ok: Boolean; const d: Real): TVersaoBPe;
function VersaoBPeToDbl(const t: TVersaoBPe): Real;

function LayOutToSchema(const t: TLayOutBPe): TSchemaBPe;

function SchemaBPeToStr(const t: TSchemaBPe): String;
function StrToSchemaBPe(const s: String): TSchemaBPe;

function LayOutBPeToServico(const t: TLayOutBPe): String;
function ServicoToLayOutBPe(out ok: Boolean; const s: String): TLayOutBPe;

function tpSubstituicaoToStr(const t: TTipoSubstituicao): String;
function StrTotpSubstituicao(out ok: Boolean; const s: String): TTipoSubstituicao;

function tpDocumentoToStr(const t: TTipoDocumento): String;
function StrTotpDocumento(out ok: Boolean; const s: String): TTipoDocumento;
function tpDocumentoToDesc(const t: TTipoDocumento): String;

function tpViagemToStr(const t: TTipoViagem): String;
function StrTotpViagem(out ok: Boolean; const s: String): TTipoViagem;

function tpServicoToStr(const t: TTipoServico): String;
function StrTotpServico(out ok: Boolean; const s: String): TTipoServico;
function tpServicoToDesc(const t: TTipoServico): String;

function tpAcomodacaoToStr(const t: TTipoAcomodacao): String;
function StrTotpAcomodacao(out ok: Boolean; const s: String): TTipoAcomodacao;

function tpTrechoToStr(const t: TTipoTrecho): String;
function StrTotpTrecho(out ok: Boolean; const s: String): TTipoTrecho;

function tpVeiculoToStr(const t: TTipoVeiculo): String;
function StrTotpVeiculo(out ok: Boolean; const s: String): TTipoVeiculo;

function SitVeiculoToStr(const t: TSitVeiculo): String;
function StrToSitVeiculo(out ok: Boolean; const s: String): TSitVeiculo;

function tpDescontoToStr(const t: TTipoDesconto): String;
function StrTotpDesconto(out ok: Boolean; const s: String): TTipoDesconto;
function tpDescontoToDesc(const t: TTipoDesconto): String;

function tpComponenteToStr(const t: TTipoComponente): String;
function StrTotpComponente(out ok: Boolean; const s: String): TTipoComponente;
function tpComponenteToDesc(const t: TTipoComponente): String;

function BandeiraCardToStr(const t: TBandeiraCard): string;
function BandeiraCardToDescStr(const t: TBandeiraCard): string;
function StrToBandeiraCard(out ok: boolean; const s: string): TBandeiraCard;

function StrToTpEventoBPe(out ok: boolean; const s: string): TpcnTpEvento;

function FormaPagamentoBPeToStr(const t: TFormaPagamento): string;
function FormaPagamentoBPeToDescricao(const t: TFormaPagamento): string;
function StrToFormaPagamentoBPe(out ok: boolean; const s: string): TFormaPagamento;

function ModeloBPeToStr(const t: TModeloBPe): String;
function StrToModeloBPe(out ok: Boolean; const s: String): TModeloBPe;
function ModeloBPeToPrefixo(const t: TModeloBPe): String;

function TpEmisBPeToStr(const t: TTipoEmissao): string;
function StrToTpEmisBPe(out ok: boolean; const s: string): TTipoEmissao;

implementation

uses
  typinfo;

function StrToVersaoBPe(out ok: Boolean; const s: String): TVersaoBPe;
begin
  Result := StrToEnumerado(ok, s, ['1.00'], [ve100]);
end;

function VersaoBPeToStr(const t: TVersaoBPe): String;
begin
  Result := EnumeradoToStr(t, ['1.00'], [ve100]);
end;

function DblToVersaoBPe(out ok: Boolean; const d: Real): TVersaoBPe;
begin
  ok := True;

  if (d = 1.0)  then
    Result := ve100
  else
  begin
    Result := ve100;
    ok := False;
  end;
end;

function VersaoBPeToDbl(const t: TVersaoBPe): Real;
begin
  case t of
    ve100: Result := 1.00;
  else
    Result := 0;
  end;
end;

function tpBPeToStr(const t: TTipoBPe): String;
begin
  Result := EnumeradoToStr(t, ['0', '3', '4'], [tbNormal, tbSubstituicao, tbBPeTM]);
end;

function StrToTpBPe(out ok: Boolean; const s: String): TTipoBPe;
begin
  Result := StrToEnumerado(ok, s, ['0', '3', '4'], [tbNormal, tbSubstituicao, tbBPeTM]);
end;

function ModalBPeToStr(const t: TModalBPe): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '3', '4'],
                           [moRodoviario, moAquaviario, moFerroviario]);
end;

function StrToModalBPe(out ok: Boolean; const s: String): TModalBPe;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '3', '4'],
                           [moRodoviario, moAquaviario, moFerroviario]);
end;

function LayOutToSchema(const t: TLayOutBPe): TSchemaBPe;
begin
  case t of
    LayBPeRecepcao:      Result := schBPe;
    LayBPeRecepcaoTM:    Result := schBPeTM;
    LayBPeConsulta:      Result := schconsSitBPe;
    LayBPeStatusServico: Result := schconsStatServ;
    LayBPeEvento,
    LayBPeEventoAN:      Result := schEventoBPe;
    LayDistDFeInt:       Result := schdistDFeInt;
  else
    Result := schErro;
  end;
end;

function SchemaBPeToStr(const t: TSchemaBPe): String;
begin
  Result := GetEnumName(TypeInfo(TSchemaBPe), Integer( t ) );
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaBPe(const s: String): TSchemaBPe;
var
  P: Integer;
  SchemaStr: String;
  CodSchema: Integer;
begin
  P := pos('_', s);
  if p > 0 then
    SchemaStr := copy(s, 1, P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr, 3) <> 'sch' then
    SchemaStr := 'sch' + SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaBPe), SchemaStr );

  if CodSchema = -1 then
  begin
    raise Exception.Create(Format('"%s" n�o � um valor TSchemaANe v�lido.',[SchemaStr]));
  end;

  Result := TSchemaBPe( CodSchema );
end;

function LayOutBPeToServico(const t: TLayOutBPe): String;
begin
  Result := EnumeradoToStr(t,
    ['BPeRecepcao', 'BPeRecepcaoTM', 'BPeConsultaProtocolo', 'BPeStatusServico',
     'BPeRetRecepcao', 'BPeRecepcaoEvento', 'BPeRecepcaoEvento', 'BPeDistribuicaoDFe'],
    [ LayBPeRecepcao, LayBPeRecepcaoTM, LayBPeConsulta, LayBPeStatusServico,
      LayBPeRetRecepcao, LayBPeEvento, LayBPeEventoAN, LayDistDFeInt ] );
end;

function ServicoToLayOutBPe(out ok: Boolean; const s: String): TLayOutBPe;
begin
  Result := StrToEnumerado(ok, s,
    ['BPeRecepcao', 'BPeRecepcaoTM', 'BPeConsultaProtocolo', 'BPeStatusServico',
     'BPeRetRecepcao', 'BPeRecepcaoEvento', 'BPeRecepcaoEvento', 'BPeDistribuicaoDFe'],
    [ LayBPeRecepcao, LayBPeRecepcaoTM, LayBPeConsulta, LayBPeStatusServico,
      LayBPeRetRecepcao, LayBPeEvento, LayBPeEventoAN, LayDistDFeInt ] );
end;

function tpSubstituicaoToStr(const t: TTipoSubstituicao): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3'],
                           [tsRemarcacao, tsTransferencia, tsTransfRemarcacao]);
end;

function StrTotpSubstituicao(out ok: Boolean; const s: String): TTipoSubstituicao;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3'],
                           [tsRemarcacao, tsTransferencia, tsTransfRemarcacao]);
end;

function tpDocumentoToStr(const t: TTipoDocumento): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4', '5'],
                           [tdRG, tdTituloEleitor, tdPassaporte, tdCNH, tdOutros]);
end;

function StrTotpDocumento(out ok: Boolean; const s: String): TTipoDocumento;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4', '5'],
                           [tdRG, tdTituloEleitor, tdPassaporte, tdCNH, tdOutros]);
end;

function tpDocumentoToDesc(const t: TTipoDocumento): String;
begin
  result := EnumeradoToStr(t,
                           ['RG', 'Titulo de Eleitor', 'Passaporte', 'CNH', 'Outros'],
                           [tdRG, tdTituloEleitor, tdPassaporte, tdCNH, tdOutros]);
end;

function tpViagemToStr(const t: TTipoViagem): String;
begin
  result := EnumeradoToStr(t,
                           ['00', '01'],
                           [tvRegular, tvExtra]);
end;

function StrTotpViagem(out ok: Boolean; const s: String): TTipoViagem;
begin
  result := StrToEnumerado(ok, s,
                           ['00', '01'],
                           [tvRegular, tvExtra]);
end;

function tpServicoToStr(const t: TTipoServico): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                            '11'],
                           [tsConvencionalComSanitario, tsConvencionalSemSanitario,
                            tsSemileito, tsLeitoComAr, tsLeitoSemAr, tsExecutivo,
                            tsSemiurbano, tsLongitudinal, tsTravessia, tsCama,
                            tsMicroOnibus]);
end;

function StrTotpServico(out ok: Boolean; const s: String): TTipoServico;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                            '11'],
                           [tsConvencionalComSanitario, tsConvencionalSemSanitario,
                            tsSemileito, tsLeitoComAr, tsLeitoSemAr, tsExecutivo,
                            tsSemiurbano, tsLongitudinal, tsTravessia, tsCama,
                            tsMicroOnibus]);
end;

function tpServicoToDesc(const t: TTipoServico): String;
begin
  result := EnumeradoToStr(t,
                           ['Convencional com Sanitario', 'Convencional sem Sanitario',
                            'Semileito', 'Leito com Ar', 'Leito sem Ar', 'Executivo',
                            'Semiurbano', 'Longitudinal', 'Travessia', 'Cama',
                            'Micro-Onibus'],
                           [tsConvencionalComSanitario, tsConvencionalSemSanitario,
                            tsSemileito, tsLeitoComAr, tsLeitoSemAr, tsExecutivo,
                            tsSemiurbano, tsLongitudinal, tsTravessia, tsCama,
                            tsMicroOnibus]);
end;

function tpAcomodacaoToStr(const t: TTipoAcomodacao): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4', '5'],
                           [taAssento, taRede, taRedeComAr, taCabine, taOutros]);
end;

function StrTotpAcomodacao(out ok: Boolean; const s: String): TTipoAcomodacao;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4', '5'],
                           [taAssento, taRede, taRedeComAr, taCabine, taOutros]);
end;

function tpTrechoToStr(const t: TTipoTrecho): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3'],
                           [ttNormal, ttTrechoInicial, ttConexao]);
end;

function StrTotpTrecho(out ok: Boolean; const s: String): TTipoTrecho;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3'],
                           [ttNormal, ttTrechoInicial, ttConexao]);
end;

function tpVeiculoToStr(const t: TTipoVeiculo): String;
begin
  result := EnumeradoToStr(t,
                           ['00', '01', '02', '03', '04', '05', '06', '07', '08',
                            '09', '10', '11', '12', '13', '14', '15', '16', '17',
                            '18', '19', '20', '21', '22', '23', '24', '25', '26',
                            '27', '28', '29', '99'],
                           [tvNenhum, tvMotocicleta, tvAutomovel, tvAtomovelComReboque,
                            tvCaminhonete, tvCaminhoneteComReboque, tvMicroOnibus,
                            tvVan, tvOnibus2ou3Eixos, tvOnibus4Eixos, tvCaminhao34,
                            tvCaminhaoToco, tvCaminhaoTruck, tvCarreta, tvBiTrem,
                            tvRodoTrem, tvRomeuJulieta, tvJamanta6Eixos, tvJamanta5Eixos,
                            tvJamanta4Eixos, tvTratorEsteira, tvPaMecanica, tvPatrol,
                            tvTratorPneuGrande, tvTratorPneuComReboque, tvPneuSemReboque,
                            tvCarroca, tvMobilete, tvBicicleta, tvPassageiro, tvOutros]);
end;

function StrTotpVeiculo(out ok: Boolean; const s: String): TTipoVeiculo;
begin
  result := StrToEnumerado(ok, s,
                           ['00', '01', '02', '03', '04', '05', '06', '07', '08',
                            '09', '10', '11', '12', '13', '14', '15', '16', '17',
                            '18', '19', '20', '21', '22', '23', '24', '25', '26',
                            '27', '28', '29', '99'],
                           [tvNenhum, tvMotocicleta, tvAutomovel, tvAtomovelComReboque,
                            tvCaminhonete, tvCaminhoneteComReboque, tvMicroOnibus,
                            tvVan, tvOnibus2ou3Eixos, tvOnibus4Eixos, tvCaminhao34,
                            tvCaminhaoToco, tvCaminhaoTruck, tvCarreta, tvBiTrem,
                            tvRodoTrem, tvRomeuJulieta, tvJamanta6Eixos, tvJamanta5Eixos,
                            tvJamanta4Eixos, tvTratorEsteira, tvPaMecanica, tvPatrol,
                            tvTratorPneuGrande, tvTratorPneuComReboque, tvPneuSemReboque,
                            tvCarroca, tvMobilete, tvBicicleta, tvPassageiro, tvOutros]);
end;

function SitVeiculoToStr(const t: TSitVeiculo): String;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3'],
                           [svVazio, svCarregado, svNaoSeAplica]);
end;

function StrToSitVeiculo(out ok: Boolean; const s: String): TSitVeiculo;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3'],
                           [svVazio, svCarregado, svNaoSeAplica]);
end;

function tpDescontoToStr(const t: TTipoDesconto): String;
begin
  result := EnumeradoToStr(t,
                           ['', '01', '02', '03', '04', '05', '06', '07', '08',
                            '09', '10', '99'],
                           [tdNenhum, tdTarifaPromocional, tdIdoso, tdCrianca,
                            tdDeficiente, tdEstudante, tdAnimalDomestico,
                            tdAcordoColetivo, tdProfissionalemDeslocamento,
                            tdProfissionaldaEmpresa, tdJovem, tdOutrosDesc]);
end;

function StrTotpDesconto(out ok: Boolean; const s: String): TTipoDesconto;
begin
  result := StrToEnumerado(ok, s,
                           ['', '01', '02', '03', '04', '05', '06', '07', '08',
                            '09', '10', '99'],
                           [tdNenhum, tdTarifaPromocional, tdIdoso, tdCrianca,
                            tdDeficiente, tdEstudante, tdAnimalDomestico,
                            tdAcordoColetivo, tdProfissionalemDeslocamento,
                            tdProfissionaldaEmpresa, tdJovem, tdOutrosDesc]);
end;

function tpDescontoToDesc(const t: TTipoDesconto): String;
begin
  result := EnumeradoToStr(t,
                           ['', 'Tarifa Promocional', 'Idoso', 'Crian�a',
                            'Deficiente', 'Estudante', 'Animal Domestico',
                            'Acordo Coletivo', 'Profissional em Deslocamento',
                            'Profissional da Empresa', 'Jovem', 'Outros'],
                           [tdNenhum, tdTarifaPromocional, tdIdoso, tdCrianca,
                            tdDeficiente, tdEstudante, tdAnimalDomestico,
                            tdAcordoColetivo, tdProfissionalemDeslocamento,
                            tdProfissionaldaEmpresa, tdJovem, tdOutrosDesc]);
end;

function tpComponenteToStr(const t: TTipoComponente): String;
begin
  result := EnumeradoToStr(t,
                           ['01', '02', '03', '04', '05', '06', '99'],
                           [tcTarifa, tcPedagio, tcTaxaEmbarque, tcSeguro, tcTRM,
                            tcSVI, tcOutros]);
end;

function StrTotpComponente(out ok: Boolean; const s: String): TTipoComponente;
begin
  result := StrToEnumerado(ok, s,
                           ['01', '02', '03', '04', '05', '06', '99'],
                           [tcTarifa, tcPedagio, tcTaxaEmbarque, tcSeguro, tcTRM,
                            tcSVI, tcOutros]);
end;

function tpComponenteToDesc(const t: TTipoComponente): String;
begin
  result := EnumeradoToStr(t,
                           ['Tarifa', 'Pedagio', 'Taxa Embarque', 'Seguro',
                            'TRM', 'SVI', 'Outros'],
                           [tcTarifa, tcPedagio, tcTaxaEmbarque, tcSeguro, tcTRM,
                            tcSVI, tcOutros]);
end;

function BandeiraCardToStr(const t: TBandeiraCard): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '07', '08',
                               '09', '99'],
                              [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                              bcElo, bcDinersClub, bcHipercard, bcAura, bcCabal,
                              bcOutros]);
end;

function BandeiraCardToDescStr(const t: TBandeiraCard): string;
begin
  case t of
    bcVisa:            Result := 'Visa';
    bcMasterCard:      Result := 'MasterCard';
    bcAmericanExpress: Result := 'AmericanExpress';
    bcSorocred:        Result := 'Sorocred';
    bcElo:             Result := 'Elo';
    bcDinersClub:      Result := 'Diners Club';
    bcHipercard:       Result := 'Hipercard';
    bcAura:            Result := 'Aura';
    bcCabal:           Result := 'Cabal';
    bcOutros:          Result := 'Outros'
  end;
end;

function StrToBandeiraCard(out ok: boolean; const s: string): TBandeiraCard;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '07', '08',
                                   '09', '99'],
                                  [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                                   bcElo, bcDinersClub, bcHipercard, bcAura, bcCabal,
                                   bcOutros]);
end;

function StrToTpEventoBPe(out ok: boolean; const s: string): TpcnTpEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110111', '110115', '110116', '110117'],
            [teNaoMapeado, teCancelamento, teNaoEmbarque, teAlteracaoPoltrona,
             teExcessoBagagem]);
end;

function FormaPagamentoBPeToStr(const t: TFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '99'],
                              [fpDinheiro, fpCheque, fpCartaoCredito,
                               fpCartaoDebito, fpValeTransporte, fpPIX,
                               fpOutro]);
end;

function FormaPagamentoBPeToDescricao(const t: TFormaPagamento): string;
begin
  result := EnumeradoToStr(t,  ['Dinheiro', 'Cheque', 'Cart�o de Cr�dito',
                                'Cart�o de D�bito', 'Vale Transporte', 'PIX',
                               'Outro'],
                               [fpDinheiro, fpCheque, fpCartaoCredito,
                                fpCartaoDebito, fpValeTransporte, fpPIX,
                                fpOutro]);
end;

function StrToFormaPagamentoBPe(out ok: boolean; const s: string): TFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '99'],
                                  [fpDinheiro, fpCheque, fpCartaoCredito,
                                   fpCartaoDebito, fpValeTransporte, fpPIX,
                                   fpOutro]);
end;

function ModeloBPeToStr(const t: TModeloBPe): String;
begin
  Result := EnumeradoToStr(t, ['63', '63'], [moBPe, moBPeTM]);
end;

function StrToModeloBPe(out ok: Boolean; const s: String): TModeloBPe;
begin
  Result := StrToEnumerado(ok, s, ['63', '63'], [moBPe, moBPeTM]);
end;

function ModeloBPeToPrefixo(const t: TModeloBPe): String;
begin
  Case t of
    moBPeTM: Result := 'BPeTM';
  else
    Result := 'BPe';
  end;
end;

function TpEmisBPeToStr(const t: TTipoEmissao): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [teNormal, teOffLine]);
end;

function StrToTpEmisBPe(out ok: boolean; const s: string): TTipoEmissao;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                                  [teNormal, teOffLine]);
end;

initialization
  RegisterStrToTpEventoDFe(StrToTpEventoBPe, 'BPe');

end.

