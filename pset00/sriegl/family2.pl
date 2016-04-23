% -------------------------------------------------------------
%
% mann(X). % X is a man.
%

mann(friederich).
mann(klaus).
mann(bernd).
mann(heinz_bernd).
mann(herrmann_joseph).
mann(oliver).
mann(manuel).
mann(tobias).
mann(ole).
mann(lukas).
mann(heiner).
mann(malte).
mann(peter).
mann(paul).
mann(gerd).
mann(eike).
mann(mark).
mann(torsten).
mann(patrick).
mann(heinz).
mann(nikolaus).
mann(rolf).
mann(joerg).
mann(john).

% ---------------------------------------------------------
%
% frau(X). % X is a woman.
%

frau(elisabeth).
frau(christa).
frau(margret).
frau(gerda).
frau(lisa).

frau(anne).
frau(helene).
frau(ulla).
frau(hildegard).
frau(miriam).
frau(annette).
frau(inga).
frau(lea).
frau(sara).
frau(laura).
frau(helen).
frau(alexandra).
frau(erika).
frau(anni).

%Le
% ------------------------------------------------------
%
% elter(X,Y). % X is a parent of Y
%

elter(friederich,christa).
elter(friederich,margret).
elter(friederich,gerda).
elter(friederich,lisa).
elter(friederich,anne).
elter(friederich,klaus).
elter(elisabeth,christa).
elter(elisabeth,margret).
elter(elisabeth,gerda).
elter(elisabeth,lisa).
elter(elisabeth,anne).
elter(elisabeth,klaus).

elter(bernd, heinz_bernd).
elter(bernd, ulla).
elter(bernd, hildegard).
elter(helene, heinz_bernd).
elter(helene, ulla).
elter(helene, hildegard).

elter(christa, oliver).
elter(christa, manuel).
elter(christa, miriam).
elter(herrmann_joseph, oliver).
elter(herrmann_joseph, manuel).
elter(herrmann_joseph, miriam).
elter(margret, tobias).
elter(margret, simone).
elter(heinz_bernd, tobias).
elter(heinz_bernd, simone).

elter(gerda,ole).
elter(gerda,inga).
elter(heiner,ole).
elter(heiner,inga).

elter(lisa,eike).
elter(lisa,laura).
elter(malte,eike).
elter(malte,laura).

elter(klaus,lea).
elter(klaus,sara).
elter(klaus,lukas).
elter(annette,lea).
elter(annette,sara).
elter(annette,lukas).

elter(hildegard,alexandra).
elter(hildegard,helen).
elter(hildegard,mark).
elter(paul,alexandra).
elter(paul,helen).
elter(paul,mark).

elter(alexandra,patrick).
elter(torsten,patrick).

elter(nikolaus,bernd).
elter(nikolaus,heinz).

elter(heinz,traudel).
elter(heinz,rolf).
elter(anni,traudel).
elter(anni,rolf).

elter(rolf,joerg).
elter(erika,joerg).

% --------------------
% Rules

vater(V,K) :-
elter(V,K),
mann(V).

mutter(M,K) :-
elter(M,K),
frau(M).

sohn(Sohn,Elter) :-
elter(Elter,Sohn),
mann(Sohn).

tochter(Tochter,Elter) :-
elter(Elter,Tochter),
frau(Tochter).

bruder(B,G) :-
elter(E,B),
elter(E,G),
mann(B).

schwester(S,G) :-
elter(E,S),
elter(E,G),
frau(S).

geschwister(A,B) :-
bruder(A,B).

geschwister(A,B) :-
schwester(A,B).

grosselter(G,E) :-
elter(G,X),
elter(X,E).

enkel(E,G) :-
grosselter(G,E).

grossvater(G,E) :-
grosselter(G,E),
mann(G).

grossmutter(G,E) :-
grosselter(G,E),
frau(G).

urgrosselter(U,UE) :-
elter(U,G),
elter(G,E),
elter(E,UE).

cousin(C,X) :-
elter(VM,X),
geschwister(VM,OT),
elter(OT,C),
mann(C).

