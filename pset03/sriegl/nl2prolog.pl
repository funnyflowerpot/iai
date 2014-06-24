/*
Transform the following natural language sentences

a) into predicate logic (as closely to the nl-formulation as possible),

b) into clausal form (conjuctive normal form without quantifiers).

c) if possible, try to formulate the statements as prolog programs

d) check if the programs will work properly or not.
   state assumptions which ensure correct solutions,
   if necessary.
   State possible problems or explain why it's
   not possible represent a problem as a prolog program.

(sorry but the English translations are not always 
 very good)

use the symbols:

and - for the logical and
or - for the logical or
not - for the logical not
all x :	- for universal quantification
ex x : - for existential quantification

Try to use the close world assumption and the
unique name assumption if suitable.
(if so note it in a comment)

closed world assumption:
   there are only those individuals in the model
   which are referenced by terms in the program.
   ground literals, which are not provable, are false.

unique name assumption:
   different names refer to different individuals

clark completion:
   for equivalences use one direction of the implication
   (the one you need).
   the other direction is added by the clark completion
   (but it will not be evaluated by prolog;
   so if both direction are needed,
   it will not work)

if possible, add clauses with test data,
to run the programs
*/

% Example:
% 0. Über allen Wipfeln ist Ruh.
%    (it's calm over all treetops)

% all x: treetop(x) ->
%     (all y: place(y) and over(x,y) -> is_calm(y)).

% not treetop(x) or not place(y) or not over(x,y) or is_calm(y)

is_calm(Y) :- treetop(X), place(Y), over(X,Y).

% ok, will work as a prolog program!
% some data to test it

treetop(tt1).
treetop(tt2).
place(p1).
place(p2).
place(p3).
over(tt1,p1).
over(tt2,p2).
over(tt2,p3).


%-----------------------------------------------
% 1. If it is raining and freezing then it is slippery

% all x: location(x) and raining(x) and freezing(x) -> slippery(x)

% not location(x) or not raining(x) or not freezing(x) or slippery(x)

slippery(X) :- location(X), raining(X), freezing(X).

location(osna).
location(siberia).
raining(osna).
raining(siberia).
freezing(siberia).


%-----------------------------------------------
% 2. g can be inferred from a, b, c and d.

% all x: (a(x) and b(x) and c(x) and d(x)) -> g(x)

% not a(x) or not b(x) or not c(x) or not d(x) or g(x)

g(X) :- a(X), b(X), c(X), d(X).

a(r2d2). a(binomialcoefficient). 
b(r2d2). b(binomialcoefficient).
c(r2d2). c(binomialcoefficient).
d(r2d2).


%-----------------------------------------------
% 3. w is true if and only if v is true.

% all x: (w(x) <-> v(x))

% all x: (w(x) or v(x) -> w_or_v(x))
% (not w(x) and not v(x)) or w_or_v(x)

% {{(not w(x) and not v(x)), w_or_v(x)}}

w_or_v(X) :- w(X); v(X).

v(a).
v(b).
w(a).



%-----------------------------------------------
% 4. A man exists who is wiser than all other men.

% ex x: (man(x) and all y: (man(y) and not x = y -> wiser(x,y)) )
% ex x: all y: (man(x) and (man(y) and not x = y -> wiser(x,y)) )

% man(sx) and (man(y) and not sx = y -> wiser(sx,y))
% man(sx) and (not man(y) or sx = y or wiser(sx,y))

% {{man(sx)}, {not man(y), sx = y, wiser(sx,y)}} 

% Not transferrable into Prolog, since there are two positive literals in 
% second inner braces.


%-----------------------------------------------
% 5. No man is wiser than he himself.

% not ex x: (man(x) and wiser(x,x))
% all x: (not man(x) or not wiser(x,x))

% not man(x) or not wiser(x,x)

% {{not man(x), not wiser(x,x)}}

% Not transferrable into Prolog, since there are only two negative literals.


%-----------------------------------------------
% 6. It exists exactly one Kilimandscharo.

% ex x: (kilimandscharo(x) and all y: (kilimandscharo(y) -> x = y))
% ex x: all y: (kilimandscharo(x) and (kilimandscharo(y) -> x = y))

% kilimandscharo(sx) and (kilimandscharo(y) -> sx = y)
% kilimandscharo(sx) and (not kilimandscharo(y) or sx = y)

% {{kilimandscharo(sx)}, {not kilimandscharo(y), sx = y}}

% Reduces because of CWA.

is_kilimandscharo(kilimandscharo).

kilimandscharo.

%-----------------------------------------------
% 7. Every human being has exactly one mother

% all x: (human(x) -> ex y: (mother(y,x) and all z: (mother(z,x) -> y = z)))

% due to CWA can be reduced to
% all x: (human(x) -> ex y: mother(y,x))
% all x: ex y: (human(x) -> mother(y,x))

% human(x) -> mother(sy(x),x)
% not human(x) or mother(sy(x),x)

% {{not human(x), mother(sy(x),x)}}

mother(sy(X), X) :- human(X).


%-----------------------------------------------
% 8. There are exactly two Yokozuna.

% ex x: ex y: (yokozuna(x) and yokozuna(y) and not x = y and all z: (yokozuna(z) -> x = z or y = z))
% due to CWA reducible
% ex x: ex y: (yokozuna(x) and yokozuna(y))

% yokozuna(sx) and yokozuna(sy)

% {{yokozuna(sx)}, {yokozuna(sy)}}

yokozuna(what_the_hell).
yokozuna(is_a_yokozuna).


%-----------------------------------------------
% 9. Es gibt genau 360 Jodelrufe
%    und alle haben eine Bedeutung.
% (There are exactly 360 yodels and everyone has a meaning)
% (use ... freely to denote lots of
%  equally built structures)

% ex x_1: ex x_2: ... ex x_360: (
%   yodel(x_1) and yodel(x_2) and ... and yodel(x_360) and
%   not x_1 = x_2 and not x_1 = x_3 and ... and not x_359 = x_360 and
%   all y: (yodel(y) -> y = x_1 or y = x_2 or ... or y = x_360) and
%   meaning(x_1) and meaning(x_2) and ... and meaning(x_360)))

