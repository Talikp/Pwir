
with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Generic_Elementary_Functions;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

procedure Lab4_3 is
	package Elem is new Ada.Numerics.Generic_Elementary_Functions(Float);
	use Elem;	

function Pierwsza (N :in Integer) return Boolean
is
	A : Integer;
	To : Integer;
begin
	To := Integer(Sqrt(Float(N)));

	A := N;
	for Var in 2..To loop
		if (A mod Var) = 0 then
			return False;
		end if;
		
	end loop;

	
	return True;
end Pierwsza;

	Liczba :Integer;

begin	
	
	Put_Line("Podaj liczbe");
	Get(Liczba);
	Put(Pierwsza(Liczba)'Img);
	New_Line;

end Lab4_3; 



