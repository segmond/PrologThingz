%
time_of_day(morning).
time_of_day(afternoon).

expert(bioinformatics,barbara).
expert(bioinformatics,ben).
expert(artificial_intelligence, barbara).
expert(artificial_intelligence, adam).
expert(databases, adam).
expert(databases, ann).

no_conflict(T1,_,_,T2,_,_):-
    T1 \= T2.

no_conflict(T1,P1,P2,T2,Q1,Q2):-
    P1 \= Q1, P1 \= Q2,
    P2 \= Q1, P2 \= Q2.

session(Time,Topic,P1,P2):-
    time_of_day(Time),
    expert(Topic,P1),
    expert(Topic,P2),
    P1 \= P2.

% schedule 3 sessions, with 3 experts with at least 2 in each session and no overlap
schedule(Ta,A1,A2, Tb,B1,B2, Tc,C1,C2):-
    session(Ta, artificial_intelligence,A1,A2),
    session(Tb, bioinformatics,B1,B2),
    session(Tc, databases,C1,C2),
    no_conflict(Ta,A1,A2,Tb,B1,B2),
    no_conflict(Ta,A1,A2,Tc,C1,C2),
    no_conflict(Tb,B1,B2,Tc,C1,C2).

test:-
    schedule(Ta,A1,A2, Tb,B1,B2, Tc,C1,C2).
