with Ada.Text_IO;
use Ada.Text_IO;

procedure Zad1 is
  type ItemList is array( Integer range <> ) of Character; 
-- obiekt chroniony 
protected Buf is
  entry Wstaw(C : Character);
  entry Pobierz(C : out Character);
  private
    Bc : ItemList (0..20);
	IndexW : Integer := 0;
	IndexP : Integer := 0;
	Max : Boolean := False;
	Empty : Boolean := True;
end Buf;

protected body Buf is
  entry Wstaw(C : Character) when not Max is
  begin
    Bc(IndexW) := C;
	IndexW := IndexW + 1;
	IndexW := IndexW mod Bc'Size;
	
	if(IndexW=IndexP) then
		Max := True;
	end if;	
	
    Empty := False;
  end Wstaw;
  entry Pobierz(C : out Character) when not Empty is
  begin
    C := Bc(IndexP);
	IndexP := IndexP+1;
	IndexP := IndexP mod Bc'Size;
	
	if(IndexP = IndexW) then
		Empty := True;
	end if;
    Max := False;
  end Pobierz;
end Buf;
  
task Producent; 

task body Producent is
  Cl : Character := 's';
begin  
  Put_Line("$ wstawiam: znak = '" & Cl & "'");
  Buf.Wstaw(Cl);
  Put_Line("$ wstawiłem...");
end Producent;

task Konsument; 

task body Konsument is
  Cl : Character := ' ';
begin  
  Put_Line("# pobiorę...");
  Buf.Pobierz(Cl);
  Put_Line("# pobrałem: znak = '" & Cl & "'");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end Zad1;
