-module(mines_web_handler).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

% New connection initialization
init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.
    
% Handle request
handle(Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200, [], <<"Hello World!">>, Req),
    {ok, Req2, State}.
    

terminate(_Req, _State) ->
    ok.
