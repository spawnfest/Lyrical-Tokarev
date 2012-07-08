-module(mines_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).
-define(SUPERVISOR, ?MODULE).

%% API.
start_link() ->
    supervisor:start_link({local, ?SUPERVISOR}, ?MODULE, []).

%% Supervisor.

init([]) ->
    {ok, {{one_for_one, 10, 10}, []}}.