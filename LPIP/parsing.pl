% DCG
sentence --> noun_phrase, compound_verb, noun_phrase.
sentence --> noun_phrase, compound_verb.

noun_phrase --> determiner, adjective, noun.
noun_phrase --> determiner, noun.
noun_phrase --> noun.

compound_verb -->  auxiliary_verb, verb.
compound_verb -->  verb.

auxiliary_verb --> [will].

verb --> [eat].
verb --> [saw].
verb --> [see].
verb --> [hears].
verb --> [took].
verb --> [sees].

determiner --> [the].
determiner --> [a].
determiner --> [an].

noun --> [cat].
noun --> [mat].
noun --> [man].
noun --> [boy].
noun --> [dog].

adjective --> [large].
adjective --> [small].
adjective --> [brown].
adjective --> [orange].
adjective --> [green].
adjective --> [blue].

% sentence, noun_phrase, verb, etc are syntactic terms
% everything in a bracket is a terminal

test1:-
    phrase(sentence, [the, cat, saw, the, mat]).

test2:-
    phrase(sentence, [whatever, cat, saw, the, mat]).

test3:-
    S = [the, cat, saw, the, X],
    findall(X, phrase(sentence, S), L),
    writeln(S),
    writeln(L).

test4:-
    phrase(sentence, [the, man, will, see, the, mat]).

test5:-
    phrase(sentence, [the, blue, cat, saw, the, large, man]).
