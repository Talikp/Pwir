-- podstawa.adb

with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Podstawa is
  Liczba : Integer := 0;
begin
  Put("Wpisz liczbe calkowita o podstawie 10: ");
  Get(Liczba);
  Put("Liczba (podstawa 10)= " );
  Put(Liczba, 6, 10);
  New_Line;
  
  Put("Liczba (podstawa  2)= " );
  Put(Liczba, Width => 8, Base  => 2);
  New_Line;
  
  Put("Liczba (podstawa 12)= " );
  Put(Item => Liczba, Width => 8, Base  => 12);
  New_Line;
  
  Put("Liczba (podstawa 16)= " );
  Put(Item => Liczba, Width => 4, Base  => 16);  
  New_Line;
  
end Podstawa;    