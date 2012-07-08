{application, mines, 
    [{description, "WebSocket Mines Game"},
     {vsn, "0.1"},
     {modules, [
        mines, mines_sup, mines_web_handler, mines_websocket_handler
     ]},
     {applications, [cowboy, compiler, syntax_tools, lager]},
     {mod, {mines, []}},
     {registered, [mines]}
    ]}.
     
