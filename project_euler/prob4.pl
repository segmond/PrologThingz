solve(R):-
    findall(P, get_palindromes(P), PalindromeList),
    max_list(PalindromeList, R).
get_palindromes(N):-
    between(100,999,I),
    between(I,999,J),
    N is I * J,
    palindrome(N).

palindrome(N):-
    number_codes(N, A), 
    reverse(A, B), 
    A = B.
