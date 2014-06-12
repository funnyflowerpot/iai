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

s(Length) --> expr(Length).
expr([]) --> pred.
expr([_|Tail]) --> ['not'], expr(Tail).
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['and'],  expr(TailB), [')'].
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['or'],   expr(TailB), [')'].
expr([_|Tail]) --> {append(TailA, TailB, Tail)}, ['('], expr(TailA), ['impl'], expr(TailB), [')'].

pred --> ['u']; ['v']; ['w'].


enumerate(X) :-
	append(L, [], _),
	s(L, X, []).
	