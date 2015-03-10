-include_lib("kvs/include/kvs.hrl").

-record(animal, {?ITERATOR(feed),
    timestamp :: erlang:now(),
    kind,
    nickname}).
