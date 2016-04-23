%-------------------------------------------------------------------
% 1. describe the following situation of the towers of Hanoi game
% in logic
%
% I I I
% I I I
% +---+ I +-------+
% | d | I | c |
% +----------------+ I +-----------+
% | a | I | b |
% ==================================================================
% peg1 peg2 peg3
%
% use relative positions like
% a is on peg1
% d is on a
% top of d is clear
% etc.
% since the size of the disks matters it must be represented, too.
%
% hints:
% - use the identifiers from the diagram (a, b, c, d, peg1, peg2, peg3)
% - use as size of disks: a:4, b:3, c:2, d:1
% - use predicate names:
% is_on(A,B) meaning A is on B
% clear_top(A) meaning top of A is clear
% and size_of(A,S) meaning size of A is S
% - avoid blanks between predicate name and open parenthesis
% - terminate statements by a dot
% - assume implicit universal quantification for variables
% - use upper case symbols for variables (Prolog style variables)
%

% 2. specify a predicate is_above(A,B) which is true
% if A is on B or if A is on C and C is above B, etc.
%

% 3. specify a predicate move(A,B,C) which is true
% if the top of A is clear
% the top of C is clear
% A is on B
% and the size of C is bigger than size of A
% A is a disk,
% B maybe a disk or a peg
% C maybe a disk or a peg
%
%-------------------------------------------------------------------

% your solution goes here:

% 1. Situation:

% size data
size_of(a,4).
size_of(b,3).
size_of(c,2).
size_of(d,1).
% peg size must be the highest value
size_of(peg1,5).
size_of(peg2,5).
size_of(peg3,5).


% positions
is_on(d,a).
is_on(c,b).
is_on(a,peg1).
is_on(b,peg3).

% clear top
clear_top(c).
clear_top(d).
clear_top(peg2).
%%% 4/4
% 2.
% is_above(A,B) is true
% if A is on B or if A is on C and C is above B, etc.

is_above(A,B) :- is_on(A,C), is_on(C,B);
is_on(A,B).

%%% for the current setup it works, but the "etc." indicates that you should
%%% have solved this more generally:
%%% is_above(A,B) :- is_on(A,B). % base case
%%% is_above(A,B) :- is_on(A,C), is_above(C,B). % recursive loop
%%% Always try to avoid ";" in a rule's body. split up in base case
%%% and rule instead.
%%% 2/3
%3. specify a predicate move(A,B,C) which is true

bigger(A,B) :- size_of(A,Size_A),
size_of(B,Size_B),
Size_A > Size_B.

is_disc(A) :- size_of(A,Size), Size>0, Size<5.

move(A,B,C) :- clear_top(A),
clear_top(C),
is_on(A,B),
bigger(C,A),
is_disc(A).
%%% 3/3

% use this 'predicate' to print all legal moves
% do not change this!

print_all_moves :-
forall(move(A,B,C), writeln(move(A,B,C))),
forall(is_above(A,B), writeln(is_above(A,B))). 
