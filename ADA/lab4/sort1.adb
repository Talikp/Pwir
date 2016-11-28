-- sort1.adb
with Pak_Sort, Ada.Text_IO, Ada.Calendar;
use Pak_Sort, Ada.Text_IO, Ada.Calendar;

procedure Sort1 is
--procedura główna przykład 1		

Rozmiar: constant Integer := 20;
W1: Wektor(1..Rozmiar) := (others => 0.0);

T1: Time;
D: Duration;
	
begin 
 Losuj_Wektor(W1);
 Put_Wektor(W1, "Przed sortowaniem");	
 T1 := Clock; 
 Sortuj_BB(W1);
 D := Clock-T1;
 Put_Wektor(W1,"Posortowane");
 Put_Line("Czas obliczen: " & D'Img & "[s]");
end Sort1;  
  