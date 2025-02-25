unit uMt4OptimSetExtractor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uOptimReportModell, uViewModel,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TfrmMt4OptimSetExtractor = class(TForm)
    DBGrid1: TDBGrid;
    btnImport: TButton;
    btnSaveSet: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    DataSource1: TDataSource;
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveSetClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    FFilename: string;
    FViewModel: TViewModel;
    procedure SelectReport;

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
  FViewModel.LoadFromFile(FFilename);
  DataSource1.DataSet := FViewModel.ClientDataSet;
  DBGrid1.DataSource := DataSource1;
end;

procedure TfrmMt4OptimSetExtractor.btnSaveSetClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'SET (*.set)|*.set';
  if SaveDialog1.Execute then
  begin
    // itt majd még kitalálom
  end;
end;

procedure TfrmMt4OptimSetExtractor.DBGrid1TitleClick(Column: TColumn);
begin
  if Column.Field <> nil then
  begin
    { TODO
    if FViewModel.ClientDataSet.IndexFieldNames = Column.Field.FieldName then
      FViewModel.ClientDataSet.IndexFieldNames := Column.Field.FieldName + ' DESC'
    else}
      FViewModel.ClientDataSet.IndexFieldNames := Column.Field.FieldName;
  end;
end;

procedure TfrmMt4OptimSetExtractor.FormCreate(Sender: TObject);
begin
  FViewModel := TViewModel.Create();
end;

procedure TfrmMt4OptimSetExtractor.FormDestroy(Sender: TObject);
begin
  if Assigned(FViewModel) then
    FreeAndNil(FViewModel);
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

end.
