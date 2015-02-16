-module(im_sup).
-author('Oleg Zinchenko').
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

mime() -> [{mimetypes,cow_mimetypes,all}].

rules() -> cowboy_router:compile(
    [{'_', [
      {"/", cowboy_static, {priv_file, im, "static/index.html", mime()}},
      {"/[...]", n2o_dynalo, {dir, "apps/im/priv/static", mime()}}
    ]}]).

init([]) ->
  io:format(wf:config(n2o, port, 31337)),
  {ok, _} = cowboy:start_http(http, 3, [{port, wf:config(n2o, port, 31337)}], [{env, [{dispatch, rules()}]}]),
  {ok, {{one_for_one, 5, 10}, []}}.
