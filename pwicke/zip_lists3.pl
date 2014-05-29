/* 
author: pwicke
date: 21.05.2014
Define a predicate:

   zip_lists3(L, L1, L2)

- L1 and L2 contain together all elements of L,
  but L1 (at least) three times as many as L2.
  (|L2|*3>=|L1|)

- the sequential order should be maintained

- every fourth element of L should be in L2
 
- Order should be maintained!
*/

% L0=[1, 2, 3, 4, 5, 6] 	L1=[1, 2, 3, 5, 6] 	L2=[4]

zip_list3([],[],[]).

zip_list3([L1a, L1b, L1c|R0],[L1a L1b, L1c|R1],[]) :- zip_list(R0,R1,[]).

% D: OHHH AUUA

% wenn der query beispielsweise lautet
% zip_list3([_|_], [], [_|_])
% , dann werden (der reihe nach) alle pr�dikate zip_list3/3 abgeklappert und
% es wird jeweils gepr�ft, ob "die form stimmt". hat erstes pr�dikat die
% "form" "erste variable ist liste mit mindestens ein element, zweite variable
% ist leere liste, dritte variable ist list mit mindestens ein element".
% erstes pr�dikat wird gepr�ft: form passt nicht. zweites pr�dikat wird
% gepr�ft: form passt nicht. ergo: query not provable.

% wenn query:
%   zip_list3([_|_], [_|_], [])
% erstes pr�dikat passt nicht zur form, zweites pr�dikat passt nicht zur form (welcher form?)
% also wird zweites pr�dikat betrachtet und es m�ssen alle ausdr�cke nach ":-"
% geprovt werden. im fall von
%   zip_list3([E1|R0],[E2|R1],[]) :- zip_list3(R0,R1,[]).
% w�rde das hei�en, dass jetzt zu proven ist:
%   zip_list3([], [], [])
% , weil der urspr�ngliche query auf die "conclusion" im besagten pr�dikat
% passt und durch diese form variablen zugewiesen werden (R0, R1), die in den
% neu zu provenden goals auftauchen. die variablen sind festgelegt, da sie im
% urspr�nglichen query instanziert waren (fixe werte, keine variablen). dadurch
% ist f�r prolog klar deutlich, dass nun 
%   zip_list3([], [], [])
% zu beweisen ist. das funktioniert, da es ein pr�dikat gibt, das lautet:
%   zip_list3([], [], []).
% somit kann der urspr�ngliche query bewiesen werden und prolog antwortet "yes".

% ist das nachvollzieb nope.
