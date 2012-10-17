program MusicBox;

uses
  Forms,
  TMusicBox in 'TMusicBox.pas' {Form1},
  MusicBoxObjects in 'MusicBoxObjects.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
