% we have 3 projects requiring different skills
project(swingapp, java).
project(windows, vb).
project(unix, c).

% we have programmers with some skills
programmers(bob, perl).
programmers(mike, c).
programmers(mike, java).
programmers(jane, vb).
programmers(ann, java).
programmers(ann, c).
programmers(adam, c).
programmers(john, vb).
programmers(ken, c).

% schedule programmers across different projects according to their skills
schedule(PR1, C1,C2, PR2, C3,C4, PR3, C5,C6):-
    work_on(PR1,C1,C2),
    work_on(PR2,C3,C4),
    work_on(PR3,C5,C6),
    noconflict(PR1,C1,C2,PR2,C3,C4),
    noconflict(PR1,C1,C2,PR3,C5,C6),
    noconflict(PR2,C3,C4,PR3,C5,C6).
    
% C1 and C2 can work on project P 
work_on(P,C1,C2):-
    project(P,Lang),
    programmers(C1,Lang),
    programmers(C2,Lang),
    C1 \= C2.

% There is no project across PR1 and PR2
noconflict(PR1,C1,C2,PR2,C3,C4):-
    PR1 \= PR2,
    C1 \= C3,
    C1 \= C4,
    C2 \= C3,
    C2 \= C4.
