%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(prism).

-compile(export_all).

do_decode(<<"query">>, <<"ns:prism:data">>, El, Opts) ->
    decode_prism_data(<<"ns:prism:data">>, Opts, El);
do_decode(<<"query">>, <<"ns:prism">>, El, Opts) ->
    decode_prism(<<"ns:prism">>, Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"query">>, <<"ns:prism:data">>},
     {<<"query">>, <<"ns:prism">>}].

do_encode({prism, _, _} = Query, TopXMLNS) ->
    encode_prism(Query, TopXMLNS);
do_encode({prism_data, _} = Query, TopXMLNS) ->
    encode_prism_data(Query, TopXMLNS).

do_get_name({prism, _, _}) -> <<"query">>;
do_get_name({prism_data, _}) -> <<"query">>.

do_get_ns({prism, _, _}) -> <<"ns:prism">>;
do_get_ns({prism_data, _}) -> <<"ns:prism:data">>.

get_els({prism, _prismrep, _sub_els}) -> _sub_els;
get_els({prism_data, _sub_els}) -> _sub_els.

set_els({prism, _prismrep, _}, _sub_els) ->
    {prism, _prismrep, _sub_els};
set_els({prism_data, _}, _sub_els) ->
    {prism_data, _sub_els}.

pp(prism, 2) -> [prismrep, sub_els];
pp(prism_data, 1) -> [sub_els];
pp(_, _) -> no.

records() -> [{prism, 2}, {prism_data, 1}].

decode_prism_data(__TopXMLNS, __Opts,
                  {xmlel, <<"query">>, _attrs, _els}) ->
    __Els = decode_prism_data_els(__TopXMLNS,
                                  __Opts,
                                  _els,
                                  []),
    {prism_data, __Els}.

decode_prism_data_els(__TopXMLNS, __Opts, [], __Els) ->
    lists:reverse(__Els);
decode_prism_data_els(__TopXMLNS, __Opts,
                      [{xmlel, _name, _attrs, _} = _el | _els], __Els) ->
    decode_prism_data_els(__TopXMLNS,
                          __Opts,
                          _els,
                          [_el | __Els]);
decode_prism_data_els(__TopXMLNS, __Opts, [_ | _els],
                      __Els) ->
    decode_prism_data_els(__TopXMLNS, __Opts, _els, __Els).

encode_prism_data({prism_data, __Els}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"ns:prism:data">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els],
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                        __TopXMLNS),
    {xmlel, <<"query">>, _attrs, _els}.

decode_prism(__TopXMLNS, __Opts,
             {xmlel, <<"query">>, _attrs, _els}) ->
    {Prismrep, __Els} = decode_prism_els(__TopXMLNS,
                                         __Opts,
                                         _els,
                                         <<>>,
                                         []),
    {prism, Prismrep, __Els}.

decode_prism_els(__TopXMLNS, __Opts, [], Prismrep,
                 __Els) ->
    {decode_prism_cdata(__TopXMLNS, Prismrep),
     lists:reverse(__Els)};
decode_prism_els(__TopXMLNS, __Opts,
                 [{xmlcdata, _data} | _els], Prismrep, __Els) ->
    decode_prism_els(__TopXMLNS,
                     __Opts,
                     _els,
                     <<Prismrep/binary, _data/binary>>,
                     __Els);
decode_prism_els(__TopXMLNS, __Opts,
                 [{xmlel, _name, _attrs, _} = _el | _els], Prismrep,
                 __Els) ->
    decode_prism_els(__TopXMLNS,
                     __Opts,
                     _els,
                     Prismrep,
                     [_el | __Els]).

encode_prism({prism, Prismrep, __Els}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"ns:prism">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els]
               ++ encode_prism_cdata(Prismrep, []),
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                        __TopXMLNS),
    {xmlel, <<"query">>, _attrs, _els}.

decode_prism_cdata(__TopXMLNS, <<>>) -> <<>>;
decode_prism_cdata(__TopXMLNS, _val) -> _val.

encode_prism_cdata(<<>>, _acc) -> _acc;
encode_prism_cdata(_val, _acc) ->
    [{xmlcdata, _val} | _acc].
