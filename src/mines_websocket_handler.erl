-module(mines_websocket_handler).
-behaviour(cowboy_http_websocket_handler).
-export([init/3]).
-export([websocket_init/3, websocket_handle/3, websocket_info/3, websocket_terminate/3]).


init({tcp, http}, _Req, _Opts) ->
    {upgrade, protocol, cowboy_http_websocket}.

websocket_init(_Transport, Req, _Opts) -> 
    erlang:start_timer(1000, self(), <<"Hello!">>),
    {ok, Req, undefined_state}.
    
websocket_handle({text, Msg}, Req, State) ->
    {reply, {text, << "You said: ", Msg/binary >>}, Req, State, hibernate};
websocket_handle(_, Req, State) ->    
    {ok, Req, State}.
    
websocket_info({timeout, _Ref, Msg} , Req, State) ->
    erlang:start_timer(1000, self(), <<"OK?">>),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.
    
websocket_terminate(_Reason, _Req, _State) ->
    ok.
    
    