program Mt4OptimSetExtractor;

uses
  Vcl.Forms, midaslib, // hogy ne kelljen melle a dll file is
  uMt4OptimSetExtractor in 'uMt4OptimSetExtractor.pas' {frmMt4OptimSetExtractor},
  uOptimReportModell in 'uOptimReportModell.pas',
  uViewModel in 'uViewModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMt4OptimSetExtractor, frmMt4OptimSetExtractor);
  Application.Run;
end.
