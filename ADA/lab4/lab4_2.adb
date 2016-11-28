
with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;

procedure Lab4_2 is
	
function Newton (N :in Float;Epsilon : in Float) return Float
is
	A,B : Float;
begin
	A := 1.00;
	B := N;
	while (abs (A-B))>Epsilon loop
		A := (A+B)/2.00;
		B := N/A;
	end loop;
	
	return A;
end Newton;

function NewtonN (N : in Float;I: in Integer) return Float
is
	A,B : Float;
begin
	A := 1.00;
	B := N;
	for Iter in 1..I loop
		A := (A+B)/2.00;
		B := N/A;
	end loop;
	return A;
end NewtonN;

function Silnia(N :in Integer) return Integer
is
begin
	if(N>1) then
		return N*Silnia(N-1);
	else
		return 1;
	end if;

end Silnia;

	Liczba :Float;

begin
	Put_Line(Silnia(10)'Img);	
	
	Put_Line("Podaj liczbe");
	Get(Liczba);
	Put(NewtonN(Liczba,100),10,3,0);
	New_Line;

end Lab4_2; 



