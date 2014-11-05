% chapter 1...
area_of_disk(R, Res):-
    Res is (R * R) * 3.14.

%  3.1, Composing functions

profit(TicketPrice, Profit):-
    revenue(TicketPrice, Revenue),
    cost(TicketPrice, Cost),
    Profit is Revenue - Cost.

revenue(TicketPrice, Revenue):-
    attendees(TicketPrice, Attendees),
    Revenue is Attendees * TicketPrice.

cost(TicketPrice, Cost):-
    attendees(TicketPrice, Attendees),
    Cost is 180 + (0.04 * Attendees).

attendees(TicketPrice, Attendees):-
    Attendees is 120 + ((15 / 0.10) * (5.00 - TicketPrice)).


% section 4.3 Conditionals
cond_test(N, Res):-
    (N < 10) -> Res = 5.0;
    (N < 20) -> Res = 5;
    (N < 30) -> Res = true.

% 4.4.1
tax(GrossPay, Res):-
    (GrossPay =< 240) -> Res = 0;
    (GrossPay =< 480) -> Res is GrossPay * 0.15;
    Res is GrossPay * 0.28.

netpay(HoursWorked, NetPay):-
    GrossPay is (HoursWorked * 12),
    tax(GrossPay, Tax),
    NetPay is GrossPay - Tax.

% 6.1
distance_to_0(position(X,Y), Distance):-
    sqrt((X ^ 2 + Y ^ 2), Distance).

% 7.3

perimeter(circle(Radius), P):-
    P is Radius * 2 * 3.14.
perimeter(square(Length), P):-
    P is Length * 4.
