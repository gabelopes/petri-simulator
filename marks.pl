addMarks(P, M) :-
  marks(P, X),
  Y is M + X,
  setMarks(P, Y).
addMarks(P, M) :- setMarks(P, M).

subtractMarks(P, M) :-
  marks(P, X),
  Y is X - M,
  Y >= 0,
  setMarks(P, Y).

setMarks(P, M) :-
  retract(marks(P, _)),
  assertz(marks(P, M)).
setMarks(P, M) :- assertz(marks(P, M)).

hasEnoughMarks(P, M) :-
  marks(P, N),
  M =< N.

hasNoMarks(P) :- \+ marks(P, _).
hasNoMarks(P) :- marks(P, 0).