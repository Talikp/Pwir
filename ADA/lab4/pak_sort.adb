-- pak_sort.adb

with Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics.Float_Random ;

-- Zadanie:
-- dopisać treści procedur

package body Pak_Sort is

procedure Put_Wektor(W: Wektor; Kom: String := "") is
begin
	Put_Line(Kom);
  for I in W'Range loop
	Put(W(I),4,3,0);
	New_Line;
  end loop;

end Put_Wektor;		

procedure Losuj_Wektor(W: in out Wektor; Max: Float := 100.0) is
	Gen : Generator;
begin
	Reset(Gen);
	for I in W'Range loop
		W(I) := Random(Gen)*Max;
	end loop;
end Losuj_Wektor; 

-- sortowanie bąbelkowe wektora W
procedure Sortuj_BB(W: in out Wektor) is 
	Tmp : Float;
	N : Integer;
	Len : Integer;
begin	  
	Len := W'Length-1;

	for I in W'Range loop
		N := 0;
		for J in 1..Len loop
			if(W(J)>W(J+1)) then
				Tmp := W(J);
				W(J) := W(J+1);
				W(J+1) := Tmp;
				N:=N+1;
			end if;
		end loop;

		if(N=0) then
			return;
		end if;
	end loop;
  	  	
end Sortuj_BB;			

procedure Scalaj2(W1, W2: Wektor; W: in out Wektor) is
-- scala posortowane wektory W1, W2 do W
begin	
  null;
end Scalaj2;		  

end Pak_Sort;
