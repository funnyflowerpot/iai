% is_element
% author: pwicke
% date: 20.05.2014

% X is a member of the list L 
% if is_element(X,L) is true

% is_element(?X,?L) but not is_element(-X,-L)
% (No other argument usage indication was introduced in lecture so far)

% First we check if X is the same as the head of list L
is_element(X,[X|_Tail]).
% If that doesn't hold than X is not the Head, therefore we cut of the head
% by recalling is_element() with X and the Tail-List
is_element(X,[_Head|Tail]) :- is_element(X,Tail).
% Until the first condition applies: The head is X, otherwise it returns false.



/* Trying:
?- is_element(X,L).
X=_G1427
L=[_G1427|_G1453]

X=_G1427
L=[_G1452,_G1427|_G1456]

X=_G1427
L=[_G1452,_G1455,_G1427|_G1459]

X=_G1427
L=[_G1452,_G1455,_G1458,_G1427|_G1462]

X=_G1427
L=[_G1452,_G1455,_G1458,_G1461,_G1427|_G1465]

 This query results in (theoretically) indefinitely many models for L, where
 the list of each model has a different amount of elements. This holds,
 because no predicate is defined that might stop the recursion, as specified
 in the second argument.

 Prolog searches for models. When X is not instantiated, a list can be found
 to satisfy the first predicate. When searching for another model, the first
 predicate will assumed to be false and the second predicate will be assumed.
 For this second predicate to be true, the list L must have at least two
 elements. Now the first predicate will be considered and a list of arbitrary
 length can be found (since X is not instantiated), that has X as its first
 element. This results in the second model. This would continue until forever
 (theoretically).

*/