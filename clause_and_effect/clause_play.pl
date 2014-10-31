p :- q.
p :- s.
q :- r.
r :- s.
s.

prove(true) --> {!}.
prove(Head) -->
    { clause(Head, Body) },
    [ Head ],
    prove(Body).
