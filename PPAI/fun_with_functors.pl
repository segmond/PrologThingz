% constructing and decomposing terms
% naive
nenlarge(square(A), F, square(A1)):-
    A1 is F * A.
nenlarge(circle(R), F, circle(R1)):-
    R1 is F * R.
nenlarge(rectangle(A,B), F, rectangle(A1,B1)):-
    A1 is F * A,
    B1 is F * B.


% better
enlarge(Fig, F, Fig1):-
    Fig =.. [Type | Parameters],
    multiplylist(Parameters, F, Parameters1),
    Fig1 =.. [Type | Parameters1].

multiplylist([], _, []).

multiplylist([X|T], F, [X1|NewT]):-
    X1 is F * X,
    multiplylist(T, F, NewT).

