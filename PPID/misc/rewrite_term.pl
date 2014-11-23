%
rewrite_term(T, R):-
    T =.. A,
    rewrite_term_aux(A, R).

rewrite_term_aux([b|T], [a|R]):-
    rewrite_term_aux(T, R).

rewrite_term_aux([H|T], [H|R]):-
    rewrite_term_aux(T, R).

rewrite_term_aux([], []).
    
