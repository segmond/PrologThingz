%
:-use_module(library(clpr)).

% block(BlockName, dim(Width, Length));
%   specification of a block dimensions, height doesn't matter

block(b1, dim(5.0, 3.0)).   % Block b1 has size 5 by 3
block(b2, dim(2.0, 6.0)).
block(b3, dim(1.0, 2.4)).
block(b4, dim(1.0, 5.0)).

box(box1, dim(6.0, 6.0)).   % Box box1 has size 6 by 6
box(box2, dim(7.0, 5.0)).
box(box3, dim(6.0, 5.0)).

% Representation of rectangles
%   rect(pos(X, Y), dim(A,B))   represents a rectangle of size A by B a position pos(X,Y)

% rotate(Rectangle, RotatedRectangle):

rotate(rect(Pos, Dim), rect(Pos, Dim)). % zero rotation
rotate(rect(Pos, dim(A, B)), rect(Pos, dim(B, A))). % rotated by 90 degrees.

% block_rectangle(BlockName, Rectangle):
%   Rectangle is a minimal rectangle that accommodates block BlockName

block_rectangle(BlockName, rect(Pos, Dim)):-    % rectangle at any position
    block(BlockName, Dim0),                     % dimensions of blockname
    rotate(rect(Pos, Dim0), rect(Pos, Dim)).     % block possibly rotated

% inside (Rectangle1, Rectangle2): Rectangle1 completely inside Rectangle2
inside(rect(pos(X1,Y1), dim(Dx1, Dy1)), rect(pos(X2,Y2), dim(Dx2,Dy2))):-
    { X1 >= X2, Y1 >= Y2, X1+Dx1 =< X2+Dx2, Y1+Dy1 =< Y2+Dy2 }.

% no_overlap(Rect1, Rect2): Rectangles Rect1 and Rect2 don't overlap
no_overlap(rect(pos(X1,Y1), dim(Dx1, Dy1)), rect(pos(X2,Y2), dim(Dx2,Dy2))):-
    { X1+Dx1 =< X2; X2+Dx2 =< X1;   % Rectangles left or right of each other
      Y1+Dy1 =< Y2; Y2+Dy2 =< Y1   % Rectangles above or below of each other.
    }.
      
% fit(Box, Block1, Block2, Block3, Block4):
%   The 4 blocks whose rectangles are Block1, Block2, ... fit into a box
fit(BoxName, Block1, Block2, Block3, Block4):-
    box(BoxName, Dim),
    Box = rect(pos(0.0, 0.0), Dim),
    block_rectangle(b1, Block1), inside(Block1, Box),
    block_rectangle(b2, Block2), inside(Block2, Box),
    block_rectangle(b3, Block3), inside(Block3, Box),
    block_rectangle(b4, Block4), inside(Block4, Box),
    no_overlap(Block1, Block2),
    no_overlap(Block1, Block3),
    no_overlap(Block1, Block4),
    no_overlap(Block2, Block3),
    no_overlap(Block2, Block4),
    no_overlap(Block3, Block4).

test(R1,R2,R3,R4):-
    fit(box1, R1, R2, R3, R4).

