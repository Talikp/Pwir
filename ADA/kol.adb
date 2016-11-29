
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Kol is
	B:Boolean;
	Int : Integer;
	Tab : array(1..5) of Integer :=(5 =>1,others => 0);
	TabK : array(0..10) of Integer;
begin
	Int := 12#10# mod 2#10#;

	Put_Line(Int'Img);

	B := true;
 	for I in boolean loop
 		B := B and I;
		Put_Line(I'Img);
 	end loop;
	Put_Line(B'Img);

	Put_Line(Tab'First'Img);
	Put_Line(Tab'Last'Img);

	for I in reverse Tab'First..Tab'Last loop
		Put_Line(Tab(I)'Img);
	end loop;

	for I in TabK'Range loop
		TabK(I) := I;
		Put_Line(I'Img);
	end loop;

B := (for all E of TabK => E = 0);

	for I in TabK'Range loop
		Put_Line(TabK(I)'Img);
	end loop;	

	Put_Line(B'Img);
end Kol; 
