% definite clause grammars, ugh, get the need and use of it, don't get it yet.

% lists that only contain the atom a
as --> [].
as --> [a], as.
%phrase(as, L).

% a b in any order
ab --> [].
ab --> [a], aba.
aba --> [].
aba --> [b], ab.

% a and b in any other
oaba --> [].
oaba --> a, oaba.
oaba --> b, oaba.
a --> [a].
b --> [b].

% any number of a's followed by any number of b's
bba --> [].
bbb --> [].
bba --> [a], bba.
bba --> [b], bbb.
bbb --> [b], bbb.


% repeat ab
abab --> [].
abab --> a, abab, b.


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
