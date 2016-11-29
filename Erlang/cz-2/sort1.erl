%  sort1.erl
-module(sort1).
-compile([export_all]).

get_mstimestamp() ->
  {Mega, Sec, Micro} = os:timestamp(),
  (Mega*1000000 + Sec)*1000 + round(Micro/1000).

sorts(L) -> 
  % dopisz sortowanie sekwencyjne liste L

  timer:sleep(200),
  mergeSort(L).

sortw(L) -> 
  % dopisz sortowanie współbieżne liste L
	case len(L) of 1 -> L;
	Otherwise -> {Left,Right} = dziel(L,Otherwise div 2),
		FPid1=spawn(sort1,spawnSort,[Left]),
	 	FPid1!{self(),sort},
		FPid2=spawn(sort1,spawnSort,[Right]),
	 	FPid2!{self(),sort},
		
		receive
				{sort,A} ->	receive
					{sort,B} -> Result = merge(A,B)
					end
		end,
		
		Result
	end. 

spawnSort(L) ->
	receive
    	{Od,sort} -> Od!{sort,mergeSort(L)}
  	end.

gensort() ->
 L=[rand:uniform(5000)+100 || _ <- lists:seq(1, 25339)],	
 Lw=L,
 io:format("Liczba elementów = ~p ~n",[len(L)]),
 
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
 
len(L) -> len(L,0).
len([_|T],S) -> len(T,S+1);
len([],S) -> S.

dziel(T,0) -> {[],T};
dziel([H|T],N) -> {L,R} = dziel(T,N-1),
	{[H]++L,R}.


merge(L,R) -> merge(L,R,[]).
merge([H1|T1],[H2|T2],W) ->
		if H1<H2 -> merge(T1,[H2|T2],W++[H1]);
			H1>=H2 -> merge([H1|T1],T2,W++[H2])
		end;
merge([],T,W) -> W++T;
merge(T,[],W) -> W++T.

mergeSort(L) ->
 	case len(L) of 1 -> L;
	Otherwise -> {Left,Right} = dziel(L,Otherwise div 2),
		merge(mergeSort(Left),mergeSort(Right))
	end.
