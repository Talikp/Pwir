-module(bubbleSort). 
-compile([export_all]).


bubbleSort(L) ->bubbleSort(L,len(L)).
bubbleSort(L,0) ->L;
bubbleSort(L,N) ->bubbleSort(swap(L),N-1).

len(L) -> len(L,0).
len([_|T],S) -> len(T,S+1);
len([],S) -> S.

swap([H1,H2|T]) ->
	if H1<H2 -> [H1]++swap([H2|T]);
		H1>=H2 -> [H2]++swap([H1|T])
	end;
swap(L) -> L.

