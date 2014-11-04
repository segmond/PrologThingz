% cut changes declarative meaning

% p is true if and only if a and b are both true or c is true
% p <===> (a & b) v c 
p:- a, b.
p:- c.

% we can reorder the goal and the declarative meaning will still hold
% p is true if and only c is true or if a and b are both true
% p <===> c v (a & b) 
p:- c.
p:- a, b.

% p is true if and only if a and b are both true or a is not true and c is true
% p <===> (a & b) v (~a & c )
p:- a, !, b.
p:- c.

% WE CAN'T REORDER THE GOAL WHILE MAINTAING THE DECLARATIVE MEANING ABOVE
% p is true if and only c is true or if a and b are both true.
% p <===> c v (a & b)
p:- c.
p:- a, !, b.


% when a cut is used without effect on declarative meaning, it's called a green cut
% green cut's allow us to maintain purity
% red cuts are the ones that make programs hard and should be used with care
