%  sort1.erl
-module(sort1).
-compile([export_all]).

get_mstimestamp() ->
  {Mega, Sec, Micro} = os:timestamp(),
  (Mega*1000000 + Sec)*1000 + round(Micro/1000).

sorts(L) -> 
  % dopisz sortowanie sekwencyjne liste L
  timer:sleep(200),
  L.

sortw(L) -> 
  % dopisz sortowanie współbieżne liste L
  timer:sleep(200),
  L.  

gensort() ->
 L=[rand:uniform(5000)+100 || _ <- lists:seq(1, 25339)],	
 Lw=L,
 io:format("Liczba elementów = ~p ~n",[length(L)]),
 
 io:format("Sortuję sekwencyjnie~n"),	
 TS1=get_mstimestamp(),
 sorts(L),
 DS=get_mstimestamp()-TS1,	
 io:format("Czas sortowania ~p [ms]~n",[DS]),
 io:format("Sortuję współbieżnie~n"),	
 TS2=get_mstimestamp(),
 sortw(Lw),
 DS2=get_mstimestamp()-TS2,	
 io:format("Czas sortowania ~p [ms]~n",[DS2]).
 
 