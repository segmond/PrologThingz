% see http://www.topcoder.com/tc?d1=tutorials&d2=dynProg&module=Static
:- use_module(library('clpfd')).

% given 3 type of coins with values 1 3 and 5
% how many of them do we need to add up to 11?
findcoins(Coins, NumOfCoins):-
    Coins = [A,B,C],
    Coins ins 1\/3\/5,

    NumOfCoins = [N1, N2, N3],
    NumOfCoins ins 0..3125,

    all_different(Coins),
    A*N1 + B*N2 + C*N3 #= 3125,
    label(Coins),
    label(NumOfCoins).


findMinAmountOfCoins:-
    findall(N, findcoins(C,N), R),
    maplist(sum_list, R, R2),
    min_member(R3, R2),
    write(R3).

%
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).
