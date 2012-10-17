unit MusicBoxObjects;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Extctrls, Forms, Dialogs, StdCtrls;

type
  TMusicGrid = class(TShape)
  private
    FActive: Boolean;
    FCount: Integer;
    FTone: Integer;
    FTimeTone: Integer;
  public
    ActiveTimer,SoundTimer:TTimer;
    constructor Create(AOwner: TComponent); override;
    function GetActive: Boolean;
    procedure SetActive(New: Boolean);
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseEnter(Sender: TObject);
    property Active: Boolean read GetActive write SetActive;
    property Count: Integer read FCount write FCount;
    property Tone: Integer read FTone write FTone;
    property TimeTone: Integer read FTimeTone write FTimeTone;
  end;

const
  size:integer=25;  //Grid box size

var
  counter:integer=0; //grid count holder
  MD:boolean;  //MouseDown holder
  CurrentActive:boolean; //Active holder

implementation

procedure TMusicGrid.SetActive(New: Boolean);
begin
  FActive:=New;
  if Active then
  Brush.Color:=clWhite
  else Brush.Color:=clGray;
end;

function TMusicGrid.GetActive;
begin
  GetActive:=FActive;
end;

procedure TMusicGrid.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then
  button:=mbright;
  MD:=true;
  if Active then
  Active:=false
  else Active:=true;
  CurrentActive:=Active;
end;

procedure TMusicGrid.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  MD:=false
end;

procedure TMusicGrid.MouseEnter(Sender: TObject);
begin
  if MD then
  Active:=CurrentActive;
end;

constructor TMusicGrid.Create(AOwner: TComponent);
begin
  inherited;

  MD:=false;
  inc(counter);
  count:=counter;
  height:=size;
  width:=size;
  brush.Color:=clGray;
  active:=false;
  shape:=stRoundSquare;

  if count mod 16 = 0 then
  Tone:=16
  else Tone:=count mod 16;

  if count div 16 = 0 then
  TimeTone:=1
  else TimeTone:=count div 16;

  OnMouseDown:=MouseDown;
  OnMouseUp:=MouseUp;
  OnMouseEnter:=MouseEnter;

end;

end.
