-module(ext_file_handler).

-export([init/3, handle/2, terminate/3]).
%example of talking to this handler:
%httpc:request(post, {"http://127.0.0.1:3011/", [], "application/octet-stream", "echo"}, [], []).
%curl -i -d '[-6,"test"]' http://localhost:3011
handle(Req, _) ->
    {F, _} = cowboy_req:path(Req),
    PrivDir = list_to_binary(code:priv_dir(ae_http)),
    true = case F of
               <<"/human_language.js">> -> true;
               <<"/title.js">> -> true;
               <<"/bets.js">> -> true;
               <<"/miner.js">> -> true;
               <<"/chalang.js">> -> true;
               <<"/format.js">> -> true;
               <<"/rpc.js">> -> true;
               <<"/channels.js">> -> true;
               <<"/headers.js">> -> true;
               <<"/server.js">> -> true;
               <<"/codecBytes.js">> -> true;
               <<"/height.js">> -> true;
               <<"/sha256.js">> -> true;
               <<"/combine_cancel_assets.js">> -> true;
               <<"/hexbase64.js">> -> true;
               <<"/signing.js">> -> true;
               <<"/create_account.js">> -> true;
               <<"/keys.js">> -> true;
               <<"/sjcl.js">> -> true;
               <<"/crypto.js">> -> true;
               <<"/lookup_account.js">> -> true;
               <<"/create_account_tx.js">> -> true;
               <<"/spend_tx.js">> -> true;
               <<"/elliptic.min.js">> -> true;
               <<"/lookup_block.js">> -> true;
               <<"/spk.js">> -> true;
               <<"/explorer.html">> -> true;
               <<"/lookup_oracle.js">> -> true;
               <<"/total_coins.js">> -> true;
               <<"/favicon.ico">> -> true;
               <<"/market.js">> -> true;
               <<"/unused.js">> -> true;
               <<"/finance_game.js">> -> true;
               <<"/merkle_proofs.js">> -> true;
               <<"/wallet.html">> -> true;
               X -> 
                   io:fwrite("ext file handler block access to: "),
                   io:fwrite(X),
                   io:fwrite("\n"),
                   false
           end,
    File = << PrivDir/binary, <<"/external_web">>/binary, F/binary>>,
    {ok, _Data, _} = cowboy_req:body(Req),
    Headers = [{<<"content-type">>, <<"text/html">>},
    {<<"Access-Control-Allow-Origin">>, <<"*">>}],
    Text = read_file(File),
    {ok, Req2} = cowboy_req:reply(200, Headers, Text, Req),
    {ok, Req2, File}.
read_file(F) ->
    {ok, File } = file:open(F, [read, binary, raw]),
    {ok, O} =file:pread(File, 0, filelib:file_size(F)),
    file:close(File),
    O.
init(_Type, Req, _Opts) -> {ok, Req, []}.
terminate(_Reason, _Req, _State) -> ok.
