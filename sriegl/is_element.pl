/*
Define a predicate:

   is_element(X,L)

which is true if and only if X is an element of list L

Examples:

   ?- is_element(X,[1,2,3]).
   X=1
   X=2
   X=3
   ?- is_element(2,[1,2,3]).
   yes
   ?- is_element(1,[2,3]).
   no
   ?- is_element(1,L).
   L=[1|_]
   L=[_,1|_]
*/

is_element(X, [X|_]).
is_element(X, [_|R]) :-	
	is_element(X, R).
	
/*
Try:
   ?- is_element(X,L).
Explain the result!
*/

% This query results in (theoretically) indefinitely many models for L, where
% the list of each model has a different amount of elements. This holds,
% because no predicate is defined that might stop the recursion, as specified
% in the second argument.

% Prolog searches for models. When X is not instantiated, a list can be found
% to satisfy the first predicate. When searching for another model, the first
% predicate will assumed to be false and the second predicate will be assumed.
% For this second predicate to be true, the list L must have at least two
% elements. Now the first predicate will be considered and a list of arbitrary
% length can be found (since X is not instantiated), that has X as its first
% element. This results in the second model. This would continue until forever
% (theoretically).

/*
Hint:
   assume X is the first element of L

   if X is in L but not the first
   it must be somewhere in the rest
*/
