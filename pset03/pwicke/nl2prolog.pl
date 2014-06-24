/*
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
% If it is raining and freezing then it is slippery
% NL -> PL1:
% all x: (raining(x) and freezing(x) -> slippery(x))
% Skolemize: raining(x) and freezing(x) -> silppery(x)
% CNF: not(raining(x) and freezing(x)) or slippery(x)
%	   not raining(x) or not freezing(x) or slippery(x)
% Clausal form: {not raining(x) , not freezing(x) , slippery(x)}
% Only one positive literal, perfect:

slippery(X) :- raining(X), freezing(X).

% test data
raining(day01).
raining(day02).

freezing(day01).
freezing(day03).


%-----------------------------------------------
% 2. g can be inferred from a, b, c and d.
%
% NL-PL1:
% a and b and c and d -> g
% CNF: 	not(a and b and c and d) or g
% 		not a or not b or not c or not d or g
% Clausal form: {not a , not b , not c , not d , g}
% One positive literal, perfect:

g :- a,b,c,d.

% test data
a.
b.
c.
d.

%-----------------------------------------------
% 3. w is true if and only if v is true.
% NL -> PL1:
% w <-> v
% CNF: (w -> v) and (v -> w)
% 	   (not w or v) and ( not v or w)
% Clausal form: {{not w,v},{not v,w}}
% Only one positive literal each, almost perfect
w :- v.
% v :- w. almost because this will result in infinite loop!

%clark completion:
%   for equivalences use one direction of the implication
%   (the one you need).
%   the other direction is added by the clark completion
%   (but it will not be evaluated by prolog;
%   so if both direction are needed,
%   it will not work)

% test data
v.

%-----------------------------------------------
% 4. A man exists who is wiser than all other men.

% PL1: ex X:( man(X) and all Y:( (man(Y) and not X = Y) -> wiser_than(X,Y))) 
% Skolemize: man(sx) and all Y: not man(Y) or X = Y or wiser_than(X,Y) 			|DMG |->/or
%			 man(sx) and not man(Y) or sx = Y or wiser_than(sx,Y)		
% CNF: (man(sx)) and (not man(Y) or wiser_than(sx,Y) or sx =Y)
% Clausal form: {man(sx)} , {not man(Y) , wiser_than(sx,Y) , sx =Y}
% Clausal TO Prolog: {man(sx)} TO man(sx)
%					 {not man(Y) , wiser_than(sx,Y) , sx =Y} 
%					 Two positive literals        // ERROR! 
%				     Lets say we don't need sx=y because of UNA:
%					 

wiser_than(sx,Y) :- man(Y).
man(sx).
% test data
man(helmar_gust). % forgive, could not resist =)


%-----------------------------------------------
% 5. No man is wiser than he himself.
% 
% NL -> PL1: all x: man(X) -> not wiser_than(X,X)	| ->/or
% Skolemized and CNF: not man(X) or not wiser_than(X,X)
% Clausal form: {not man(X),not wiser_than(X,X)}
% No no positive literal: it's a query

% ?- man(X), wiser_than(X,X).
% will answer: false, as no man is wiser than himself

%-----------------------------------------------
% 6. It exists exactly one Kilimandscharo.
% NL -> PL1: ex X: is_Kilimandscharo(X) and all Y: Y not = X -> Y not is_Kilimandscharo(Y)
% UNA will leave Prolog term:
is_Kilimandscharo(sx).



%-----------------------------------------------
% 7. Every human being has exactly one mother
% NL -> PL1 :
% all x:( human(x) -> ex y:( is_mother_to(y,x) and not x=y and 
% all z:( is_mother_to(z,x) -> z=y) )
% CWA - all z is redundant, and UNA - not x=y is redundant
% Remains: all x:( human(x) -> ex y:( is_mother_to(y,x) ))
% Prenex: all x:( ex y:( human(x) -> is_mother_to(y,x) ))
% Skolemize: human(x) -> is_mother_to(sy(x),x)
% CNF: not human(x) or is_mother_to(sy(x),x)
% Clausal form: {not human(x) , is_mother_to(sy(x),x)}
% One positive literal:
 
 is_mother_to(sy(X),X) :- human(X).
% for the sake of humanity, assume that every mother is humanoid
 is_mother_to(X,Y) :- human(X), human(Y).
 
% test data
human(helmar).
human(helmar_mama).

%-----------------------------------------------
% 8.a)There are exactly two Yokozuna.
% 8.b)Well actually there are currently 3 Yokozuna!
%
% NL->PL1: 
% all x:( yokuzuna(a) and yokuzuna(b) and (yokuzuna(x) -> (x=a or x=b)) )
% CWA and UNA leaves: yokuzuna(a) and yokuzuna(b)
% Clausal form: {{yokuzna(a)},{yokuzna(b)}}
% One positive literal each, clauses:

yokuzuna(a).
yokuzuna(b).

% b.) To be precise and name the three
'Yokuzuna'('Hakuho Sho').
'Yokuzuna'('Harumafuji Kohei').
'Yokuzuna'('Kakuryu Rikisaburo').


%-----------------------------------------------
% 9. Es gibt genau 360 Jodelrufe
%    und alle haben eine Bedeutung.
% (There are exactly 360 yodels and everyone has a meaning)
% (use ... freely to denote lots of
%  equally built structures)

% NL -> PL1:
% ex x01:( ex x02: ... ex x360: ( yodel(x1) and yodel(x2) ... and yodel(x360) 
% 			and not x1=x2 and not x1=x3 ... 
%			and not x1=x360 and not x2=x3 and...
%			and ...
%			and all z:( yodel(z) -> z=x1 or z=x2 or ... or z=x360) ))
%			and all w: ex v:( yodel(w) -> meaning(v,w))
% CWA for 'all z' and UNA for all 'not x1=x2 and ... ' leaves:
% ex x01:( ex x02: ... ex x360: ( yodel(x1) and yodel(x2) ... and yodel(x360) )
% and all w:(  ex v:( yodel(w) -> meaning(v,w)) )
% Skolemize: yodel(sx1) and yodel(sx2) ... and yodel(sx360) and yodel(w) -> meaning(sv(w),w)
% First part becomes clauses, second part: yodel(w) -> meaning(sv(w),w) becomes:
% CNF: not yodel(w) or meaning(sv(w),w)
% Clausal form: {not yodel(w) , meaning(sv(w),w)}
% One positive literal: meaning(sv(W),W) :- yodel(W).
% Prolog:
yodel(sx1).
yodel(sx2).
yodel(sx3).	
% ...
yodel(358).
yodel(359).
yodel(360).

meaning(sv(W),W) :- yodel(W).

%-----------------------------------------------
% 10. A thing is exactly then a railway station if it has
%     tracks,
%     a load ticket window, a departure plan
%     and a waiting room.
% 
% NL -> PL1 
% all x:( railway_station(x) <-> (has_tracks(x) and has_load_ticket_window(x) and
% and has_departure_plan(x) and has_waiting_room(x)) )
%
% To CNF: (railway_station(x) -> (has_tracks(x) and has_load_ticket_window(x) and
% and has_departure_plan(x) and has_waiting_room(x))) 
% or
% (has_tracks(x) and has_load_ticket_window(x) and
% and has_departure_plan(x) and has_waiting_room(x) )-> railway_station(x))

% Use ->/or conversion on first:
% (not railway_station(x) or 
% (has_tracks(x) and has_load_ticket_window(x) and
% and has_departure_plan(x) and has_waiting_room(x) ))
% Further conversion on first:
% (not railway_station(x) or has_tracks(x)) and
% (not railway_station(x) or has_load_ticket_window(x)) and
% (not railway_station(x) or has_departure_plan(x)) and
% (not railway_station(x) or has_waiting_room(x)) 

% Use ->/or conversion on second:
% (not(has_tracks(x) and has_load_ticket_window(x) and
% and has_departure_plan(x) and has_waiting_room(x)) or railway_station(x)) 
% Further conversion on second:
% ( railway_station(x) or not has_tracks(x)) and
% ( railway_station(x) or not has_load_ticket_window(x)) and
% ( railway_station(x) or not has_departure_plan(x)) and
% ( railway_station(x) or not has_waiting_room(x))

% Clausal forms:
% {{railway_station(x),not has_tracks(x)},
% { railway_station(x),not has_load_ticket_window(x)},
% { railway_station(x),not has_departure_plan(x)},
% { railway_station(x),not has_waiting_room(x)}}
% Combine to one Clause:
% railway_station(X) :- has_tracks(X), has_load_ticket_window(X),
%	    				has_departure_plan(X), has_waiting_room(X).
% ,
% {{not railway_station(x),has_tracks(x)}
% { not railway_station(x) , has_load_ticket_window(x)},
% { not railway_station(x) , has_departure_plan(x)},
% { not railway_station(x) , has_waiting_room(x)}}
% Leaves 4 clauses:
% has_tracks(X) :- railway_station(X).
% has_load_ticket_window(X) :- railway_station(X).
% has_departure_plan(X) :- railway_station(X).
% has_waiting_room(X) :- railway_station(X).

railway_station(X) :- has_tracks(X), has_load_ticket_window(X),
					  has_departure_plan(X), has_waiting_room(X).
/*					  					  
has_tracks(X) :- railway_station(X).
has_load_ticket_window(X) :- railway_station(X).
has_departure_plan(X) :- railway_station(X).
has_waiting_room(X) :- railway_station(X).

Will result in infinite loop
assume Clark completion!
*/

% test data
railway_station(c).	
has_tracks(b).
has_tracks(a).
has_load_ticket_window(a).
has_departure_plan(a).
has_waiting_room(a).

*/
