-module(search).
-compile([export_all]).

func(V) -> throw(V+1).

catcher(V) ->
	try func(V) of
		Val -> {V,Val}
	catch
		throw:X -> {V,X}
	end.


main() -> [ catch func(I) || I <- [1,2,3]].
