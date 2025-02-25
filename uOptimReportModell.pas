unit uOptimReportModell;

interface
uses SysUtils;

const TitleBegin = 'title="';

type
  TOptimReport = class(TObject)
  strict private
    FRowNumber: integer;
    FProfit: double;
    FOrdersNo: integer;
    FProfitFactor: double;
    FExpectedResult: double;
    FDdInMoney: double;
    FDdInPercent: double;
    FSettings: string;

  public
    procedure StringToOptimReport(const AText: string);
    function GetFloatingFromStr(ATxt: string): double;

    property RowNumber: integer read FRowNumber;
    property Profit: double read FProfit;
    property OrdersNo: integer read FOrdersNo;
    property ProfitFactor: double read FProfitFactor;
    property ExpectedResult: double read FExpectedResult;
    property DdInMoney: double read FDdInMoney;
    property DdInPercent: double read FDdInPercent;
    property Settings: string read FSettings;
  end;

implementation

uses
  System.StrUtils, System.Classes;

{ TOptimReport }

procedure TOptimReport.StringToOptimReport(const AText: string);
const TitleEnd = '">';
const DataSep = '</td><td class=mspt>';
var
  Temptxt: string;
  Bg, Ed: integer;
  Sl: TStringList;
begin
// <tr align=right><td title="Risk=0.8; SetLanguages=1; RiskFromAllTimeHigh=1; FixLot=0.02; ManLotsCorr=1; TakeProfit=900; StopLoss=40; StopLossBySRlvl=0;
// MinTavFromOOP=10; ReOpenSameCandle=1; ReOpenAfterCandle=2; MaxSpread=5; Slippage=1; TrailingStop=60; SlAreEqvTs=0; LetHalfOfSL=0; UseSupResLevels=0;
// SupResLvlAfterOpen=0; TsBeforeBE=0; TradeOnFriday=1; FridayCloseHour=17; Magic=63589; DailyMaxLoss=0; WeeklyMaxLoss=0; MonthLyMaxLoss=0; ChartButtons=1;
// ShutDown=0; debug=0; debug_lots=0; debug_ks=0; debug_DLL=0; PrintToLog=0; CloseOnlyProfit=1; Display_Text=1; iMA_PeriodLONG=100; iMA_PeriodSHORT=75;
// LeftBars=5; RightBars=5; VolumeTreshold=20; iATR_PeriodLONG=10; iWPR_PeriodLONG=11; iWPR_LONG_Open_a=-60; iMA_LONG_Open_a=6; iCCI_PeriodLONG=30;
// iMA_LONG_Open_b=36; iWPR_LONG_Open_b=-92; iATR_PeriodShort=18; iWPR_PeriodShort=14; iMA_Short_Open_a=18; iWPR_Short_Open_a=-20; iCCI_PeriodShort=12;
// iMA_Short_Open_b=20; iWPR_Short_Open_b=-6; FilterATR=4; iCCI_OpenFilter=130; Price_Filter_Close=10; iWPR_Filter_Close=86; VolaFilter=2; LongPos=1; ShortPos=1; MaxLossPoints=-100; ">
// 8</td><td class=mspt>89767.51</td><td>2024</td><td class=mspt>1.21</td><td class=mspt>44.35</td><td class=mspt>20750.68</td><td class=mspt>21.14</td></tr>
  Bg := POS(TitleBegin, AText) + Length(TitleBegin);
  Ed := POS(TitleEnd, AText);
  FSettings := AText.Substring(Bg, Ed-Bg);
  Temptxt := AText.Substring(Ed).Replace(DataSep, ';').Replace('</td><td>', ';').Replace('</td></tr>', ';').Replace('>', '');
  Sl := TStringList.Create();
  try
    Sl.StrictDelimiter := true;
    Sl.Delimiter := ';';
    Sl.DelimitedText := Temptxt;
    FRowNumber := StrToInt(Sl[0]);
    FProfit := GetFloatingFromStr(Sl[1]);
    FOrdersNo := StrToInt(Sl[2]);
    FProfitFactor := GetFloatingFromStr(Sl[3]);
    FExpectedResult := GetFloatingFromStr(Sl[4]);
    FDdInMoney := GetFloatingFromStr(Sl[5]);
    FDdInPercent := GetFloatingFromStr(Sl[6]);
  finally
    Sl.Free;
  end;
end;

function TOptimReport.GetFloatingFromStr(ATxt: string): double;
begin
  Result := StrToFloat(ATxt.Replace('.', FormatSettings.DecimalSeparator).Replace(',', FormatSettings.DecimalSeparator));
end;

end.
