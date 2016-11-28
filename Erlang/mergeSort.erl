-module(mergeSort).

-export([mergeSort/1]).
-compile({no_auto_import,[length/1]}).

length(L) -> length(L,0).
length([_|T],S) -> length(T,S+1);
length([],S) -> S.

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
 	case length(L) of 1 -> L;
	Otherwise -> {Left,Right} = dziel(L,Otherwise div 2),
		merge(mergeSort(Left),mergeSort(Right))
	end.
