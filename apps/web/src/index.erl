-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() -> #dtl{}.

event(chat) ->
  User = wf:user(),
  Message = wf:q(message),
  wf:send({topic, "lobby"}, {client, {User, Message}});

event({client, {User, Message}}) ->
  wf:wire(#jq{target = message, method = [focus, select]}),
  DTL = #dtl{file = "message", app = review,
    bindings = [{user, User}, {message, wf:html_encode(wf:js_escape(Message))}]},
  wf:insert_top(history, DTL);

event(logout) ->
  wf:logout(), wf:redirect("/login");

event(init) ->
  wf:reg({topic, "lobby"}),
  [ event({client, {"user", "message"}}) ];

event(Event) ->
  wf:info(?MODULE, "Event: ~p", [Event]).
