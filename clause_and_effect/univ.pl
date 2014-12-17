% http://pjvgastel-programming.blogspot.com/2013/12/rewriting-univ-operator-in-prolog.html
univ(Term, [F|Args]) :-
    countArgs(Args, N),
    functor(Term, F, N),
    fillInArgs(Term, Args),
    !. % cut to prevent infinite loops (there should be only one solution anyway)
 
countArgs(Args, No) :-
    countArgs(Args, No, 0).
 
countArgs([], No, No).

countArgs([_|T], No, X0) :-
    X1 is X0 + 1,
    countArgs(T, No, X1).
 
fillInArgs(Term, Args) :-
    fillInArgs(Term, Args, 1).
 
fillInArgs(_, [], _).

fillInArgs(Term, [H|T], N0) :-
    arg(N0, Term, H),
    N1 is N0 + 1,
    fillInArgs(Term, T, N1). 
