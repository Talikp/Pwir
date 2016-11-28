-- lostab

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure LosTab is
  Wart,Tmp, Suma : Float := 0.0;
  R   : constant Positive := 20;
  Index : Integer := 0;	
  Tab : array(1..R) of Float := (others => 0.0);
  Gen : Generator; -- z pakietu Ada.Numerics.Float_Random 
begin
  Reset(Gen);
  -- losowanie elementow z zapisem do tablicy
  for I in Tab'Range loop 
    Tab(I) := Random(Gen);

	for Variable in reverse 2 .. I loop
		if Tab(Variable)<Tab(Variable-1) then
			Tmp := Tab(Variable);
			Tab(Variable) := Tab(Variable-1);
			Tab(Variable-1) := Tmp;
		end if;
	end loop;

  end loop;
  -- wypisanie tablicy
  for  I in Tab'Range loop
    Put_Line("Tab(" & I'Img & ")=" & Tab(I)'Img);
  end loop;

end LosTab;    
