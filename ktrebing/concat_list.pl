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

(b)
Try:

   concat_list(L1,L2,[1,2,3,4]).

Explain the result!

(c)
Try:

   concat_list(L1,[a,b],L2).

Explain the result!

Hint:
   assume the first argument is the empty list
     concat_list([],L2,???)
   assume the first argument has at least one element
     concat_list([E|R],L2,???) 
*/

%Rekursionsanker
concat_list([], [], []).

concat_list([], [Head_L2|Tail_L2], [Head_L2|Tail_L3 ]) :- concat_list([], Tail_L2, Tail_L3).

concat_list([Head_L1 | Tail_L1] , List2, [Head_L1 | Tail_L3]) 
		:- concat_list( Tail_L1, List2, Tail_L3).
