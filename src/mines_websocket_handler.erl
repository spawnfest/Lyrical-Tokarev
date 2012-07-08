-module(mines_websocket_handler).
-include_lib("cowboy/include/http.hrl").
-behaviour(cowboy_http_handler).
-behaviour(cowboy_http_websocket_handler).
-export([init/3, handle/2, terminate/2]).
-export([websocket_init/3, websocket_handle/3, websocket_info/3, websocket_terminate/3]).
-export([websocket_broadcast/1]).
-define(WSBroadcast, {websocket, broadcast}).



init({_Any, http}, _Req, []) ->
    {upgrade, protocol, cowboy_http_websocket}.

handle(Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200, [{'Content-Type', <<"text/html">>}],<<"
    <html>
    <head><title>testing</title></head>
    <body>
    i m testing websockets!
    </body>
    </html>">>, Req),{ok, Req2, State}.
    
terminate(_Req, _State) -> ok.

% New websocket connection
websocket_init(_Any, Req, []) -> 
    %lager:debug("New connection: ~p", Req),
    Req2 = cowboy_http_req:compact(Req),
    gproc:reg({p, l, ?WSBroadcast}, ignored),
    {ok, Req2, undefined, hibernate}.

% Handle incoming message
websocket_handle({text, Msg}, Req, State) ->
    {reply, {text, << "You said: ", Msg/binary >>}, Req, State, hibernate};
websocket_handle(_Any, Req, State) ->    
    {ok, Req, State}.

% Handle system message    
websocket_info({click, {X , Y}}, Req, State) ->
    Msg = jsx:encode([{<<"x">>, X},{<<"y">>, Y}]),
    {reply, {text, Msg}, Req, State, hibernate};    
websocket_info(_Info, Req, State) ->
    {ok, Req, State, hibernate}.

websocket_broadcast(Msg) ->
    gproc:send({p, l, ?WSBroadcast}, {self(), Msg}).
    
websocket_terminate(_Reason, _Req, _State) ->
    ok.
    
    