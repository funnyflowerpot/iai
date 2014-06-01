/*
(a)
Define a predicate:

   concat_list(L1,L2,L3)

which is true if and only if
   L3 = L1 + L2
   (+ means concatenation here)

Examples:

   concat_list([1,2,3],[4,5,6],X).
     X=[1,2,3,4,5,6]
   concat_list([1],[2,3],[1,2,3]).
     yes
   concat_list([1],[2,3],[3,2,1]).
     no
   concat_list([1],L,[1,2,3]).
     L=[2,3]
*/

concat_list([], [], []).

concat_list([], [Element|Rest2], [Element|Rest3]) :-
	concat_list([], Rest2, Rest3).

concat_list([Element|Rest1], List2, [Element|Rest3]) :-
	concat_list(Rest1, List2, Rest3).

/*
(b)
Try:

   concat_list(L1,L2,[1,2,3,4]).

Explain the result!
*/

% "Prolog tries" to find two lists, L1 and L2, that result in [1,2,3,4], when
% concatenated. Five combinations are possible, which will all be found. At
% first, L1 will be assumed to be an empty list, which binds L2 to be equal
% to [1,2,3,4]. Then L1 will be assumed to have exactly one element, which
% can only be [1]. The repective complement can only be [2,3,4] for L2. All
% of the five possible results-pairs for L1 and L2 can be explained in this
% deterministic fashion.

/*
(c)
Try:

   concat_list(L1,[a,b],L2).

Explain the result!
*/

% Theoretically infinitely many results can be found. Instantiating one
% variable determines the other one. Assuming L1 to be empty results in [a,b]
% as L2, for this is the corresponding concatenation of [] and [a,b].
% Assuming L1 to be a list with one arbitrary value in it (e.g. [_A]) will
% result in [_A,a,b]. Prolog will search on, since there is no constraint of
% a maximum length for L2 (or L1).

/*
Hint:
   assume the first argument is the empty list
     concat_list([],L2,???)
   assume the first argument has at least one element
     concat_list([E|R],L2,???)
*/