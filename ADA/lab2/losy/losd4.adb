-- losd4

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Losd4 is
  subtype My_Range is Integer range 1 .. 10;
  package Los_Liczby is new Ada.Numerics.Discrete_Random(My_Range);
  use Los_Liczby;
  
  Wart : My_Range := 1;
  Gen: Generator; -- z pakietu Los_Znak 
begin
  Reset(Gen);
  for I in 1..20 loop
    Wart := Random(Gen);
    Put_Line("Wylosowalem: >" & Wart'Img & "<");
  end loop;
end Losd4; 
