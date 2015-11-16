% Kenken challenge, non generic solution for
% https://www.reddit.com/r/dailyprogrammer/comments/3snorf/20151113_challenge_240_hard_kenken_solver/cwzcw49
% Go solution takes 214 seconds, Prolog takes 0.398seconds
%  time(solve(X)).
%  [4,6,5,2,8,7,3,9,1]
%  [3,2,4,6,5,9,7,1,8]
%  [8,4,2,7,1,3,5,6,9]
%  [2,7,3,4,6,1,9,8,5]
%  [1,9,8,5,2,4,6,7,3]
%  [5,3,9,1,4,6,8,2,7]
%  [9,5,6,8,7,2,1,3,4]
%  [6,1,7,9,3,8,4,5,2]
%  [7,8,1,3,9,5,2,4,6]
%  % 5,066,262 inferences, 0.388 CPU in 0.389 seconds (100% CPU, 13050429 Lips)
:- use_module(library(clpfd)).

solve(P):-
    kenken(P),
    maplist(writeln, P).

kenken([[A1,B1,C1,D1,E1,F1,G1,H1,I1], 
        [A2,B2,C2,D2,E2,F2,G2,H2,I2], 
        [A3,B3,C3,D3,E3,F3,G3,H3,I3], 
        [A4,B4,C4,D4,E4,F4,G4,H4,I4],
        [A5,B5,C5,D5,E5,F5,G5,H5,I5],
        [A6,B6,C6,D6,E6,F6,G6,H6,I6],
        [A7,B7,C7,D7,E7,F7,G7,H7,I7],
        [A8,B8,C8,D8,E8,F8,G8,H8,I8],
        [A9,B9,C9,D9,E9,F9,G9,H9,I9]]):-

    Vars = [A1,B1,C1,D1,E1,F1,G1,H1,I1,
            A2,B2,C2,D2,E2,F2,G2,H2,I2,
            A3,B3,C3,D3,E3,F3,G3,H3,I3,
            A4,B4,C4,D4,E4,F4,G4,H4,I4,
            A5,B5,C5,D5,E5,F5,G5,H5,I5,
            A6,B6,C6,D6,E6,F6,G6,H6,I6,
            A7,B7,C7,D7,E7,F7,G7,H7,I7,
            A8,B8,C8,D8,E8,F8,G8,H8,I8,
            A9,B9,C9,D9,E9,F9,G9,H9,I9],

    D2 #= 6,
    E4 #=  6,
    A1*A2 #= 12,
    A4+B4+C4 #= 12,
    A7*B7 #= 45,
    A8+A9 #= 13,
    B8+B9+C9 #= 10,
    B1*B2*C1 #= 60,
    F1*F2*F3 #= 189,
    I1*I2*I3*H2*H3 #= 432,
    D3+D4 #= 11,
    F4+F5+F6 #= 11,
    I4+I5+I6 #= 15 ,
    A5+B5 #= 10,
    C5+C6 #= 17,
    D5*D6*D7 #= 40,
    G5*H5 #=  42,
    E7+E8 #= 10,
    F7+F8+F9+G9+H9 #= 21,
    H7+H8+I7 #= 12 ,
    D8*D9*E9 #= 243,
    A6-B6 #= 2 #\/ B6-A6 #= 2,
    E2-E3 #= 4 #\/ E3-E2 #= 4,
    G2-G3 #= 2 #\/ G3-G2 #= 2,
    G4-H4 #= 1 #\/ H4-G4 #= 1,
    C7-C8 #= 1 #\/ C8-C7 #= 1, 
    G7-G8 #= 3 #\/ G8-G7 #= 3,
    I8/I9 #= 3 #\/ I9/I8 #= 3,
    G6/H6 #=4 #\/ H6/G2 #= 4 ,
    E6 / E5 #= 2 #\/ E5 / E6 #= 2,
    A3 / B3 #= 2 #\/ B3 / A3 #= 2,
    C2 / C3 #= 2 #\/ C3 / C2 #= 2,
    H1 / G1 #= 3 #\/ G1 / H1 #= 3,
    E1 / D1 #= 4 #\/ D1 / E1 #= 4,

    % Rows
    all_different([A1,B1,C1,D1,E1,F1,G1,H1,I1]),
    all_different([A2,B2,C2,D2,E2,F2,G2,H2,I2]),
    all_different([A3,B3,C3,D3,E3,F3,G3,H3,I3]),
    all_different([A4,B4,C4,D4,E4,F4,G4,H4,I4]),
    all_different([A5,B5,C5,D5,E5,F5,G5,H5,I5]),
    all_different([A6,B6,C6,D6,E6,F6,G6,H6,I6]),
    all_different([A7,B7,C7,D7,E7,F7,G7,H7,I7]),
    all_different([A8,B8,C8,D8,E8,F8,G8,H8,I8]),
    all_different([A9,B9,C9,D9,E9,F9,G9,H9,I9]),

    % Column
    all_different([A1,A2,A3,A4,A5,A6,A7,A8,A9]),
    all_different([B1,B2,B3,B4,B5,B6,B7,B8,B9]),
    all_different([C1,C2,C3,C4,C5,C6,C7,C8,C9]),
    all_different([D1,D2,D3,D4,D5,D6,D7,D8,D9]),
    all_different([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
    all_different([F1,F2,F3,F4,F5,F6,F7,F8,F9]),
    all_different([G1,G2,G3,G4,G5,G6,G7,G8,G9]),
    all_different([H1,H2,H3,H4,H5,H6,H7,H8,H9]),
    all_different([I1,I2,I3,I4,I5,I6,I7,I8,I9]),

    Vars ins 1..9,
    label(Vars).
