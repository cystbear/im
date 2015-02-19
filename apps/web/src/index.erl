-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> ok.

event(chat) ->
  Message = wf:q(message),
  wf:send(chat, Message);

event({chat, Message}) ->
  wf:info(?MODULE, "Message received: ~p", [Message]);

event(init) ->
  wf:reg(chat);

event(_) ->
  wf:info(?MODULE, "nothing to do: ~p", []).
