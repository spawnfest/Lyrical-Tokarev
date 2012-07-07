{application, mines, 
    [{description, "WebSocket Mines Game"},
     {vsn, "0.1"},
     {modules, [mines, mines_sup, mines_web_handler]},
     {applications, [cowboy]},
     {mod, {mines, []}},
     {registered, [mines]}
    ]}.
     
