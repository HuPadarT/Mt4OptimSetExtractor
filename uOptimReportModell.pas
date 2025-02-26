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
  Bg := POS(TitleBegin, AText) + Length(TitleBegin);
  Ed := POS(TitleEnd, AText);
  FSettings := AText.Substring(Bg, Ed-Bg);
  Temptxt := AText.Substring(Ed).Replace(DataSep, ';', [rfReplaceAll]).Replace('</td><td>', ';', [rfReplaceAll]).Replace('</td></tr>', ';', [rfReplaceAll]).Replace('>', '', [rfReplaceAll]);
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
