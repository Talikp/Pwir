-module(sonda_main).

-compile(export_all).

-include("cecho.hrl").

-define(sizeX, 100).
-define(sizeY, 50).

main() ->
    application:start(cecho),
    init(),

    timer:sleep(200),        
    cecho:refresh(),
    End = {30,40},
    Trap = generate_plansza(?sizeY,?sizeX,500,End),
    %[rysuj(Y,X,Trap,End) || {Y,X} <- sonda_ruchy()],
    rysuj(12,40,Trap,End),
    {Y,X} = {22,50},

    Dist = distance(End,{Y,X}),
    loop(Y,X,Trap,End,#{{Y,X}=>{0,Dist,Dist}},[]),

    timer:sleep(20000),        

    application:stop(cecho).

loop(Y,X,Trap,{EY,EX},Open,Close) ->
    TrapRange = traps_in_range(Y,X,Trap,1),
    {OpenNew,CloseNew,Y1,X1} = next_point(Open,Close,TrapRange,{Y,X},{EY,EX}),
    rysuj(Y1,X1,Trap,{EY,EX}),
    {OY,OX} = offset(Y1,X1),
    %draw_map(CloseNew,6,OY,OX),
    %cecho:refresh(),
    %napis(maps:size(OpenNew),length(CloseNew)),
    if  
        ((Y1 == EY) and (X1 == EX)) -> ok;
        true -> loop(Y1,X1,Trap,{EY,EX},OpenNew,CloseNew)
    end.


init() ->
    cecho:cbreak(),
    cecho:noecho(),
    cecho:curs_set(?ceCURS_INVISIBLE),
    cecho:start_color(),
    cecho:init_pair(1, ?ceCOLOR_BLACK, ?ceCOLOR_RED),
    cecho:init_pair(2, ?ceCOLOR_BLACK, ?ceCOLOR_GREEN),
    cecho:init_pair(3, ?ceCOLOR_BLACK, ?ceCOLOR_YELLOW),
    cecho:init_pair(4, ?ceCOLOR_BLACK, ?ceCOLOR_BLUE),
    cecho:init_pair(5, ?ceCOLOR_BLACK, ?ceCOLOR_MAGENTA),
    cecho:init_pair(6, ?ceCOLOR_BLACK, ?ceCOLOR_CYAN),
    cecho:init_pair(7, ?ceCOLOR_BLACK, ?ceCOLOR_WHITE),
    cecho:init_pair(8, ?ceCOLOR_BLACK, ?ceCOLOR_BLACK).


rysuj(Y,X,Trap,End)->
    {MaxY,MaxX} = cecho:getmaxyx(),
    {CY,CX} = offset(Y,X),
    draw_map(map_coord(MaxY,MaxX),8,0,0),
    draw_map(Trap,1,CY,CX),
    cecho:refresh(),
    draw_End(End,CY,CX),
    draw_sonda(Y,X,CY,CX),
    timer:sleep(300). 

napis(Y,X) ->
    cecho:attron(?ceCOLOR_PAIR(4)),
    cecho:move(0,0),
    cecho:addstr(io_lib:format(" ~p ~p",[Y,X])),
    cecho:refresh(),
    timer:sleep(100).

next_point(Open,Close,Trap,Key,End) ->
    Close1 = [Key|Close],
    Open1 = updateAll(Open,Close1,Key,Trap,End),
    OpenNew = maps:remove(Key,Open1),

    {Y,X,_,_,_} = get_min(OpenNew),
    {OpenNew,Close1,Y,X}.


get_min(Open) -> maps:fold(fun accumulator/3 ,{-1,-1,0,0,0},Open).

accumulator({Y,X},{G,H,F},{Y1,X1,G1,H1,F1}) ->
	Check = compare_value({G,H,F},{G1,H1,F1}),
    if
        Y1 == (-1) -> {Y,X,G,H,F};
        Check == true -> {Y,X,G,H,F};
        true -> {Y1,X1,G1,H1,F1}
    end.


compare_value({_,H1,F1},{_,H2,F2}) ->
    if
        H1<H2 -> true;
        (H1 == H2) and (F1<F2) -> true;
        true -> false
    end.

updateAll(Open,Close,{CY,CX},Trap,End) ->
    Value = maps:get({CY,CX},Open),
    List = not_traps({CY,CX},Trap,Close),
    update(Open,{CY,CX},Value,End,List).


update(Open,_,_,_,[]) -> Open;
update(Open,Key,{CG,CH,CF},End,[Head|T]) ->
    G = distance(Key,Head)+CG,
    H = distance(End,Head),
    F = H+G, 
    Check = maps:is_key(Head,Open),
    if 
        Check == true -> Value1 = check_value(Head,{G,H,F},Open), 
        update(maps:update(Head,Value1,Open),Key,{CG,CH,CF},End,T);
        true -> update(maps:put(Head,{G,H,F},Open),Key,{CG,CH,CF},End,T)

    end.

check_value(Key,{G,H,F},Map) ->
    Check = compare_value({G,H,F},maps:get(Key,Map)),
    if 
        Check == true -> {G,H,F};
        true -> maps:get(Key,Map)
    end.



distance({Y1,X1},{Y2,X2}) ->
    Yd = abs(Y1-Y2),
    Xd = abs(X1-X2),
    Diff = abs(Yd-Xd),
    10*mini(Yd,Xd)+14*Diff.

mini(A,B) ->
    if 
        A-B>0 -> A-B;
        true -> B-A
    end.    


traps_in_range(Y,X,Trap,Range) -> 
    List = [{Y1,X1} || Y1 <- lists:seq(Y-Range,Y+Range),
     X1 <- lists:seq(X-Range,X+Range)],

    [ {A,B} || {A,B} <- Trap, {Y2,X2} <-List,
        A == Y2 , B == X2 
    ].

not_traps({CY,CX},Trap,Close) ->
    Range = 1,
    List = [{Y1,X1} || Y1 <- lists:seq(CY-Range,CY+Range),
     X1 <- lists:seq(CX-Range,CX+Range),
     ((Y1 /= CY) or (X1 /=CX))
     ],

    [ {Y2,X2} ||  {Y2,X2} <-List,
        lists:member({Y2,X2},Trap) == false,
        lists:member({Y2,X2},Close) == false
    ].


sonda_ruchy()->
    [ {12,X} || X <- lists:seq(36,46)].

offset(Y,X) ->
    {MaxY,MaxX} = cecho:getmaxyx(),
    Y2 = MaxY div 2,
    X2 = MaxX div 2,
    if 
        (Y < Y2) and (X < X2) -> {0,0};
        (Y < Y2) and (X>=(?sizeX-X2)) -> {0,?sizeX-MaxX};
        (Y>=(?sizeY-Y2)) and (X < X2) -> {?sizeY-MaxY,0};
        (Y>=(?sizeY-Y2)) and (X>=(?sizeX-X2)) -> {?sizeY-MaxY,?sizeX-MaxX};
        (Y < Y2) and (X >= X2) and (X <(?sizeX-X2)) -> {0,X-X2};
        (Y >= Y2) and (Y <(?sizeY-Y2)) and (X < X2) -> {Y-Y2,0};
        (Y >= Y2) and (Y <(?sizeY-Y2)) and (X >=(?sizeX-X2)) -> {Y-Y2,?sizeX-MaxX};
        (Y >=(?sizeY-Y2)) and (X >=X2) and (X <(?sizeX-X2)) -> {?sizeY-MaxY,X-X2};
                                
        true -> {Y-Y2,X-X2}
    end.

draw_sonda(Y,X,OffsetY,OffsetX) ->
    cecho:attron(?ceCOLOR_PAIR(2)),
    cecho:move(Y-OffsetY,X-OffsetX),
    cecho:addch($ ),
    cecho:refresh().
    %timer:sleep(200).

draw_End({Y,X},OffsetY,OffsetX) ->
    cecho:attron(?ceCOLOR_PAIR(3)),
    {MaxY,MaxX} = cecho:getmaxyx(),
    if     ((Y-OffsetY>=0) and (Y-OffsetY<MaxY) and (X-OffsetX>=0) and (X-OffsetX<MaxX)) -> 
                cecho:move(Y-OffsetY,X-OffsetX),
                cecho:addch($ ),
                cecho:refresh();
            true -> ok
    end.


generate_plansza(MaxY,MaxX,N,End) -> 
    {A, B, C} = erlang:timestamp(),
    random:seed(A, B, C),
	generate_plansza(MaxY,MaxX,N,[],End).

generate_plansza(_,_,0,L,End) ->
	lists:delete(End,L);
generate_plansza(MaxY,MaxX,N,L,End) ->
	Y = random:uniform(MaxY)-1,
	X = random:uniform(MaxX)-1,
	generate_plansza(MaxY,MaxX,N-1,[{Y,X}|L],End).


map_coord(MaxY,MaxX)->
	[ {A,B} || 	A <- lists:seq(0,MaxY-1), B <- lists:seq(0,MaxX-1)].



draw_map(List,Color,OffsetY,OffsetX) ->
    {MaxY,MaxX} = cecho:getmaxyx(),
    cecho:attron(?ceCOLOR_PAIR(Color)),
    [draw(Y-OffsetY,X-OffsetX) || {Y,X} <- List,
    Y-OffsetY>=0, Y-OffsetY<MaxY,
    X-OffsetX>=0, X-OffsetX<MaxX ].

draw(Y,X) ->
    cecho:move(Y,X),
    cecho:addch($ ).
