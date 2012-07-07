-module(mines_websocket_handler).
-behaviour(cowboy_http_handler).
-behaviour(cowboy_http_websocket_handler).
-export([init/3, handle/2, terminate/2]).
-export([websocket_init/3, websocket_handle/3, websocket_info/3, websocket_terminate/3]).


init({tcp, http}, Req, []) ->
    case cowboy_http_req:header('Upgrade', Req) of
	{<<"websocket">>, _} -> {upgrade, protocol, cowboy_http_websocket};
	{<<"WebSocket">>, _} -> {upgrade, protocol, cowboy_http_websocket};
	{undefined, Req2} -> {ok, Req2, undefined}
    end.
    
handle(Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200, [], undefined, Req),
    {ok, Req2, State}.
    
terminate(_, _) ->
    ok.
    
websocket_init(_, Req, []) ->
    timer:send_interval(1000, tick),
    Req2 = cowboy_http_req:compact(Req),
    {ok, Req2, undefined, hibernate}.
    
websocket_handle({text, Msg}, Req, State) ->
    {reply, {text, << "You said: ", Msg/binary >>}, Req, State, hibernate};
websocket_handle(_, Req, State) ->    
    {ok, Req, State}.
    
websocket_info(tick, Req, State) ->
    {reply, {text, <<"Tick">>}, Req, State, hibernate};
websocket_info(_, Req, State) ->
    {ok, Req, State, hibernate}.
    
websocket_terminate(_, _, _) ->
    ok.
    
    