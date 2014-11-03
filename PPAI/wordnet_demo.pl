%
:-consult([wordnet_prolog/wn_s, wordnet_prolog/wn_g, wordnet_prolog/wn_sim, wordnet_prolog/wn_hyp, wordnet_prolog/wn_mp, wordnet_prolog/wn_mm]).

similar_words(Word, Sim):-
    s(Syn1, _, Word, _, _, _),
    sim(Syn1, Syn2),
    s(Syn2, _, Sim, _, _, _).


rephrase(Sentence, Word, NewSentence):-
    append(Prefix, [Word | PostFix], Sentence),
    similar_words(Word, SimilarWord),
    append(Prefix, [SimilarWord | PostFix], NewSentence).

% what senses of 2 words are related by WordNet relations, do they belong to same synset?
same_synset(A,B,T1,T2,Sen1,Sen2):-
    s(Syn, _, A, T1, Sen1, _),
    s(Syn, _, B, T2, Sen2, _).

% indirect relation - common hypernym
related_synset(A,B, Word):-
    s(S1, _, A, _, Sen1, _),
    s(S2, _, B, _, Sen2, _),
    hyp(S1, S),
    hyp(S2, S),
    s(S, _, Word, _, _, _).

% relation Syn1 and Syn2 are in relation Rel, in direction from S1 to S2.
r0(Syn1, Syn2, rel(Rel, S1, S2):-
    (
        S1 = Syn1,  % Choose first and second arg of relation between Syn1 and Syn2
        S2 = Syn2
    ;
        S1 = Syn2,
        S2 = Syn1
    ),
    (
        hyp(S1, S2),    % Check hyp relation
        Rel = hyp
    ;
        mm(S1, S2),     % Check mm relation
        Rel = hyp
    ;
        mp(S1, S2),     % Check mp relation
        Rel = mp
    ).
