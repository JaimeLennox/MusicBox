unit TMusicBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MusicBoxObjects, ExtCtrls, MMSystem;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    SoundTimer:TTimer;
    procedure STimer(Sender: TObject);
    procedure MusicBeep(freq:integer);
    procedure SendMCICommand(Cmd: string);
    { Public declarations }
  end;

var
  Form1: TForm1;
  Grid: array[1..45,1..16] of TMusicGrid;
  ToneCounter:integer;

const
  inum:integer=45;
  jnum:integer=16;

implementation

{$R *.dfm}

procedure TForm1.SendMCICommand(Cmd: string);
var
  RetVal: Integer;
  ErrMsg: array[0..254] of char;
begin
  RetVal := mciSendString(PChar(Cmd), nil, 0, 0);
  if RetVal <> 0 then
  begin
    {get message for returned value}
    mciGetErrorString(RetVal, ErrMsg, 255);
    MessageDlg(StrPas(ErrMsg), mtError, [mbOK], 0);
  end;
end;

procedure TForm1.MusicBeep(freq:integer);
begin
//  SndPlaySound(PChar('../../Resources/'+inttostr(freq)+'.wav'),SND_ASYNC);
  SendMCICommand('play "../../Resources/'+inttostr(freq)+'.wav"');
end;

procedure TForm1.STimer(Sender: TObject);
var
  i,j:integer;
begin
  inc(ToneCounter);
  if ToneCounter = inum+1 then
  ToneCounter:=1;

  for i := 1 to inum do
  for j := 1 to jnum do
  begin
    with Grid[i,j] do
    if (TimeTone = ToneCounter) AND Active then
    begin
      Brush.Color:=clRed;
      case Tone of
      1:Musicbeep(1109);
      2:MusicBeep(932);
      3:MusicBeep(831);
      4:MusicBeep(740);
      5:MusicBeep(622);
      6:MusicBeep(554);
      7:MusicBeep(466);
      8:MusicBeep(415);
      9:MusicBeep(370);
      10:MusicBeep(311);
      11:MusicBeep(277);
      12:MusicBeep(233);
      13:MusicBeep(208);
      14:MusicBeep(185);
      15:MusicBeep(156);
      16:MusicBeep(139);
      end;
    end
    else if Active then
    Brush.Color:=clWhite
    else Brush.Color:=clGray;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SendMCICommand('close waveaudio');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i,j:integer;
begin
  for i := 1 to inum do
  for j := 1 to jnum do
  begin
    Grid[i,j]:=TMusicGrid.Create(self);
    with Grid[i,j] do
    begin
        Left:=Width*i;
        Top:=Height*j;
        parent:=self;
    end;
  end;

  doublebuffered:=true;
  Width:=Grid[inum,1].Left+Grid[inum,1].Width*3;
  Height:=Grid[1,jnum].Top+Grid[1,jnum].Height*3;
  Brush.Color:=clBlack;

  SoundTimer:=TTimer.Create(self);
  SoundTimer.Interval:=125;
  SoundTimer.OnTimer:=STimer;

  SendMCICommand('open waveaudio shareable');

end;

end.
