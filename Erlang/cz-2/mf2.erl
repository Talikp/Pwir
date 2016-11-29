%  mf2.erl
-module(mf2).
-compile([export_all]).

fp()->
  receive
    {Od,agh} -> Od!{agh,ok}
  end.
  
fm()->
 FPid=spawn(mf2,fp,[]),
 FPid!{self(),agh}.  
 
flen(L)->
io:format("flen: ~p ~n",[length(L)]).
  
fm2()->
 Lw=[1,2,3,4,5],
 spawn(mf2,flen,[Lw]).     	