flump(A,B) :-
elter(C,B),
elter(D,C),
elter(E,D),
sohn(F,E),
elter(F,G),
elter(G,A),
mann(A).


% - Find out who are the grandparents of Tobias

%grosselter(G, tobias).
% Result is: friederich, elisabeth, bernd, helene.


% - Consider the rules for vater and cousin
% and describe how they work.

%vater(V,K) :- elter(V,K), mann(V).
% There is a result set of tuples (V, K) for which it holds that vater(V,K).
% For all elements in the result set it must hold that elter(V,K) and mann(V).
% There are facts for which it holds that elter(V,K) and mann(V) respectively.
% There is a set of tuples (A, B) for which it holds that vater(A,B). There is
% a set of tuples (C) for which it holds that mann(C). There is a set of
% tuples (D, E) that is a intersection of the two former sets with D=A=C and
% E=B. A=C, because the first parameter of elter/2 and mann/1 is equal,
% stating from rule definition. This intersection is the result set of
% vater(V,K) with V=D=A=C and K=E=B.

%cousin(C,X) :- elter(VM,X), geschwister(VM,OT), elter(OT,C), mann(C).
% cousin(C,X) holds, for an X, who has VM as parent, who has OT as sibling,
% who is parent of C and C is male.


% - List all the cousins of Oliver.
% Explain why all names are listed more than once.
% Change the rules such that Oliver is not cousin
% of himself.

%cousin(C, oliver).
% Result is: oliver, manuel, tobias, ole, eike, lukas.

% Names are listet more than once because geschwister/2 checks for brother/2
% or sister/2, which both check for same parents of both parameters. Since
% most members of that family tree have two parents, brother/2 and sister/2
% hold mostly twice, and therefore geschwister/2 as well, and therefore
% cousin/2 as well.

%cousin2(C,X) :- elter(VM,X), geschwister(VM,OT), elter(OT,C), mann(C), not(C=X).


% - Consider the rule flump .
% Which family relationship may be described
% (there is more than one possibility,
% choose the most distant relationship).
% Formulate the rule clearer and correct it.

% A is a cousin second degree großväterlicherseits to B.

%flump2(A,B) :- elter(C,B), elter(D,C), elter(E,D), elter(E,F), mann(F), elter(F,G), elter(G,A), mann(A).

%flump3(A,B) :- mann(A), grosselter(G1,A), bruder(G1,G2), grosselter(G2,B).


% - The program should be extended to answer questions
% like: what is the relationship of Tobias and Ulla?
% Why is the represenation of the facts and rules
% unsuitable for such questions?
% Try to find a better representation and demonstrate
% it on some of the relations.

% It is unsuitable, because in the design above relationships are represented
% by rules and one (i.e. I, with my current skills) cannot query for rules.
% A fact design, that would allow querying relationships could look like this:

%female(rhea).
%male(kronos).
%male(zeus).
%male(hades).
%
%relationship(kronos,zeus,parent).
%relationship(kronos,hades,parent).
%relationship(rhea,zeus,parent).
%relationship(rhea,hades,parent).
%
%
%relationship(A,B,father) :- relationship(A,B,parent), male(A).
%relationship(A,B,mother) :- relationship(A,B,parent), female(A).
%relationship(A,B,sibling) :- relationship(C,A,parent), relationship(C,B,parent), not(A=B).
%relationship(A,B,child) :- relationship(B,A,parent).
%relationship(A,B,son) :- relationship(A,B,child), male(A).
%relationship(A,B,daughter) :- relationship(A,B,child), female(A).
%
%?- relationship(kronos,zeus,X).
%X = parent ;
%X = father ;
%false.
%
%?- relationship(zeus,kronos,X).
%X = child ;
%X = son ;
%false.


% - Additional exercise:
% Try to implement on the basis of the above considerations
% the relationship yca (youngest common ancestor).
% yca(X,Y,Z) should be true if Z is the
% youngest common ancestor of X and Y.
% Hint: To solve this in general is beyond your current skills.
% There are two possible approaches:
% a) Try and error,
% b) Do not solve it in general but limit search depth
% according to the given data. 
