% block is only viewable from top (X,Y) 
% see(Item, XCord, YCord)
see(a,2,5).
see(d,5,5).
see(e,5,2).
see(z,2,5).

% robot can keep track of what each block is standing on
% on(Item, Holder)
on(b,c).
on(c,table).
on(d,table).
on(e,table).
on(a,b).
on(z,a).

% show all visible blocks
non_visible_blocks(B) :-
    on(B,_),
    on(_,B).

% left most block with it's X cord
left_most_block(B,X) :-
    see(B,X,_),
    \+ (see(_,X2,_), X2 < X).

% blocks with nothing on them
free_blocks(B) :-
    on(B,_),
    \+ on(_,B).

% get height of block
height_of_block(B,0):-
    on(B,table).
height_of_block(B,H) :-
    on(B,Under),
    height_of_block(Under,H1),
    H is H1 + 1.

% get the top most block
top_most_block(B) :-
    findall(B, free_blocks(B),L),       % find all blocks with nothing on them
    maplist(height_of_block, L, HL),    % find all their heights
    max_block(L,HL,B).                  % find which one corresponds to the highest height

max_block([A|X],[B|Y],R):-
    max_block(X,Y,B,A,R).
max_block([],[],_,Block,Block).
max_block([_|X], [B|Y], Max,Block, R) :-
    Max > B , max_block(X,Y,Max,Block,R).
max_block([A|X], [B|Y], Max, _,R) :-
    Max =< B , max_block(X,Y,B,A,R).

% X, Y of Block
xy(B,X,Y) :-
    see(B,X,Y).
xy(B,X,Y) :-
    on(Above,B),
    xy(Above,X,Y).

xyz(B,X,Y,Z):-
    xy(B,X,Y),
    height_of_block(B,Z).

% work in progress
move(From, To) :-
    \+ on(_, From),
    see(From, X, Y).
