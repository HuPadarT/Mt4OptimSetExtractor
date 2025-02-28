unit uMt4OptimSetExtractor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uOptimReportModell, uViewModel,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.ComCtrls;

const defCaption = 'Mt4 optimization report Set Extractor';

type
  TfrmMt4OptimSetExtractor = class(TForm)
    DBGrid1: TDBGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    btnImport: TButton;
    btnSaveSet: TButton;
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveSetClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FFileName: string;
    FViewModel: TViewModel;
    procedure SelectReport;
    procedure StatusBarPanelsResize();

  public
    { Public declarations }
  end;

var
  frmMt4OptimSetExtractor: TfrmMt4OptimSetExtractor;

implementation

{$R *.dfm}

{ TfrmMt4OptimSetExtractor }

procedure TfrmMt4OptimSetExtractor.btnImportClick(Sender: TObject);
begin
  SelectReport;
  FViewModel.LoadFromFile(FFileName);
  self.Caption := defCaption + ' - ' + ExtractFileName(FFileName);
  StatusBar1.Panels[0].Text := FFileName;
  StatusBar1.Panels[1].Text := ExtractFileName(FFileName) + '    ';
  DataSource1.DataSet := FViewModel.ClientDataSet;
  DBGrid1.DataSource := DataSource1;
end;

procedure TfrmMt4OptimSetExtractor.btnSaveSetClick(Sender: TObject);
var
  I: integer;
begin
  SaveDialog1.Filter := 'SET (*.set)|*.set';
  SaveDialog1.FileName := FFileName;
  SaveDialog1.DefaultExt := 'set';
  if SaveDialog1.Execute then
  begin
    I := DBGrid1.DataSource.DataSet.FieldByName('RowNumber').AsInteger;
    FViewModel.SaveSetToFile(ChangeFileExt(SaveDialog1.FileName, ''), I);
  end;
end;

procedure TfrmMt4OptimSetExtractor.DBGrid1TitleClick(Column: TColumn);
var
  FieldName: string;
  IndexName: string;
  Descending: Boolean;
begin
  if Column.Field <> nil then
  begin
    FieldName := Column.Field.FieldName;
    Descending := FViewModel.ClientDataSet.IndexName = 'Descending_' + FieldName;
    if Descending then
      IndexName := 'Ascending_' + FieldName
    else
      IndexName := 'Descending_' + FieldName;
    FViewModel.ClientDataSet.IndexName := IndexName;
  end;
end;

procedure TfrmMt4OptimSetExtractor.FormCreate(Sender: TObject);
begin
  FViewModel := TViewModel.Create();
  StatusBarPanelsResize;
end;

procedure TfrmMt4OptimSetExtractor.FormDestroy(Sender: TObject);
begin
  if Assigned(FViewModel) then
    FreeAndNil(FViewModel);
end;

procedure TfrmMt4OptimSetExtractor.FormResize(Sender: TObject);
begin
  StatusBarPanelsResize
end;

procedure TfrmMt4OptimSetExtractor.SelectReport;
begin
  OpenDialog1.Filter := 'HTM (*.htm)|*.htm';
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      FFilename := OpenDialog1.FileName;
    end
    else
    begin
      ShowMessage('File not found!');
    end;
  end;
end;

procedure TfrmMt4OptimSetExtractor.StatusBarPanelsResize;
begin
  StatusBar1.Panels[0].Width := StatusBar1.Width div 2;
  StatusBar1.Panels[1].Width := StatusBar1.Width div 2;
end;

end.
