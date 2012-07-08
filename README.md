Collaborative pixelboard 
-----


This project is our small experiment on learning Erlang during [Spawnfest 2012](http://spawnfest.com) contest.

At first we wished to write massive multiplayer online... minesweeper (MMOs are trendy nowadays). But we managed only to make a multi-user pixelboard. 
You can play with it at (http://pixels.nofate.name)[http://pixels.nofate.name] (we'll need some time to deploy it, please be patient). Or just grab it here, compile with rebar and run `./launch.sh`.

Things we learned in these 2 days:

* Erlang syntax.
* OTP fundamentals (applications, supervisers).
* Rebar.
* Cowboy webserver (static content and websockets).
* gproc.
* jsx.

Hmm.. not bad for a couple of days.

TODO:

* Transfer current board state to new users.
* Learn more erlang. Much more.

Thanks to Spawnfest crew for the contest, MononcQc for his [awesome book](http://learnyousomeerlang.com/) and people on freenode for a joyful weekend.   
