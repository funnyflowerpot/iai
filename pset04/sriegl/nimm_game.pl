/*
define a predicate:

    move(S1,S2)

which is true, if the change from S1 to S2 is a correct move
for the 'Nimmspiel':

There are heaps of matches, e.g.:

     iiiii iiii iii ii i

Each player selects a heap and removes at least one match.
The one who must take the last match wins.

Hint: represent the state as a list of lists containing the
a symbol 'i' for each match.

Hint: you may use 'subst_element'
*/


% This definition subst_element/4 is the same as in the respective exercise.
% For documentation, see the respective exercise.
subst_element(Element, Replacement, [Element|R], [Replacement|R]).
subst_element(Element, Replacement, [First|R1], [First|R2]) :-
	subst_element(Element, Replacement, R1, R2).


% move(?S1, ?S2)
% True, iff S1 differs from S2 in exactly one sublist. 

% A sublist is called heap (see Wikipedia). State1 and State2 differ in 
% exactly one heap (Heap1 and Heap2, respectively), so the other heaps of 
% both states are pairwise equal, compared by their position and by their 
% content. 
% For difference between Heap1 and Heap2 it holds, that Heap2 is missing at
% least one item compared to Heap1 (Heap2 is a subset of Heap1, but not vice 
% versa). Since all elements in both heaps are equal ("i"), the difference 
% will be assumed to be at the beginning of Heap1, for the sake of an easy and
% readable implementation. 
move(State1, State2) :- 
	% The only difference of State1 and State2 is Heap1 in State1 beeing Heap2
	% in State2.
	subst_element(Heap1, Heap2, State1, State2),
	% "[_|_]" would be [i] or [i, i] or [i, i, i]... Respectively Heap1 would
	% be equal to [i|Heap2] or [i, i|Heap2] or [i, i, i|Heap2]...
	append([_|_], Heap2, Heap1).



% test_move(-SecondState)
% Helper predicate for the ease of testing move/2, can be ignored.
test_move(SecondState) :-
	move([[i], [i, i], [i, i, i], [i, i, i, i], [i, i, i, i, i]], SecondState).
	