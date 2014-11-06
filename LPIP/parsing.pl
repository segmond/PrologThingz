% DCG
sentence --> noun_phrase(_), compound_verb(both), noun_phrase(_).
sentence --> noun_phrase(_), compound_verb(both).

sentence --> noun_phrase(Plurality), compound_verb(Plurality), noun_phrase(_).
sentence --> noun_phrase(Plurality), compound_verb(Plurality).

noun_phrase(Plurality) --> determiner, adjective_sequence, noun(Plurality).
noun_phrase(Plurality) --> determiner, noun(Plurality).
noun_phrase(Plurality) --> noun(Plurality).

compound_verb(Plurality) -->  auxiliary_verb, verb(Plurality).
compound_verb(Plurality) -->  verb(Plurality).

auxiliary_verb --> [will].

adjective_sequence --> adjective, adjective_sequence.
adjective_sequence --> adjective.

verb(plural) --> [eat].     % disguised form of the prolog clause verb([eat|A], A).
verb(plural) --> [see].

verb(both) --> [saw].
verb(both) --> [took].
verb(both) --> [sat].
verb(both) --> [will_see].

verb(singular) --> [hears].
verb(singular) --> [sees].

determiner --> [the].
determiner --> [a].
determiner --> [an].

noun(singular) --> [cat].
noun(singular) --> [mat].
noun(singular) --> [man].
noun(singular) --> [boy].
noun(singular) --> [dog].

noun(plural) --> [cats].
noun(plural) --> [mats].
noun(plural) --> [men].
noun(plural) --> [boys].
noun(plural) --> [dogs].

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

test6:-
    phrase(sentence, [the, large, man, saw, the, small, brown, orange, dog]).


test7:-
    phrase(sentence, [the, small, green, man, sees, a, large, dog]).

test8:- % will fail
    phrase(sentence, [the, small, green, men, sees, a, large, dog]).

test9:-
    phrase(sentence, [the, small, green, men, saw, a, large, dog]).

