% Kenken challenge, non generic solution for
% https://www.reddit.com/r/dailyprogrammer/comments/3snorf/20151113_challenge_240_hard_kenken_solver/
:- use_module(library(clpfd)).

solve(P):-
    kenken(P),
    maplist(writeln, P).

kenken([[A1,B1,C1,D1,E1,F1], 
        [A2,B2,C2,D2,E2,F2], 
        [A3,B3,C3,D3,E3,F3], 
        [A4,B4,C4,D4,E4,F4],
        [A5,B5,C5,D5,E5,F5],
        [A6,B6,C6,D6,E6,F6]]):-

    Vars = [A1,B1,C1,D1,E1,F1,A2,B2,C2,D2,E2,F2,A3,B3,C3,D3,E3,F3,
            A4,B4,C4,D4,E4,F4,A5,B5,C5,D5,E5,F5,A6,B6,C6,D6,E6,F6],

    A1+A2+B1+B2 #= 13,
    C1*D1*D2*E1 #= 180,
    F1+F2+F3 #= 9,
    C2 #= 2,
    E2*E3 #= 20,
    A3+A4+A5 #= 15,
    B3*C3 #= 6,
    C4+D3+D4 #= 11,
    B4 #= 3,
    D5+E4+E5+F4 #= 9,
    B5 mod C5 #= 2,
    D6+E6+F5+F6 #= 18,
    A6+B6+C6 #= 8,

    % Rows
    all_different([A1,B1,C1,D1,E1,F1]),
    all_different([A2,B2,C2,D2,E2,F2]),
    all_different([A3,B3,C3,D3,E3,F3]),
    all_different([A4,B4,C4,D4,E4,F4]),
    all_different([A5,B5,C5,D5,E5,F5]),
    all_different([A6,B6,C6,D6,E6,F6]),

    % Column
    all_different([A1,A2,A3,A4,A5,A6]),
    all_different([B1,B2,B3,B4,B5,B6]),
    all_different([C1,C2,C3,C4,C5,C6]),
    all_different([D1,D2,D3,D4,D5,D6]),
    all_different([E1,E2,E3,E4,E5,E6]),
    all_different([F1,F2,F3,F4,F5,F6]),

    Vars ins 1..6,
    label(Vars).
