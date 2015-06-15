unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, Arrow, ColorBox, Grids, Variants;

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
  E, F, G, H : TFigura;      //Flecha, Tetris, E, H
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
     Form1.Canvas.Brush.Color := Relleno;
     //E
     x := (E[1].x + E[2].x + E[3].x + E[4].x + E[5].x + E[6].x + E[7].x + E[8].x + E[9].x + E[10].x + E[11].x + E[12].x) DIV 12;
     y := (E[1].y + E[2].y + E[3].y + E[4].y + E[5].y + E[6].y + E[7].y + E[8].y + E[9].y + E[10].y + E[11].y + E[12].y) DIV 12;
     Form1.Canvas.FloodFill(x, y, clBlack, fsBorder);
     //F
     x := (F[1].x + F[2].x + F[3].x + F[4].x + F[5].x + F[6].x + F[7].x + F[8].x) DIV 8;
     y := (F[1].y + F[2].y + F[3].y + F[4].y + F[5].y + F[6].y + F[7].y + F[8].y) DIV 8;
     Form1.Canvas.FloodFill(x, y, clBlack, fsBorder);
     //G
     x := (G[1].x + G[2].x + G[3].x + G[4].x + G[5].x + G[6].x + G[7].x + G[8].x + G[9].x) DIV 9;
     y := (G[1].y + G[2].y + G[3].y + G[4].y + G[5].y + G[6].y + G[7].y + G[8].y + G[9].y) DIV 9;
     Form1.Canvas.FloodFill(x, y, clBlack, fsBorder);
     //H
     x := (H[1].x + H[2].x + H[3].x + H[4].x + H[5].x + H[6].x + H[7].x + H[8].x + H[9].x + H[10].x + H[11].x + H[12].x) DIV 12;
     y := (H[1].y + H[2].y + H[3].y + H[4].y + H[5].y + H[6].y + H[7].y + H[8].y + H[9].y + H[10].y + H[11].y + H[12].y) DIV 12;
     Form1.Canvas.FloodFill(x, y, clBlack, fsBorder);

end;

procedure Dibujar;
Begin
  Form1.Canvas.Pen.Color := clBlack;
  Form1.Canvas.Pen.Width:= 2;
  Trazar;
  Colorear(clYellow);
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

end.        .
