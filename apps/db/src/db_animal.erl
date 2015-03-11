-module(db_animal).
-include_lib("kvs/include/metainfo.hrl").
-include("animal.hrl").
-compile(export_all).

metainfo() ->
    #schema{name=kvs,tables=[
        #table{name=animal,fields=record_info(fields,animal)}
        ]}.
