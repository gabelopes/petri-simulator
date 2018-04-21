writeVariable(P) :-
  writef("%w\t", [P]).

printHeader :-
  write("Z\t"),
  places(P),
  forEach(P, writeVariable),
  transitions(T),
  forEach(T, writeVariable),
  write("\n").

writeMark(P) :-
  marks(place(P), M),
  writef("%w\t", [M]).
writeMark(_) :- write("0\t").

writeTransitionState(T) :-
  isActive(T),
  write("Y\t").
writeTransitionState(_) :- write("N\t").

printTableLine :-
  ellapsedTime(Z),
  writef("%w\t", [Z]),
  places(P),
  forEach(P, writeMark),
  transitions(T),
  forEach(T, writeTransitionState),
  write("\n").