% komentarz
% pwr1.erl

-module(pwr1).
-compile([export_all]).
%-export([add/2, head/1, sum/1] ).
%-import(lists,[len/1]).

%funkcje

add(A1,A2) -> A1+A2.

head([H|_]) -> {glowa,H}.
	
sum([]) -> 0;
sum([H|T]) -> H + sum(T).
	
tsum(L) -> tsum(L, 0). %tsum/1
tsum([H|T], S) -> tsum(T, S+H); %tsum/2	
tsum([],S) -> S.

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tlen(L) -> tlen(L,0).
tlen([_|T],C) -> tlen(T,C+1);
tlen([],C) -> C.

rev(L) ->  rev(L, []).
rev([H|T], L) -> rev(T, [H|L]);
rev([], L) ->   L.

listN(1) -> [1];
listN(N) -> [N | listN(N-1)]. % lub -> [N] ++	listN(N-1).

minx(L) -> minx(L,hd(L)).

minx([H|T],Mi) when H<Mi -> minx(T,H);
minx([H|T],Mi) when H>=Mi -> minx(T,Mi);
minx([],Mi) -> {minimum,Mi}.

maxx(L) -> maxx(L, hd(L)).
maxx([H|T],Mx) when H>Mx -> maxx(T,H);
maxx([H|T],Mx) when H=<Mx -> maxx(T,Mx);
maxx([],Mx) -> {max,Mx}.

minmax(L) -> {minx(L),maxx(L)}.

countx(X,L) -> countx(X,L,0).
countx(X,[X|T],C) -> countx(X,T,C+1);
countx(X,[_|T],C) -> countx(X,T,C);
countx(X,[],C) -> {X, wystapilo, C, razy }.
