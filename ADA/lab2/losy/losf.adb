-- losf

with Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics.Float_Random;

procedure Losf is
  Wart, Suma : Float := 0.0; 
  Gen: Generator; -- z pakietu Ada.Numerics.Float_Random 
begin
  Reset(Gen);
  for I in 1..10 loop
    Wart := Random(Gen);
    Suma := Suma + Wart;
    Put("Wylosowalem:");
    Put( Wart, 6, 4, 0); -- z pakietu Ada.Float_Text_IO
    New_Line;
  end loop;
  Put_Line("Suma = " & Wart'Img);
end Losf;    