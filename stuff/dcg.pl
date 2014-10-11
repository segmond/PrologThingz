% lists that only contain the atom a
as --> [].
as --> [a], as.
%phrase(as, L).

ab --> [].
ab --> [a], aba.
aba --> [].
aba --> [b], ab.



cliche -->
    thing,
    " is a ",
    type_of_thing,
    " trapped in a ",
    opposite_type_of_thing,
    " body.".

thing --> "Cygwin".
type_of_thing --> "Unix OS".
opposite_type_of_thing --> "Windows".
% phrase(cliche, X), format('~s~n', [X]).

cliche2(Phrase) -->
    thing2,
    " is a ",
    type_of_thing2,
    " trapped in a ",
    opposite_type_of_thing2,
    " body.".

thing2 --> "Fluffy"; "Bob".
type_of_thing2 --> "dog"; "swimmer"; "fish".
opposite_type_of_thing2 --> "cat's"; "human".
% phrase(cliche, X), format('~s~n', [X]).

foo --> bar.
bar(X,Y):-
    X = 5,
    writeln("Bar indeed.").


% fizz/buzz
fizz_buzz(Msg) --> anything, fizz(Msg), anything, buzz, anything.
anything --> [].
anything --> [_], anything.
fizz(Msg) -->
    "fizz",
    {   
        format('At fizz we have Msg=~w~n', [Msg])
    }.
buzz -->
    "buzz".
