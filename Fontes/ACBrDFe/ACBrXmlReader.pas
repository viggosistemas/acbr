﻿{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  Rafael Teno Dias                               }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrXmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase, ACBrXmlDocument;

type
  { TACBrXmlReader }
  TACBrXmlReader = class
  private
    FArquivo: String;

  protected
    FDocument: TACBrXmlDocument;

  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean; virtual; abstract;
    function CarregarArquivo(const CaminhoArquivo: string): boolean; overload;
    function CarregarArquivo(const Stream: TStream): boolean; overload;
    function ProcessarCNPJCPF(const ANode: TACBrXmlNode): string;
    function ProcessarConteudo(const ANode: TACBrXmlNode; const Tipo: TACBrTipoCampo): variant;

    property Document: TACBrXmlDocument read FDocument;
    property Arquivo: String read FArquivo write FArquivo;

  end;

implementation

uses
  synautil, ACBrUtil;

{ TACBrXmlReader }
constructor TACBrXmlReader.Create;
begin
  FDocument := TACBrXmlDocument.Create();
end;

destructor TACBrXmlReader.Destroy;
begin
  if FDocument <> nil then FDocument.Free;
  inherited Destroy;
end;

function TACBrXmlReader.CarregarArquivo(const CaminhoArquivo: string): boolean;
var
  ArquivoXML: TStringList;
begin
  //NOTA: Carrega o arquivo xml na memória para posterior leitura de sua tag's
  ArquivoXML := TStringList.Create;
  try
    ArquivoXML.LoadFromFile(CaminhoArquivo);
    FArquivo := ArquivoXML.Text;
    Result := True;
  finally
    ArquivoXML.Free;
  end;
end;

function TACBrXmlReader.CarregarArquivo(const Stream: TStream): boolean;
begin
  //NOTA: Carrega o arquivo xml na memória para posterior leitura de sua tag's
  FArquivo := ReadStrFromStream(Stream, Stream.Size);
  Result := True;
end;

function TACBrXmlReader.ProcessarCNPJCPF(const ANode: TACBrXmlNode): string;
begin
  Result := ProcessarConteudo(ANode.Childrens.Find('CNPJ'), tcStr);
  if Trim(Result) = '' then
    Result := ProcessarConteudo(ANode.Childrens.Find('CPF'), tcStr);
end;

function TACBrXmlReader.ProcessarConteudo(const ANode: TACBrXmlNode; const Tipo: TACBrTipoCampo): variant;
begin
  Result := ProcessarConteudoXml(ANode, Tipo);
end;

end.

