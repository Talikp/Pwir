with Ada.Text_IO;
use Ada.Text_IO;

procedure Zad2B is
  
-- typ chroniony 
protected type Semafor_Licz(Init_Sem: Integer := 16) is
  entry Wejdz;
	entry Lightning;
  procedure Wyjscie;
  private
	Max : Integer := Init_Sem;
	S : Integer := 0;
	Light : Boolean := True;
end Semafor_Licz;

protected body Semafor_Licz  is
  entry Wejdz when S>0 is
  begin
    S := S-1;
  end Wejdz;
  procedure Wyjscie  is
  begin
    S := S+1;
  end Wyjscie;

	entry Lightning when S = Max is
	begin
		Light := False;
	end Lightning;

end Semafor_Licz;
  
Semafor1: Semafor_Licz(4);  
  
task Ludzie;

task body Ludzie is
begin
	for I in 1..4 loop
		Put_Line(I'Img);
		Semafor1.Wyjscie;
	end loop;
	

end Ludzie;

task Wylacznik;

task body Wylacznik is
begin
	Put_Line("Wylacznik");
	Semafor1.Lightning;
	Put_Line("Swiatlo wylaczone");

end Wylacznik;

begin
  Put_Line("@ jestem w procedurze glownej");
end Zad2b;
  
