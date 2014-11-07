% DCG
sentence([s1,both,NP1,NP2]) --> noun_phrase(NP1,_), compound_verb(both), noun_phrase(NP2,_).
sentence([s2,both,NP1]) --> noun_phrase(NP1,_), compound_verb(both).

sentence([s3,Plurality,NP1,NP2]) --> noun_phrase(NP1,Plurality), compound_verb(Plurality), noun_phrase(NP2,_).
sentence([s4,Plurality,NP1]) --> noun_phrase(NP1,Plurality), compound_verb(Plurality).

noun_phrase(np1,Plurality) --> determiner, adjective_sequence, noun(Plurality).
noun_phrase(np2,Plurality) --> determiner, noun(Plurality).
noun_phrase(np3,Plurality) --> noun(Plurality).

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

noun(singular) --> [X],
    {member(X, [cat, mat, man, boy, dog])}.

noun(plural) --> [X],
    {member(X, [cats, mats, men, boys, dogs])}.

% we can enclose regular prolog in braces { }
adjective --> [X], 
    {member(X, [large, small, brown, orange, green, blue])}.
adjective --> [white].

% sentence(SentenceType), noun_phrase, verb, etc are syntactic terms
% everything in a bracket is a terminal

test1:-
    phrase(sentence(SentenceType), [the, cat, saw, the, mat]).

test2:-
    phrase(sentence(SentenceType), [whatever, cat, saw, the, mat]).

test3:-
    S = [the, cat, saw, the, X],
    findall(X, phrase(sentence(SentenceType), S), L),
    writeln(S),
    writeln(L).

test4:-
    phrase(sentence(SentenceType), [the, man, will, see, the, mat]).

test5:-
    phrase(sentence(SentenceType), [the, blue, cat, saw, the, large, man]).

test6:-
    phrase(sentence(SentenceType), [the, large, man, saw, the, small, brown, orange, dog]).

test7:-
    phrase(sentence(SentenceType), [the, small, green, man, sees, a, large, dog]).

test8:- % will fail
    phrase(sentence(SentenceType), [the, small, green, men, sees, a, large, dog]).

test9:-
    phrase(sentence(SentenceType), [the, small, green, men, saw, a, large, dog]).

test10:-
    phrase(sentence(S), [the, small, green, man, saw, the, dog]).
