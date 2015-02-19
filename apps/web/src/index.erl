-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> ok.

event(chat) ->
  Message = wf:q(message),
  wf:send(message_queue, {client, Message});

event({client, Message}) ->
  wf:info(?MODULE, "Event: ~p", [Message])
%%   ,wf:send(message_queue, {client, Message})
;

event(init) ->
  wf:reg(message_queue);

event(Event) ->
  wf:info(?MODULE, "EMPTY Event: ~p", [Event]).
