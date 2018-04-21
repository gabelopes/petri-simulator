running(false).

setRunning(R) :-
  retract(running(_)),
  assertz(running(R)).
setRunning(R) :- assertz(running(R)).

simulateTimePass :-
  passOneSecond,
  activeTransitions(T),
  forEach(T, activate),
  printTableLine.

stop :- setRunning(false).

existActiveTransitions :-
  activeTransitions(T),
  length(T, L),
  L >= 0.

start_async :-
  setRunning(true),
  printHeader,
  printTableLine,
  doAfterAsyncWhile(simulateTimePass, 1, existActiveTransitions).

start :-
  setRunning(true),
  printHeader,
  printTableLine,
  doAfterWhile(simulateTimePass, 1, existActiveTransitions).