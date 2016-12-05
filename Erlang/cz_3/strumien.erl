-module(strumien).
-compile([export_all]).

		%[catcher(I) || I <- [banan,ziemniak,kartofel,c2h5oh,as2o3]].


func_we([]) ->	
	receive	
		{Od,start} -> Od!{null}
	end;

func_we([H|T]) ->
	receive
		{Od,start} ->Od!{self(),started}
	end,

	receive
		{Od1,send} -> Od1!{send,H},
			func_we1(T)
	end.
		

func_we1([]) ->
	receive
		{Od,send} -> Od!{koniec,ok},
				func_we1([])
	after 
		1000-> io:fwrite("koniec strumienia danych ~n",[])
	end;

func_we1([H|T]) ->
	receive
		{Od,send} -> Od!{send,H},
			func_we1(T)
	end.

func_wy(PID) -> 
	receive 
		{null} -> ok;
		{start} -> spawn(strumien,func,[PID]),
				spawn(strumien,func,[PID])
	end.


func(PID) ->
	PID!{self(),send},
	receive
		{send,V} ->io:fwrite("~p : ~p ~n",[self(),V]),
				func(PID);
		{koniec,ok} ->io:fwrite("~p : koniec ~n",[self()])
	end.
					

main()->
	PIDIN = spawn(strumien,func_we,[[1,2,3]]),
	PIDOUT = spawn(strumien,func_wy,[PIDIN]),

	PIDIN!{self(),start},

	receive
		{null} -> PIDOUT!{null};
		{PIDIN,started} -> PIDOUT!{start}
	end,
	io:format("koniec main ~n").
	
