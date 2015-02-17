-module(im_app).
-behaviour(application).
-export([start/2, stop/1]).

%% start(_StartType, _StartArgs) -> im_sup:start_link().
start(_StartType, _StartArgs) -> ok.
stop(_State) -> ok.
