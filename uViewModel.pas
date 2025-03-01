unit uViewModel;

interface

uses
  System.Classes, System.SysUtils, Datasnap.DBClient, Data.DB, System.Generics.Collections,
  uOptimReportModell, Data.FMTBcd, Data.SqlExpr;

type
  TViewModel = class

  private
    FReportList: TObjectList<TOptimReport>;
    FClientDataSet: TClientDataSet;
    FProgressStatus: string;
    procedure SyncToClientDataSet;
    procedure BuildIndices;
    function GetSettingByRowNumber(const AIdx: Integer): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveSetToFile(const AFileName: string; const RwNo: integer);

    property ClientDataSet: TClientDataSet read FClientDataSet;
    property StatusMessage: string read FProgressStatus;
  end;

implementation

{ TViewModel }

constructor TViewModel.Create;
begin
  FReportList := TObjectList<TOptimReport>.Create(True);

  FClientDataSet := TClientDataSet.Create(nil);
  with FClientDataSet.FieldDefs do
  begin
    Add('RowNumber', ftInteger);
    Add('Profit', ftFloat);
    Add('OrdersNo', ftInteger);
    Add('ProfitFactor', ftFloat);
    Add('ExpectedResult', ftFloat);
    Add('DdInMoney', ftFloat);
    Add('DdInPercent', ftFloat);
    Add('Settings', ftString, 400);
  end;
  FClientDataSet.CreateDataSet;
  BuildIndices;
end;

Procedure TViewModel.BuildIndices;
var
 alist: tstrings;
begin
 with FClientDataSet do
  begin
   logchanges:= false;
   for var i:= 0 to FieldCount - 1 do
    if (fields[i].fieldkind <> fkCalculated) and not (fields[i].DataType in [ftString, ftWideString, ftMemo]) then
     begin
      addindex ('Ascending_' + fieldlist.strings[i], fieldlist.strings[i], [], '', '',  0);
      addindex ('Descending_' + fieldlist.strings[i], fieldlist.strings[i], [ixDescending], '', '', 0);
     end;
   alist:= tstringlist.create;
   getindexnames (alist);
   alist.free;
  end;
end;

destructor TViewModel.Destroy;
begin
  if Assigned(FReportList) then
    FreeAndNil(FReportList);

  inherited;
end;

function TViewModel.GetSettingByRowNumber(const AIdx: Integer): string;
begin
  for var I := 0 to FReportList.Count - 1 do
  begin
    if FReportList[I].RowNumber = AIdx then
    begin
      Result := FReportList[I].Settings.Replace('"', '', [rfReplaceAll]).Replace(' ', '', [rfReplaceAll]);
      Break;
    end;
  end;
end;

procedure TViewModel.LoadFromFile(const AFileName: string);
var
  Item: TOptimReport;
  SL: TStringList;
  i: Integer;
begin
  if FReportList.Count > 0 then
  begin // ha m�r volt benne adat, akkor t�r�lni kell
    FReportList.Clear;
    FClientDataSet.EmptyDataSet;
  end;
  FProgressStatus := '';
  SL := TStringList.Create;
  try
    SL.LoadFromFile(AFileName);
    if not Sl.Text.Contains('Optimization Report') and (AFileName.Contains('htm')) then
    begin
      FProgressStatus := 'This is not optimization report!';
      Exit;
    end;
    if POS('DOCTYPE HTML', SL[0]) < 1 then // ha nem HTM f�jl
    begin
      for i := 0 to SL.Count - 1 do
      begin
        if Length(SL[i]) < 5 then // ha �res, akkor kihagyjuk
          Continue;

        Item := TOptimReport.Create;
        Item.CsvToOptimReport(SL[i]);
        FReportList.Add(Item);
      end;
    end
    else // itt HTM report�l van sz�
    begin
      for i := 0 to SL.Count - 1 do
      begin
        if Length(SL[i]) < 5 then // ha �res, akkor kihagyjuk
          Continue;

        if Pos(TitleBegin, SL[i]) > 0 then // ha van benne be�ll�t�s - table row
        begin
          Item := TOptimReport.Create;
          Item.TableRowToOptimReport(SL[i]);
          FReportList.Add(Item);
        end;
      end;
    end;
  finally
    SL.Free;
  end;
  SyncToClientDataSet();
end;

procedure TViewModel.SyncToClientDataSet;
var
  Item: TOptimReport;
begin
  FClientDataSet.DisableControls;
  try
    FClientDataSet.EmptyDataSet;
    for Item in FReportList do
    begin
      FClientDataSet.Append;
      FClientDataSet.FieldByName('RowNumber').AsInteger := Item.RowNumber;
      FClientDataSet.FieldByName('Profit').AsFloat := Item.Profit;
      FClientDataSet.FieldByName('OrdersNo').AsInteger := Item.OrdersNo;
      FClientDataSet.FieldByName('ProfitFactor').AsFloat := Item.ProfitFactor;
      FClientDataSet.FieldByName('ExpectedResult').AsFloat := Item.ExpectedResult;
      FClientDataSet.FieldByName('DdInMoney').AsFloat := Item.DdInMoney;
      FClientDataSet.FieldByName('DdInPercent').AsFloat := Item.DdInPercent;
      FClientDataSet.FieldByName('Settings').AsString := Item.Settings;
      FClientDataSet.Post;
    end;
  finally
    FClientDataSet.EnableControls;
    FClientDataSet.First;
  end;
end;

procedure TViewModel.SaveSetToFile(const AFileName: string; const RwNo: integer);
var
  SL: TStringList;
begin
  if FReportList.Count > 0 then
  begin
    Sl := TStringList.Create;
    try
      Sl.StrictDelimiter := true;
      Sl.Delimiter := ';';
      Sl.DelimitedText := sLineBreak + GetSettingByRowNumber(RwNo); // kell az elej�re egy �res sor, hogy az mt4 a legels� v�ltoz� �rt�k�t is be tudja t�lteni
      Sl.SaveToFile(AFileName + '_Rwno_' + RwNo.ToString + '.set', TEncoding.UTF8);
    finally
      Sl.Free;
    end;
  end;
end;

end.
