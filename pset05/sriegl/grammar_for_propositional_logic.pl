/*
Write a grammar for propositional logic with three atomic
formulas u, v, w and junctors not, and, or, impl,
(use '(' and ')' to ensure correct complete bracketings).
Use s as the start symbol.

Demonstrate how you can ensure that on backtracking
the grammar enumerates the whole language.

Hint: force the predicate s to generate only solutions of
a given length and then increase the length of the list.

Examples:
X=[u]
X=[v]
X=[w]
X=[not, (,u,)]
X=[not, (,v,)]
X=[not, (,w,)]
X=[ (,u,and,u,)]
X=[ (,u,and,v,)]
X=[ (,u,and,w,)]
X=[ (,u,or,u,)]
X=[ (,u,or,v,)]
X=[ (,u,or,w,)]
X=[ (,u,impl,u,)]
....
*/


% To start reading, see documentation of enumerate/1 below first.


% For the sake of a transparent CFG, do not reuse the rule s.
s(Length) --> expr(Length).

% No more connectives allowed (empty list), use a predicate.
expr([]) --> ['u']; ['v']; ['w'].

% If there is at list one element (representing a connective) in the list
% (given as rule argument), use one of the rules below. The use of append/3
% allows for having lists of different lists as arguments to subsequent uses
% of the expr rule.
expr([_|Tail]) --> ['not'], expr(Tail).
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['and'],  expr(TailB), [')'].
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['or'],   expr(TailB), [')'].
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['impl'], expr(TailB), [')'].


% enumerate(?X)
% True for X, if X describes an expression of propositional logic as list. If
% X is not instantiated, enumerate all possible expressions.
enumerate(X) :-
	% Find a list L with arbitrary length. This predicates instantiates L in
	% terms of its length, but not of its elements. This behaviour is helpful
	% for feeding s/3 first with a list L of length 0, then of length 1, then
	% of length 2 and so on. This way, all expressions can be listed, ordered
	% by ascending complexity (i.e. numbers of connectives).
	append(L, [], _),
	% s/3 describes a CFG. The length of L specifies the number of connectives
	% (not, and, or, impl) that should be used. Each element of L represents a
	% logical connective and with further recursion in the CFG, items get
	% removed from the list. Note that the acutal value of the elements are
	% irrelevant for this implementation, but could be used if needed though.
	s(L, X, []).
	