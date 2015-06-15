unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, Arrow, ColorBox, Variants;

type

  { TForm1 }

  TForm1 = class(TForm)
    ColorBox1: TColorBox;
    Dibujo: TButton;
    Izquierda: TArrow;
    Arriba: TArrow;
    Derecha: TArrow;
    Abajo: TArrow;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  TPunto = RECORD          //Cada figura comprende de un x, y para ser dibujada.
    x, y : INTEGER;
  END;

  TFigura = ARRAY[1..12] OF TPunto;
  TMatriz = ARRAY[1..3, 1..3] OF Double;

var
  Form1: TForm1;
  F, G, E, H : TFigura;      //Flecha, Tetris, E, H
  T : TMatriz;
  x0, y0 : INTEGER;

implementation

{$R *.lfm}

Procedure Iniciar;
Begin
  //Points of the E figure.
  E[1].x :=   30; E[1].y := 30;
  E[2].x :=  120; E[2].y := 30;
  E[3].x :=  120; E[3].y := 60;
  E[4].x :=   60; E[4].y := 60;
  E[5].x :=   60; E[5].y := 90;
  E[6].x :=   90; E[6].y := 90;
  E[7].x :=   90; E[7].y := 120;
  E[8].x :=   60; E[8].y := 120;
  E[9].x :=   60; E[9].y := 150;
  E[10].x := 120; E[10].y := 150;
  E[11].x := 120; E[11].y := 180;
  E[12].x :=  30; E[12].y := 180;
  //Points of the "Tetris" figure.
  F[1].x :=  60+80; F[1].y := 30;
  F[2].x :=  90+80; F[2].y := 30;
  F[3].x :=  90+80; F[3].y := 90;
  F[4].x := 180+80; F[4].y := 90;
  F[5].x := 180+80; F[5].y := 180;
  F[6].x := 150+80; F[6].y := 180;
  F[7].x := 150+80; F[7].y := 120;
  F[8].x :=  60+80; F[8].y := 120;
  //Points of the Arrow.
  G[1].x :=  75+260; G[1].y := 30;
  G[2].x :=  30+260; G[2].y := 60;
  G[3].x :=  60+260; G[3].y := 60;
  G[4].x :=  60+260; G[4].y := 150;
  G[5].x :=  30+260; G[5].y := 180;
  G[6].x := 120+260; G[6].y := 180;
  G[7].x :=  90+260; G[7].y := 150;
  G[8].x :=  90+260; G[8].y := 60;
  G[9].x := 120+260; G[9].y := 60;
  //H
  H[1].x :=   30+400; H[1].y := 30;
  H[2].x :=   60+400; H[2].y := 30;
  H[3].x :=   60+400; H[3].y := 90;
  H[4].x :=   120+400; H[4].y := 90;
  H[5].x :=   120+400; H[5].y := 30;
  H[6].x :=   150+400; H[6].y := 30;
  H[7].x :=   150+400; H[7].y := 180;
  H[8].x :=   120+400; H[8].y := 180;
  H[9].x :=   120+400; H[9].y := 120;
  H[10].x :=  60+400; H[10].y := 120;
  H[11].x :=   60+400; H[11].y := 180;
  H[12].x :=   30+400; H[12].y := 180;
end;

Procedure Trazar;
     var i: Integer;
Begin
  //Dibujar E
  Form1.Canvas.MoveTo(E[1].x, E[1].y);
  for i := 1 to 12 do begin
    Form1.Canvas.LineTo(E[i].x, E[i].y);
  end;
  Form1.Canvas.LineTo(E[1].x, E[1].y);

  //Dibujar Flecha
  Form1.Canvas.MoveTo(F[1].x, F[1].y);
    for i := 1 to 8 do begin
    Form1.Canvas.LineTo(F[i].x, F[i].y);
  end;
    Form1.Canvas.LineTo(F[1].x, F[1].y);

  //Dibujar Tetris
  Form1.Canvas.MoveTo(G[1].x, G[1].y);
    for i := 1 to 9 do begin
    Form1.Canvas.LineTo(G[i].x, G[i].y);
  end;
    Form1.Canvas.LineTo(G[1].x, G[1].y);

    //Dibujar H
  Form1.Canvas.MoveTo(H[1].x, H[1].y);
    for i := 1 to 12 do begin
    Form1.Canvas.LineTo(H[i].x, H[i].y);
  end;
    Form1.Canvas.LineTo(H[1].x, H[1].y);

end;

procedure Colorear(Relleno : INTEGER);
var x, y : INTEGER;
begin
  //x := (F[1].x + F[2].x + F[3].x) DIV 3;
  //y := (F[1].y + F[2].y + F[3].y) DIV 3;
  //Form1.Canvas.Brush.Color := Relleno;
  //Form1.Canvas.FloodFill(x, y, clBLUE, fsBorder);
end;

procedure Dibujar;
Begin
  Form1.Canvas.Pen.Color := clBLUE;
  Trazar;
  Colorear(clYELLOW);
end;

procedure Borrar;
begin
  Colorear(clBtnFace);
  Form1.Canvas.Pen.Color := clBtnFace;
  Trazar;
end;

Procedure Coordenadas;
Begin
end;

Procedure Multiplicar;
  VAR M, P : TMatriz;
      i, j, k: Integer;
Begin
  for i := 1 to 3 do
  begin
    M[i, 1] := F[i].x; M[i, 2] := F[i].y; M[i, 3] := 1;
  end;
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      P[i, j] := 0;
      for k := 1 to 3 do
          P[i, j] := P[i, j] + M[i, k] * T[k, j];
    end;
    for i := 1 to 3 do
    begin
      F[i].x := ROUND(P[i, 1]);
      F[i].y := ROUND(P[i, 2]);
    end;
  Coordenadas;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Iniciar;
  Coordenadas;
  Form1.Canvas.Pen.Color := clBackground;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Dibujar;
end;

end.
         .
