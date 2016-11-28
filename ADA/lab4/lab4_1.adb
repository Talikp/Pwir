
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4_1 is
	
procedure Parz (N :in Integer)
is
	Licz : Integer:= 0;
begin
	for I in 1 .. N loop
		Licz:=Licz+2;
		Put(Licz);
		New_Line;
end loop;
end Parz;

procedure NieParz (N :in Integer)
is
	Licz : Integer:= -1;
begin
	for I in 1 .. N loop
		Licz:=Licz+2;
		Put(Licz);
		New_Line;
end loop;
end NieParz;


begin
	Parz(3);	
	NieParz(3);
end Lab4_1; 
