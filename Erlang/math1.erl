-module(math1). 
-compile([export_all]).
%-export([factorial/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

area({square, Side}) -> Side * Side;
area({rectangle, X, Y}) -> X * Y;
area({circle, Radius}) -> 3.14159 * Radius * Radius;
area({triangle, A, B, C}) ->
	S = (A + B + C)/2, math:sqrt(S*(S-A)*(S-B)*(S-C)).