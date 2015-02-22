-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> ok.

event({client, Message}) ->
    wf:info(?MODULE, "Broadcast Incoming Message: ~p", [Message]),
    wf:send(room, {server, Message}); % goes to event({server,_})

event({server, Message}) ->
    wf:info(?MODULE, "Broadcasted Message to Channel: ~p", [Message]),
    self() ! {bin,Message}; % goes to event({bin,_})

event({bin, Message}) ->
    wf:info(?MODULE, "Send to TCP: ~p", [Message]),
    {server,Message}; % goes to TCP socket

event(init) ->
   wf:info(?MODULE,"Init: ~p~n",[self()]),
   wf:reg(room); % init broadcast token

event(Event) ->
  wf:info(?MODULE, "EMPTY Event: ~p", [Event]).
