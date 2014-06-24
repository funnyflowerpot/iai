/*
Solve the map-coloring problem for the following map:

http://mvc.ikw.uni-osnabrueck.de/img/map_2013.jgp

- write a prolog program mc(X1,....,Xn) with as many arguments as needed
- use colors: red, blue, green, yellow
- use generate and test first
- try to avoid symmetries (solutions which are only renamings of all the colors of other solutions).
- try to optimize the generate and test solution (write an optimized version mc1(X1,...,Xn))
- use the predicate time to check for efficiency improvements
- try to use only the colors red, blue, green
- find a most simple map (use ascii graphics in a comment) which can only be colored with four colors
- document the results as comments in the program
*/



% pretty colors
colored(red).
colored(blue).
colored(green).
colored(yellow).


% for all elements in the list, find a color
assign_colors([]).
assign_colors([Head|Tail]) :-
	colored(Head),
	assign_colors(Tail).


% version 1
mc(A,B,C,D,E,F,G,H,I) :-
	
	% reverse order for optimization (A will be backtracked first)
	assign_colors([I, H, G, F, E, D, C, B, A]),

	% define color equalities depending on bordering areas

	% common additional borders for A
	A \= B,
	A \= D,
	% common additional borders for B
	B \= C,
	B \= G,
	B \= I,
	% common additional borders for C
	C \= D,
	C \= H,
	% common additional borders for D
	D \= E,
	D \= I,
	% common additional borders for E
	E \= H,
	% common additional borders for F
	F \= H,
	% common additional borders for G
	G \= H,
	% common additional borders for H
	H \= I .
	% common additional borders for I
	% none
	

% version 2
mc1(A,B,C,D,E,F,G,H,I) :-

	% define color equalities depending on bordering areas

	% common additional borders for A
	colored(A),
	colored(B),
	A \= B,
	
	% avoid "symmetries"
	% Stick to choices made by now. A and B have a common border and must
	% therefore have different colors. Backtracking beyond this point would
	% only lead to redundant results. Upcoming redundant results are harder
	% to avoid.
	% With only two allowed colors, this will result in only one solution.
	!,
	
	colored(D),
	A \= D,
	% common additional borders for B
	colored(C),
	B \= C,
	colored(G),
	B \= G,
	colored(I),
	B \= I,
	% common additional borders for C
	C \= D,
	colored(H),
	C \= H,
	% common additional borders for D
	colored(E),
	D \= E,
	D \= I,
	% common additional borders for E
	E \= H,
	% common additional borders for F
	colored(F),
	F \= H,
	% common additional borders for G
	G \= H,
	% common additional borders for H
	H \= I.
	% common additional borders for I
	% none
	


% QUERY time(mc(A,B,C,D,E,F,G,H,I)).

/*

  +-----+-----+    Most simple map which requires four colours.
  |  B  |  C  |
  |  +--+--+  |    Let there be an area A. Let there be an area B, that
  |  |     |  |    borders area A. A and B must have different colors.
  +--+  A  +--+    Let there be an area C, that borders A and B. A, B, and
  |  |     |  |    C must have different colors. Let there be an area D,
  |  +-----+  |    that borders A, B and C. All areas must have different
  |     D     |    colors.
  +-----------+

*/

/*
Result documentation.

% the query we are entering
?- mc1(A,B,C,D,E,F,G,H,I).

% first result
A = C, C = E, E = F, F = G, G = I, I = red,
B = D, D = H, H = blue ;
% different colors for A and B will be found. 


% second result
A = green,
B = D, D = H, H = blue,
C = E, E = F, F = G, G = I, I = red ;
A = yellow,
B = D, D = H, H = blue,
C = E, E = F, F = G, G = I, I = red ;
A = C, C = E, E = F, F = G, G = I, I = red,
B = green,
D = H, H = blue 


*/

