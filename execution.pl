:- dynamic running/1.

running(false).

setRunning(R) :-
  retract(running(_)),
  assertz(running(R)).
setRunning(R) :- assertz(running(R)).

feedInitialPlaces :-
  forall(initial(P), addMarks(P, 1)).

checkCompletion :-
  \+ z(_, _),
  \+ existActiveTransitions,
  setRunning(false).
checkCompletion.

simulateCycle :-
  advanceSecond,
  feedInitialPlaces,
  activeTransitions(T),
  forEach(T, activate),
  printTableLine,
  checkCompletion.

stop :- setRunning(false).

existActiveTransitions :-
  activeTransitions(T),
  length(T, L),
  L > 0.

start_async :-
  setRunning(true),
  printHeader,
  printTableLine,
  doAfterAsyncWhile(simulateCycle, 1, running(true)).

start :-
  arc(_, _, _),
  setRunning(true),
  printHeader,
  printTableLine,
  doAfterWhile(simulateCycle, 1, running(true)).