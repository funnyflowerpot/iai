lecture_db(lecture('Multi-Agent Systems',
'Kühnberger',
time_room('Thu 16-18', '31/147'))).

lecture_db(lecture('Functional Programming',
'Gust',
time_room('Thu 12-14', '69/E23'))).

lecture_db(lecture('Aspects of knowledge representation in artificial general intelligence',
'Kühnberger',
time_room('Tue 12-14', '31/147'))).

lecture_db(lecture('Entscheidungs- und Spieltheorie für Studierende der Kognitionswissenschaft',
'Gaertner',
time_room('Thu 14-16', '31/423'))).

lecture_db(lecture('Modal Logic',
'Martinez Baldares',
time_room('Tue 14-16', '31/449'))).

lecture_db(lecture('Introduction to Algebraic Logic',
and('Martinez Baldares', 'Kühnberger'),
time_room('Mon 14-16', '31/423'))).

lecture_db(lecture('Artificial Intelligence',
and('Gust','Kühnberger'),
and(time_room('Mon 14-16', '31/449'),
time_room('Tue 14-16', '31/449')))).

lecture_db(lecture('Tutorials Artificial Intelligence',
and('Gust','Kühnberger'),
and(time_room('Tue 16-18', '69/118'),
and(time_room('Wed 12-14', '69/E15'),
and(time_room('Thu 10-12', '32/372'),
time_room('Fri 12-14', '32/107')))))).

time('Mon 14-16').
time('Tue 12-14').
time('Tue 14-16').
time('Tue 16-18').
time('Wed 12-14').
time('Thu 12-14').
time('Thu 10-12').
time('Thu 16-18').
time('Fri 12-14').

room('31/147').
room('32/107').
room('32/372').
room('69/E15').
room('69/118').
room('31/449').
room('31/423').
room('69/E23').

unwind_and(and(X,_Y),Z) :- unwind_and(X,Z).
unwind_and(and(_X,Y),Z) :- unwind_and(Y,Z).
unwind_and(Z,Z) :- not(Z=and(_,_)).

lecture_name(X,lecture(X,_,_)).

teacher(lecture(_,T,_),X) :- unwind_and(T,X).

time_room(lecture(_,_, TR),X) :- unwind_and(TR, X).

conflict(TR,X1,X2) :-
lecture_db(L1),
lecture_db(L2),
not(L1=L2),
time_room(L1, TR),
time_room(L2, TR),
lecture_name(X1,L1),
lecture_name(X2,L2).

free_room(T,R) :-
time(T), room(R),
not((lecture_db(L), time_room(L, time_room(T, R)))). 
