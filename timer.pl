ellapsedTime(0).

setEllapseTime(T) :-
  retract(ellapsedTime(_)),
  assertz(ellapsedTime(T)).
setEllapseTime(T) :- assertz(ellapsedTime(T)).

passOneSecond :-
  ellapsedTime(X),
  T is X + 1,
  setEllapseTime(T).