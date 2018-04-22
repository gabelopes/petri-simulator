isReady(place(_)) :- ellapsedTime(0).
isReady(place(P)) :-
  isPlace(P),
  z(place(P), X),
  ellapsedTime(T),
  R is mod(T, X),
  R =:= 0.
isReady(place(P)) :- isPlace(P).

isPlace(P) :- arc(place(P), _, _).
isPlace(P) :- arc(_, place(P), _).
isPlace(P) :- inhibitoryArc(place(P), _, _).

places(L) :-
  findall(P, isPlace(P), S),
  removeDuplicates(S, L).