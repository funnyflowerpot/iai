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

Try:
   ?- is_element(X,L).
Explain the result!

Hint:
   assume X is the first element of L

   if X is in L but not the first
   it must be somewhere in the rest
*/
is_element(X, [X | _Rest]).

% True wenn :- erfüllt ist
is_element(X,[_Head|Rest] ) :- is_element(X,Rest).
