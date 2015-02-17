-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() ->
    case wf:user() of
         undefined -> wf:redirect("/login"),#dtl{};
         _ -> #dtl{file = "index", app=review,bindings=[{body,body()},{list,content()}]}
    end.

room() ->
  case wf:qp(<<"room">>) of
    <<>> -> "lobby";
    E -> wf:to_list(E)
  end.

content() ->
  case wf:qp(<<"code">>) of
    undefined -> list();
    Code -> code()
  end.

code() ->
  case wf:qp(<<"code">>) of
    undefined  -> "NO CODE";
    E -> {ok,Bin} = file:read_file(E), wf:to_list(Bin)
  end.

list() ->
    Room = room(),
    #ul{body=[
      #li{
        body=#link{
          body=filename:basename(File),
          postback={show,filename:basename(File),File}
        }
      }
     || File <- filelib:wildcard(code:priv_dir(review)++"/snippets/"++Room++"/*")
    ]}.

body() ->
  wf:update(heading,#b{body="Review: " ++ room()}),
  wf:update(logoutButton, #button{id=logout, body="Logout " ++ wf:user(), postback=logout}),
  [ #button { id=send, body= <<"Chat">>, postback=chat, source=[message] } ].

event({show,Short,File}) ->
  1/0,
  io:format("event({show,Short,File})~n"),
  wf:redirect("/index?room="++Short++"&code="++File);

event(chat) ->
  1/0,
  io:format("event(chat)~n"),
  User = wf:user(),
  Message = wf:q(message),
  Room = room(),
  wf:send({topic,Room},{client,{User,Message}});

event({client,{User,Message}}) ->
  1/0,
  io:format("event({client,{User,Message}})~n"),
  wf:wire(#jq{target=message,method=[focus,select]}),
  DTL = #dtl{file="message",app=review,
    bindings=[{user,User},{message,wf:html_encode(wf:js_escape(Message))}]},
  wf:insert_top(history, DTL);

event(init) ->
  1/0,
  io:format("event({client,{User,Message}})~n"),
  Room = room(),
  wf:reg({topic,Room}),
  [ event( {client, {"user", "user message"}} ) ];

event(logout) ->
  1/0,
  io:format("event(logout)~n"),
  wf:logout(),
  wf:redirect("/login");

event(Event) ->
  1/0,
  io:format("event(Event)~n"),
  wf:info(?MODULE,"Event: ~p", [Event]);

event(_) ->
  1/0,
  io:format("______________event(Event)~n").
