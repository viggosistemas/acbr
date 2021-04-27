﻿{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Jurisato Junior                           }
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

unit ACBrLibCHQDataModule;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, ACBrLibComum, ACBrLibConfig, syncobjs, ACBrCHQ;

type

  { TLibCHQDM }

  TLibCHQDM = class(TDataModule)
    ACBrCHQ1: TACBrCHQ;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FLock: TCriticalSection;
    fpLib: TACBrLib;

  public
    procedure AplicarConfiguracoes;
    procedure GravarLog(AMsg: String; NivelLog: TNivelLog; Traduzir: Boolean = False);
    procedure Travar;
    procedure Destravar;

    property Lib: TACBrLib read fpLib write fpLib;
  end;

implementation

uses
  ACBrUtil, ACBrDeviceSerial,
  ACBrLibCHQConfig, ACBrLibCHQBase;

{$R *.lfm}

{ TLibCHQDM }

procedure TLibCHQDM.DataModuleCreate(Sender: TObject);
begin
  FLock := TCriticalSection.Create;
end;

procedure TLibCHQDM.DataModuleDestroy(Sender: TObject);
begin
  FLock.Destroy;
end;

procedure TLibCHQDM.AplicarConfiguracoes;
var
  LibConfig: TLibCHQConfig;
begin
  LibConfig := TLibCHQConfig(TACBrLibCHQ(Lib).Config);

  with ACBrCHQ1 do
  begin
    Porta := LibConfig.CHQConfig.Porta;
    Modelo := LibConfig.CHQConfig.Modelo;
    PaginaDeCodigo := LibConfig.CHQConfig.PaginaDeCodigo;

    Device.Baud := LibConfig.CHQDeviceConfig.Baud;
    Device.Data := LibConfig.CHQDeviceConfig.Data;
    Device.TimeOut := LibConfig.CHQDeviceConfig.TimeOut;
    Device.Parity := TACBrSerialParity(LibConfig.CHQDeviceConfig.Parity);
    Device.Stop := TACBrSerialStop(LibConfig.CHQDeviceConfig.Stop);
    Device.MaxBandwidth := LibConfig.CHQDeviceConfig.MaxBandwidth;
    Device.SendBytesCount := LibConfig.CHQDeviceConfig.SendBytesCount;
    Device.SendBytesInterval := LibConfig.CHQDeviceConfig.SendBytesInterval;
    Device.HandShake := TACBrHandShake(LibConfig.CHQDeviceConfig.HandShake);
    Device.HardFlow := LibConfig.CHQDeviceConfig.HardFlow;
    Device.SoftFlow := LibConfig.CHQDeviceConfig.SoftFlow;
  end;
end;

procedure TLibCHQDM.GravarLog(AMsg: String; NivelLog: TNivelLog;
  Traduzir: Boolean);
begin
  if Assigned(Lib) then
    Lib.GravarLog(AMsg, NivelLog, Traduzir);
end;

procedure TLibCHQDM.Travar;
begin
  GravarLog('Travar', logParanoico);
  FLock.Acquire;
end;

procedure TLibCHQDM.Destravar;
begin
  GravarLog('Destravar', logParanoico);
  FLock.Release;
end;

end.

