{application, mines, 
    [{description, "WebSocket Mines Game"},
     {vsn, "0.1"},
     {modules, [mines, mines_sup]},
     {applications, [cowboy]},
     {mod, {mines, []}},
     {registered, [mines]}
    ]}.
     
