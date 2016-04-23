 % Autoren: pwicke, ktrebing, sriegl, tgrenzdoerff
% Datum: 30.04.2014

/*
Consider the following family tree and formulate the
information contained in that tree as prolog facts.
*/

% Kronos oo Rhea
% |
% +--Hades
% |
% +--Zeus oo Hera
% | |
% | +--Hebe
% |
% +--Poseidon oo Amphitrite
% |
% +--Triton
% |
% +--Rode
%
% (read the tree from upper left to lower right)

/*
Think about how information concerning gender can
be represented with minimal redundancy.
Hint: to state both father(kronos,poseidon) and male(kronos)
as facts in the program is redundant, because
male(kronos) is derivable from father(kronos,poseidon)

Use predicate names from the set: {father, mother, parent, male, female}
*/


/*
Pose at least these queries:
- Who is the mother of whom?
- Which are the children of Zeus?
- Do Hades and Zeus have both the same father?
- Which Individuals have common children?
- Which men have more than one child?
- Who has no ancestor (in this family tree)?

Add the queries and answers as arguments of the following predicate.
*/

query( % example
'Who is the mother of whom?',
(mother(M,C)),
(M=rhea, C=hades;
M=rhea, C=zeus;
M=rhea, C=poseidon;
M=amphitrite, C=triton;
M=amphitrite, C=rode) ). % more variables connected by ','
% alternatives connected by ';'
% if there is no answer enter 'false' here
query(
'Which are the children of Zeus?',
(father(zeus,X)) ,
(X = hebe) ).
query(
'Do Hades and Zeus have both the same father?',
(father(X,zeus),father(X,hades)) ,
(X = kronos) ).
query(
'Which Individuals have common children?',
(mother(X,Z),father(Y,Z)) ,
(X = rhea,
Z = hades,
Y = kronos ;
X = rhea,
Z = zeus,
Y = kronos ;
X = rhea,
Z = poseidon,
Y = kronos ;
X = hera,
Z = hebe,
Y = zeus ;
X = amphitrite,
Z = triton,
Y = poseidon ;
X = amphitrite,
Z = rode,
Y = podeidon.) ).
query(
'Which men have more than one child?',
(father(X,Y),father(X,Z), not(Z=Y)) ,
(X = kronos,
Y = hades,
Z = zeus ;
X = kronos,
Y = hades,
Z = poseidon ;
X = kronos,
Y = zeus,
Z = hades ;
X = kronos,
Y = zeus,
Z = poseidon ;
X = kronos,
Y = poseidon,
Z = hades ;
X = kronos,
Y = poseidon,
Z = zeus ;
false.) ).
query(
'Who has no ancestor?',
((male(NoChild);female(NoChild)),not(father(X,NoChild);mother(X,NoChild))) ,
(NoChild = kronos ;
NoChild = kronos ;
NoChild = kronos ;
NoChild = rhea ;
NoChild = rhea ;
NoChild = rhea ;
NoChild = hera ;
NoChild = amphitrite ;
NoChild = amphitrite.) ).

%%% You could build a rule parent:
%%% parent(P,C) :- father(P,C).
%%% parent(P,C) :- mother(P,C).
%%%
%%% which will simplify the query to:
%%% (male(NoChild);female(NoChild)),parent(_,NoChild)

% Facts

%structure: father(father, child).
father(kronos, hades).
father(kronos, zeus).
father(kronos, poseidon).
father(poseidon, triton).
father(poseidon, rode).
father(zeus, hebe).

%structure: mother(mother, child).
mother(rhea, hades).
mother(rhea, zeus).
mother(rhea, poseidon).
mother(hera, hebe).
mother(amphitrite, triton).
mother(amphitrite, rode).

%structure: male(X).
male(hades).
male(triton).
female(hebe).
female(rode).

%rules:
male(X) :- father(X,Y).
female(X) :- mother(X,Y).

%%% -0.5 p : Try to keep the clauses with same name together in
%%% the code. Otherwise Prolog complains.
Sample solution 
