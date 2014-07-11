/************************************************************
A water-jug-problem:

Determine the amount of 7 liter of water by using a 3 liter
a 5 liter and a 9 liter jug.

You can
 - refill a jug with new water,
 - refill a jug from one of the other jugs
 - and empty a jug.

the problem is solved as soon as there are
7 liters of water in the third jug.

use the general search shell and write
problem specific end and expand predicates

write a predicate 

  test_it(+Strategy, -Solution) 

which calls the search shell and returns
a solution


Hints:

Use [J1,J2,J3] as state representation
 J1 : content of the 3 liter jug
 J2 : content of the 5 liter jug
 J3 : content of the 9 liter jug

****************************************************************/
% your problem specification goes here:

%
% See bottom of file for our solutions.
%


%---------------------------------------------------------------------------
% skeleton of the general uninformed search algorithm
%---------------------------------------------------------------------------
search(Start,Endp,Expand,Strategy,Path) :-
      search1(Endp,Expand,Strategy,[[Start]],Path).

search1(EndP,_Expand,_Strategy,[[End|Path]|_Agenda],[End|Path]) :-
     EndG =.. [EndP,End],
     EndG.

search1(EndP,Expand,Strategy,[[X|Path]|Agenda],RPath) :-
     Exp =.. [Expand,X,S],
     Exp,
     exp_path(S,[X|Path],Pathes),
     strategy(Strategy,Agenda,Pathes,Agenda1), !,
     search1(EndP,Expand,Strategy,Agenda1,RPath) .

search1(EndP,Expand,Strategy,[_|Agenda],Path) :-
     search1(EndP,Expand,Strategy,Agenda,Path) .

exp_path([],_P,[]).
exp_path([X|R],P,[[X|P]|Ps]) :-
     not(member(X,P)), !,
     exp_path(R,P,Ps).
exp_path([_X|R],P,Ps) :-
     exp_path(R,P,Ps).



% breadth first: consider new nodes after current agenda is done
strategy(breadth_first,Agenda,Pathes,Agenda1) :-
	append(Agenda, Pathes, Agenda1).

% depth first: consider new nodes immediately, agenda only if new nodes are done 
strategy(depth_first,Agenda,Pathes,Agenda1) :-
	append(Pathes, Agenda, Agenda1).


% this is, where we want to arrive someday	
final_state([0, 0, 7]).


% Find all possible subsequent nodes in the search graph.
% +Jugs: the current node, e.g. [3, 0, 6]
% -NextJugsList: a list of nodes, that can be reached from Jugs
expand(Jugs, NextJugsList) :-
	% find all possible solutions for NextJugs for the predicate
	% next_state(Jugs, NextJugs) and return it as list NextJugsList.
	findall(NextJugs, next_state(Jugs, NextJugs), NextJugsList).


% Predicate to find all possible search paths.
% +Strategy: may be "breadth_first" or "depth_first"
% -Sol: a valid search path
test_it(Strategy,Sol) :-
	% start with empty jugs ([0, 0, 0]), check with "final_state/1" whether
	% a valid end state was reached, use "expand/2" to get a list of valid
	% following nodes, use specified search Strategy and return Sol[utions].
	search([0, 0, 0], final_state, expand, Strategy, Sol).
	

%
% Following predicates describe valid nodes, that may be reached from a given
% node.
% 
% next_state(+SourceNode, -DestinationNode)
% +SourceNode: current node
% -DestinationNode: a node, that may be reached from SourceNode
%


% empty one jug
next_state([S1, S2, S3], [0, S2, S3]) :- S1 \= 0.
next_state([S1, S2, S3], [S1, 0, S3]) :- S2 \= 0.
next_state([S1, S2, S3], [S1, S2, 0]) :- S3 \= 0.

% refill one jug
next_state([S1, S2, S3], [3, S2, S3]) :- S1 \= 3.
next_state([S1, S2, S3], [S1, 5, S3]) :- S2 \= 5.
next_state([S1, S2, S3], [S1, S2, 9]) :- S3 \= 9.

% fill into other jug

% To fill one jug into another, we have to determine a source jug and a
% destination jug. To know, which jugs we picked, we introduce their 
% respective capabilities ("cap"s). These capabilities represent the amount
% of water that may be filled into a jug and help to piece new jug amounts
% back together with respect to initial sorting of the jugs.
% "A:B" denotes a helper structure, that can also be written as ":(A,B)".
next_state([S1, S2, S3], [T1, T2, T3]) :-
	% select any jug and its capability from all jugs and keep the remaining
	% jugs
	select(SrcAmount:SrcCap, [S1:3, S2:5, S3:9], OtherJugs),
	% select any jug and its capability from the remaining jugs and remember
	% the unused jug and its capability
	select(DstAmount:DstCap, OtherJugs, [UnusedAmount:UnusedCap]),
	% for the destination jug we need to determine the amount of water we
	% still can fill in
	DstFreeAmount is DstCap - DstAmount,
	% the maximum amount of water to refill is dependent of the amount of 
	% space we have left in the destination jug and the amount of water we
	% have in the source jug
	min_list([SrcAmount, DstFreeAmount], FillAmount),
	% do nothing if we have nothing to refill
	FillAmount \= 0,
	% assign new amounts for source jug and destination jug
	NewSrcAmount is SrcAmount - FillAmount,
	NewDstAmount is DstAmount + FillAmount,
	% revert the assignments in the beginning. piece the new amount for the
	% destination jug and the amount of the unused jug and its capability
	% back together
	select(NewDstAmount:DstCap, OtherJugs2, [UnusedAmount:UnusedCap]),
	% piece the new source amount and the list of the other two jugs back
	% together. if the order does not match, backtracking to the former line
	% will be done until the order of the jugs matches again
	select(NewSrcAmount:SrcCap, [T1:3, T2:5, T3:9], OtherJugs2).

