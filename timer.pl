:- dynamic ellapsedTime/1.

ellapsedTime(0).

setEllapseTime(T) :-
  retract(ellapsedTime(_)),
  assertz(ellapsedTime(T)).
setEllapseTime(T) :- assertz(ellapsedTime(T)).

advanceSecond :-
  ellapsedTime(X),
  T is X + 1,
  setEllapseTime(T).