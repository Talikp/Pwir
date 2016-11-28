-- semafr liczbowy 

with Ada.Text_IO;
use Ada.Text_IO;

procedure Zad2a is
  
-- typ chroniony 
protected type Semafor_Licz(Init_Sem: Integer := 16) is
  entry Wejdz;
  procedure Wyjscie;
  private
   S : Integer := Init_Sem;
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
end Semafor_Licz;
  
Semafor1: Semafor_Licz(0);  
  
task Producent; 

task body Producent is
begin  
  Put_Line("$ produkuję ... " );
  delay 0.7;
  Put_Line("$ wysyłam sygnał...");
  Semafor1.Wyjscie;
  Put_Line("$ kończę produkcję..."); 
end Producent;

task Konsument; 

task body Konsument is
begin  
  Put_Line("# czekam na sygnał...");
  Semafor1.Wejdz;
  Put_Line("# dostałem sygnał ...");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end Zad2a;
  