% due to CWA reducible to
% ex x_1: ex x_2: ... ex x_360: (
%   yodel(x_1) and yodel(x_2) and ... and yodel(x_360))

% yodel(sx_1) and yodel(sx_2) and ... and yodel(sx_360)

% {{yodel(sx_1)}, {yodel(sx_2)}, ... {yodel(sx_360)}}


%-----------------------------------------------
% 10. A thing is exactly then a railway station if it has
%     tracks,
%     a load ticket window, a departure plan
%     and a waiting room.

% Multiple interpretations possible. The easy case would end in a solution
% analogous to exercise 1, like:

% is_railway_station(X) :- 
%   has_tracks(X), 
%   has_load_ticket_window(X),
%   has_departure_plan(X),
%   has_waiting_room(X).

% We will consider a bidirectional interpretation of "exactly then" in the
% following solution, which follows the suggestions from the lecture slides
% about Clark completion (iai_09_2014.pdf, page 30):

% predicate descriptions
% - rws(x): x is railway station
% -  tt(x): x has tracks
% - ltw(x): x has load ticket window
% -  dp(x): x has departure plan
% -  wr(x): x has waiting room

% all x: (rws(x) <-> tt(x) and ltw(x) and dp(x) and wr(x))

% "exactly then" is equal to "iff", which requires Clark completion. To 
% circumvent the "iff" we introduce another predicate (given in natural
% language), that represents the biconditional: "When a thing is a railway 
% station or assembles all components (tt, ltw, dp, wr), then it belongs to
% the class of railway stations."

% Hence, we get a new predicate, that we attempt to formalize.
% - crws(x): x belongs to the class of railway stations

% all x: ((rws(x) or (tt(x) and ltw(x) and dp(x) and wr(x))) -> crws(x))
% (not rws(x) and (not tt(x) or not ltw(x) or not dp(x) or not wr(x))) or crws(x)
% (not rws(x) or crws(x)) or (not tt(x) or not ltw(x) or not dp(x) or not wr(x) or crws(x))

% {{not rws(x), crws(x)}, {not tt(x), not ltw(x), not dp(x),  not wr(x), crws(x)}}

crws(X) :- rws(X).
crws(X) :- tt(X), ltw(X), dp(X), wr(X).

rws(osna).
tt(berlin). tt(muenster).
ltw(berlin). ltw(muenster).
dp(berlin). 
wr(berlin). wr(muenster).
