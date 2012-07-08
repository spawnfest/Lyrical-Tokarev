-module(mines).
-behaviour(application).
-export([start/0, start/2, stop/1]).

start() ->
    application:start(cowboy),
    application:start(mines).

start(_Type, _Args) ->
    Dispatch = [
      {'_', [
      {[<<"websocket">>], mines_websocket_handler, []},
      {[<<"WebSocket">>], mines_websocket_handler, []} %,
      %{'_', mines_web_handler, []}
      ]}
    ],
    cowboy:start_listener(my_http_listener, 100,
        cowboy_tcp_transport, [{port, 8080}],
        cowboy_http_protocol, [{dispatch, Dispatch}]
    ),
    mines_sup:start_link().
    
stop(_State) ->
    ok.
    