-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> ok.

event({client, Message}) ->
  wf:info(?MODULE, "Message: ~p", [Message]),
  wf:send(message_queue, {broadcast, Message});

event({broadcast, Message}) -> put_data_inside_bert_message;

event(init) -> wf:reg(message_queue);

event(Event) ->
  wf:info(?MODULE, "EMPTY Event: ~p", [Event]).
