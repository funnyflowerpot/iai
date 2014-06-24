/*
Define a predicate:

  palindrom(L)

which should be true if L is a 'palindrome'
(L is equal to its own reversed order)

Examples:
  palindrom([1,2,3,2,1]).   Yes.
  palindrom([1,2,2,1]).     Yes.
  palindrom([1,2,2,1,2,1]). No.

Hint: you may use the predicate 'reverse_order'

Example query: palindrom([1,2,2,1])
*/

% palindrom(+L)
% True, if L is a palindrome.

% An empty list is a palindrome per defintion (in our definition).
palindrom([]).

% An list with only one element is a palindrome per defintion (in our 
% definition).
palindrom([_]).

% L is a palindrome, if the tail R (of L) has the head E (of L) as its last
% argument (via append/3) and the part M (of L) without first and last
% element is a palindrome.
palindrom([E|R]) :-
	append(M, [E], R),
	% The cut was added for convinient output. The cut will be reached iff L
	% can be proven to be a palindrome and will prevent further searching for
	% solutions.
	palindrom(M),!.
	

