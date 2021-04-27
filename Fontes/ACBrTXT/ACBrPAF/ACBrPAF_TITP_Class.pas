{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: R�gys Borges da Silveira                        }
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
unit ACBrPAF_TITP_Class;

interface

uses
  SysUtils, Classes, DateUtils, ACBrTXTClass,
  ACBrPAF_TITP;

type

  { TPAF_TITP }

  TPAF_TITP = class(TACBrTXTClass)
  private
    FTitulo: String;
    FDataHora: TDateTime;
    FMercadorias: TTITP_Mercadorias;
    procedure WriteInsumos(Insumos: TTITP_Insumos);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LimpaRegistros;
    procedure WriteMercadorias;

    property Titulo: String read FTitulo write FTitulo;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property Mercadorias: TTITP_Mercadorias read FMercadorias write FMercadorias;
  end;

implementation

uses
  ACBrUtil;

const
  MASCARA_ITEM = '%s %10.3f %10s %14s %-50s %-4s %-3s %5.2f %11.2f';

{ TPAF_TITP }

constructor TPAF_TITP.Create;
begin
  inherited;
  FMercadorias := TTITP_Mercadorias.Create;
end;

destructor TPAF_TITP.Destroy;
begin
  FreeAndNil(FMercadorias);
  inherited;
end;

procedure TPAF_TITP.LimpaRegistros;
begin
  Titulo := EmptyStr;
  DataHora := 0;
  Mercadorias.Clear;
end;

procedure TPAF_TITP.WriteInsumos(Insumos: TTITP_Insumos);
var
  I: Integer;
begin
  for I := 0 to Insumos.Count - 1 do
  begin
    Add(
      Format(MASCARA_ITEM, [
        'I',
        Insumos[I].Quantidade,
        Insumos[I].Codigo,
        Insumos[I].Ean,
        Insumos[I].Descricao,
        Insumos[I].Unidade,
        Insumos[I].CST,
        Insumos[I].Aliquota,
        Insumos[I].VlrUnitario
      ]) );
  end;
  Conteudo.Add('');
end;

procedure TPAF_TITP.WriteMercadorias;
var
  I: Integer;
begin
  if Mercadorias.Count > 0 then
  begin
    // titulo
    Add(
      Format('%s %-10s %-10s %-14s %-50s %-4s %-3s %-5s %-9s', [
        'T',
        'Quantidade',
        'Codigo',
        'EAN',
        'Descri��o Produto',
        'Un.',
        'CST',
        'Aliq.',
        'Vl.Unitario'
      ]) );

    Add(
      Format('= %s %s %s %s %s %s %s %s', [
        LinhaDupla(10),
        LinhaDupla(10),
        LinhaDupla(14),
        LinhaDupla(50),
        LinhaDupla(4),
        LinhaDupla(3),
        LinhaDupla(5),
        LinhaDupla(11)
      ]) );

    // mercadorias
    for I := 0 to Mercadorias.Count - 1 do
    begin
      Add(
        Format(MASCARA_ITEM, [
          'P',
          Mercadorias[I].Quantidade,
          Mercadorias[I].Codigo,
          Mercadorias[I].Ean,
          Mercadorias[I].Descricao,
          Mercadorias[I].Unidade,
          Mercadorias[I].CST,
          Mercadorias[I].Aliquota,
          Mercadorias[I].VlrUnitario
        ]) );
      // insumos
      //for I := 0 to Mercadorias.Count - 1 do
        WriteInsumos(Mercadorias[I].Insumos);
    end;
    // Cria uma linha em branco para ficar igual ao exemplo antigo
    // N�o d� para usar s� Add por causa do Trim neste m�todo
    Conteudo.Add('');
  end;
end;

end.



