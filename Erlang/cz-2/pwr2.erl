%  pwr2.erl
-module(pwr2).
-compile([export_all]).
% 

f1() -> 
   io:format("Jestem we funkcji f1 ~n"),
   {ok,f1}.

f2() ->
  io:format("Jestem we funkcji f2 ~n"),
  io:format("f2: czekam na ... P2!{self(),agh} ~n"),
  receive
    {_,agh} -> % {Od,agh}
      io:format("f2: {agh,ok} ~n"),
      {ok,f2}    
  end.

f3()->
  io:format("Jestem we funkcji f3 ~n"),
  io:format("f3: czekam na ... P3!{self(),agh} ~n"),
  receive
    {Od,agh} ->
      %io:format("f3: {agh,ok} ~n"), 
      Od!{agh,ok}
  end.
  
f4()->
  io:format("Jestem we funkcji f4 ~n"),
  io:format("f4: czekam na ... P4!{self(),agh} ~n"),
  receive
    {Od,agh} -> Od!{agh,ok}
    after 1000->  timeout_ps	
  end.  
  
f5loop() ->
  io:format("Jestem we funkcji f5 ~n"),
  io:format("f5: czekam na ... P5!{self(),agh} ~n"),
  receive
    {_,agh} -> % {Od,agh}
      io:format("f5: loop ~n"),
      f5loop();
    {_,koniec} -> % {Od,koniec}
      io:format("f5: koniec ~n"),
      {koniec,f5loop}
  end.  
  
fmain()->
 spawn(?MODULE,f1,[]), % FPid1=spawn(?MODULE,f1,[]),
 
 FPid2=spawn(pwr2,f2,[]),
 FPid2!{self(),agh},
 
 FPid3=spawn(pwr2,f3,[]),
 FPid3!{self(),agh},	
 _=receive % Res=receive
   {agh,ok} ->ok
 end,
 
 FPid5=spawn(pwr2,f5loop,[]),
 FPid5!{self(),agh},	
 FPid5!{self(),koniec},
 
 {fmain,koniec}.
 
 