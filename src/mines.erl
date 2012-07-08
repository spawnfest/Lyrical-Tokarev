-module(mines).
-behaviour(application).
-export([start/0, start/2, stop/1]).

start() ->
    application:start(cowboy),
    application:start(compiler),
    application:start(syntax_tools),
    application:start(lager),
    application:start(mnesia),
    application:start(mines).

start(_Type, _Args) ->
    Dispatch = [
      {'_', [
	{[<<"websocket">>], mines_websocket_handler, []},
        {[<<"WebSocket">>], mines_websocket_handler, []},
        {[<<"js">>, '...'], cowboy_http_static, [
    	    {directory, {priv_dir, mines, [<<"static/js">>]}},
    	    {mimetypes, [{<<".js">>, [<<"text/javascript">>]}]}
    	]},
    	{[<<"img">>, '...'], cowboy_http_static, [
    	    {directory, {priv_dir, mines, [<<"static/img">>]}},    	
    	    {mimetypes, [{<<".png">>, [<<"image/png">>]}]}
    	]},
    	{[<<"css">>, '...'], cowboy_http_static, [
    	    {directory, {priv_dir, mines, [<<"static/css">>]}},    	
    	    {mimetypes, [{<<".css">>, [<<"text/css">>]}]}
    	]},
    	{[], cowboy_http_static, [
    	    {directory, {priv_dir, mines, [<<"static">>]}},
    	    {file, <<"index.html">>},
    	    {mimetypes, [{<<".html">>, [<<"text/html">>]}]}
    	]},
        {'_', mines_web_handler, []}
      ]}
    ],
    cowboy:start_listener(my_http_listener, 100,
        cowboy_tcp_transport, [{port, 8080}],
        cowboy_http_protocol, [{dispatch, Dispatch}]
    ),
    mines_sup:start_link().
    
stop(_State) ->
    application:stop(mnesia),
    
    ok.
    