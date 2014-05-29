/*
Consider the following pairs of lists.

Assign values to the variables (if possible) such that the lists become equal
(test of unifyability).

Write down clauses for the three placed predicate 'test_unify'.

First argument: number of case; 
second and third argument: pair of lists; 
body: equations for the variables or 'fail' if not unifyable.

Use '_' in front of variables if necessary to avoid warnings.
*/

% Example:
% 1.  [A,B,C]        -- [jerry,likes,fish]
%   A=jerry, B=likes, C=fish

test_unify(1,[A,B,C],[jerry,likes,fish]) :-
  A = jerry,
  B = likes,
  C = fish.

% Example:
% 2.  [a|b]         -- [a,b]
%   fail: b =/= [b]
test_unify(2, [a|b] ,[a,b]) :- fail.

% 3.  [cat]         -- [X|Y]
test_unify(3, [cat], [X|Y]) :-
	X = cat,
	Y = [].

% 4.  [A,B|C]       -- [mary,[does,not,like],fish]
test_unify(4, [A, B|C], [mary,[does, not, like], fish]) :-
	A = mary,
	B = [does, not, like],
	C = [fish].

% 5.  [['I'|A]|B]   -- [[I,go],[by,bike]]
test_unify(5, [['I'|A]|B], [[I, go],[by, bike]]) :-
	A = [go],
	B = [[by, bike]],
	I = 'I'.

% 6.  [A,B|C,W]     -- [a,nice,piece,[of,work]]
% Syntax error. After bar and before closing bracket there must be only one
% variable. Maybe you meant this instead?
/*
test_unify(6, [A, B, C|W], [a, nice, piece, [of, work]]) :-
	A = a,
	B = nice,
	C = piece,
	W = [[of, work]].
*/

% 7.  [nice|A]      -- [nice,weekend]
test_unify(7, [nice|A], [nice, weekend]) :-
	A = [weekend].

% 8.  [lame,duck]   -- [duck,A]
test_unify(8, [lame, duck], [duck, _]) :-
	fail.

% 9.  [lame|P]      -- [x|duck]
test_unify(9, [lame|_], [x|duck]) :-
	fail.

% 10. [Lame,Duck]   -- [lahme,ente]
test_unify(10, [Lame, Duck], [lahme, ente]) :-
	Lame = lahme,
	Duck = ente.

% 11. [[[a,b],c],d] -- [A,B|C]
test_unify(11, [[[a, b], c], d], [A, B|C]) :-
	A = [[a, b], c],
	B = d,
	C = [].

/*
Hint:
use the Prolog system to verify your tries
*/