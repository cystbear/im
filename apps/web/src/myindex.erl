-module(myindex).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> #dtl{}.

event(chat) ->
  User = wf:user(),
  Message = wf:q(message),
  Room = room(),
  wf:send({topic,Room},{client,{User,Message}});

event({client,{User,Message}}) ->
  wf:wire(#jq{target=message,method=[focus,select]}),
  DTL = #dtl{file="message",app=review,
    bindings=[{user,User},{message,wf:html_encode(wf:js_escape(Message))}]},
  wf:insert_top(history, DTL);

event(init) ->
%%   Room = room(),
%%   wf:reg({topic,Room}),
  [ event( {client, {"user", "user message"}} ) ];

event(logout) ->
  wf:logout(),
  wf:redirect("/login");

event(Event) ->
  wf:info(?MODULE,"Event: ~p", [Event]).

