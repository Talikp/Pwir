#!/usr/bin/env escript
%%! -noinput -pa ../cecho/ebin +A 50
-include_lib("cecho/include/cecho.hrl").
%main(_) -> cecho_example:helloworld().
%main(_) -> cecho_example:countdown().
%main(_) -> cecho_example:simple().
%main(_) -> cecho_example:colors().
%main(_) -> cecho_example:input().
%main(_) -> cecho_example:cursmove().
main(_) -> sonda_main:main().



