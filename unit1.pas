unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, ColorBox, Grids, Variants;

type

  { TForm1 }

  TForm1 = class(TForm)
    ColorBox1: TColorBox;
    Dibujo: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    GenFigura: TMenuItem;
    MenuItem5: TMenuItem;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure GenFiguraClick(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  Figura = Object
    x, y: array [1..12] of integer;
    cx, cy: Integer;
  end;

  TMatriz = ARRAY[1..12, 1..12] OF Double;


var
  Form1: TForm1;
  Flecha, Tetris, E, H: Figura;
  T : TMatriz;
  x0, y0 : INTEGER;
  Colores: ARRAY of string;

implementation

{$R *.lfm}

Procedure Iniciar;
var i: Integer;
Begin
  //Points of the E figure.
  E.x[1] :=   30;          E.y[1] := 30;
  E.x[2] :=  E.x[1]+90;    E.y[2] := E.y[1];
  E.x[3] :=  E.x[1]+90;    E.y[3] := E.y[1]+30;
  E.x[4] :=  E.x[1]+30;    E.y[4] := E.y[1]+30;
  E.x[5] :=  E.x[1]+30;    E.y[5] := E.y[1]+60;
  E.x[6] :=  E.x[1]+60;    E.y[6] := E.y[1]+60;
  E.x[7] :=  E.x[1]+60;    E.y[7] := E.y[1]+90;
  E.x[8] :=  E.x[1]+30;    E.y[8] := E.y[1]+90;
  E.x[9] :=  E.x[1]+30;    E.y[9] := E.y[1]+120;
  E.x[10] := E.x[1]+90;    E.y[10]:= E.y[1]+120;
  E.x[11] := E.x[1]+90;    E.y[11]:= E.y[1]+150;
  E.x[12] := E.x[1];       E.y[12]:= E.y[1]+150;
  for i:= 1 to 12 do begin
    E.cx+= E.x[i];
    E.cy+= E.y[i];
  end;
  E.cx := E.cx DIV 12;
  E.cy := E.cy DIV 12;

  //Tetris Figure
  Tetris.x[1] := 30;                   Tetris.y[1] := 30;
  Tetris.x[2] := Tetris.x[1]+30;       Tetris.y[2] := Tetris.y[1];
  Tetris.x[3] := Tetris.x[1]+30;       Tetris.y[3] := Tetris.y[1]+60;
  Tetris.x[4] := Tetris.x[1]+120;      Tetris.y[4] := Tetris.y[1]+60;
  Tetris.x[5] := Tetris.x[1]+120;      Tetris.y[5] := Tetris.y[1]+150;
  Tetris.x[6] := Tetris.x[1]+90;       Tetris.y[6] := Tetris.y[1]+150;
  Tetris.x[7] := Tetris.x[1]+90;       Tetris.y[7] := Tetris.y[1]+90;
  Tetris.x[8] := Tetris.x[1];          Tetris.y[8] := Tetris.y[1]+90;
  for i:= 1 to 9 do begin
    Tetris.cx+= Tetris.x[i];
    Tetris.cy+= Tetris.y[i];
  end;
  Tetris.cx := Tetris.cx DIV 8;
  Tetris.cy := Tetris.cy DIV 8;

  //Points of the Arrow.
  Flecha.x[1] := 75;                    Flecha.y[1] := 30;
  Flecha.x[2] := Flecha.x[1]-45;        Flecha.y[2] := Flecha.y[1]+30;
  Flecha.x[3] := Flecha.x[2]+30;        Flecha.y[3] := Flecha.y[1]+30;
  Flecha.x[4] := Flecha.x[2]+30;        Flecha.y[4] := Flecha.y[1]+120;
  Flecha.x[5] := Flecha.x[2];           Flecha.y[5] := Flecha.y[1]+150;
  Flecha.x[6] := Flecha.x[2]+90;        Flecha.y[6] := Flecha.y[1]+150;
  Flecha.x[7] := Flecha.x[2]+60;        Flecha.y[7] := Flecha.y[1]+120;
  Flecha.x[8] := Flecha.x[2]+60;        Flecha.y[8] := Flecha.y[1]+30;
  Flecha.x[9] := Flecha.x[2]+90;        Flecha.y[9] := Flecha.y[1]+30;
    for i:= 1 to 8 do begin
      Flecha.cx+= Flecha.x[i];
      Flecha.cy+= Flecha.y[i];
    end;
  Flecha.cx := Flecha.cx DIV 8;
  Flecha.cy := Flecha.cy DIV 8;

  //H
  H.x[1] := 30;               H.y[1] := 30;
  H.x[2] := H.x[1]+30;        H.y[2] := H.y[1];
  H.x[3] := H.x[1]+30;        H.y[3] := H.y[1]+60;
  H.x[4] := H.x[1]+90;        H.y[4] := H.y[1]+60;
  H.x[5] := H.x[1]+90;        H.y[5] := H.y[1];
  H.x[6] := H.x[1]+120;       H.y[6] := H.y[1];
  H.x[7] := H.x[1]+120;       H.y[7] := H.y[1]+150;
  H.x[8] := H.x[1]+90;        H.y[8] := H.y[1]+150;
  H.x[9] := H.x[1]+90;        H.y[9] := H.y[1]+90;
  H.x[10]:= H.x[1]+30;        H.y[10] := H.y[1]+90;
  H.x[11]:= H.x[1]+30;        H.y[11] := H.y[1]+150;
  H.x[12]:= H.x[1];           H.y[12] := H.y[1]+150;
  for i:= 1 to 12 do begin
    H.cx+= H.x[i];
    H.cy+= H.y[i];
  end;
  H.cx := H.cx DIV 12;
  H.cy := H.cy DIV 12;
end;

Procedure tFig(fig: Figura; c, x, y: Integer);
var i: Integer;
begin
  Form1.Canvas.MoveTo(fig.x[1]+x, fig.y[1]+y);
  for i:= Low(fig.x) to High(fig.x) do begin
    if fig.x[i] > 0 then
       Form1.Canvas.LineTo(fig.x[i]+x, fig.y[i]+y);
  end;
  Form1.Canvas.LineTo(fig.x[1]+x, fig.y[1]+y);

  //Pintar figura
  Form1.Canvas.Brush.Color := c;
  Form1.Canvas.FloodFill(fig.cx+x, fig.cy+y, clBlack, fsBorder);
end;

procedure Ejemplos;
Begin
  Form1.Canvas.Pen.Color := clBlack;
  Form1.Canvas.Pen.Width:= 2;
  tFig(E, clYellow, 0, 0);
  tFig(H, clRed, 100, 0);
  tFig(Tetris, clBlue, 230, 0);
  tFig(Flecha, clMaroon, 360, 0);
end;

Procedure Multiplicar;
  VAR M, P : TMatriz;
      i, j, k: Integer; //Para los for.
Begin
  for i := 1 to 9 do begin
    M[i, 1] := Flecha.x[i];
    M[i, 2] := Flecha.y[i];
    M[i, 3] := 1;
  end;
  for i := 1 to 9 do
    for j := 1 to 9 do begin
      P[i, j] := 0;
      for k := 1 to 9 do
          P[i, j] := P[i, j] + M[i, k] * T[k, j];
    end;
    for i := 1 to 9 do begin
      Flecha.x[i] := ROUND(P[i, 1]);
      Flecha.y[i] := ROUND(P[i, 2]);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Iniciar;
  Form1.Canvas.Pen.Color := clBackground;
end;

procedure TForm1.GenFiguraClick(Sender: TObject);
var i: Integer;
begin
  Randomize;
  i := Random(4);
  Edit1.Text:= IntToStr(i);
  Edit2.Text:= IntToStr(Random(Color));
  Form1.Canvas.Pen.Color := clBlack;
  Form1.Canvas.Pen.Width:= 2;
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.FillRect(270,260,410,430);
  case i of
       0: tFig(E, Random(Color), 250, 240);
       1: tFig(H, Random(Color), 250, 240);
       2: tFig(Tetris, Random(Color), 250, 240);
       3: tFig(Flecha, Random(Color), 250, 240);
  end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Ejemplos;
  RadioGroup1.Enabled:= true;
  GenFigura.Enabled:= true;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.FillRect(430,260,580,430);
  tFig(E, ColorBox1.Selected, 420, 240);
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.FillRect(430,260,580,430);
  tFig(H, ColorBox1.Selected, 420, 240);
end;

procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.FillRect(430,260,580,430);
  tFig(Tetris, ColorBox1.Selected, 420, 240);
end;

procedure TForm1.RadioButton4Change(Sender: TObject);
begin
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.FillRect(430,260,580,430);
  tFig(Flecha, ColorBox1.Selected, 420, 240);
end;

end.
