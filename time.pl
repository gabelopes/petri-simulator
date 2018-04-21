setZ(P, Z) :-
  retract(z(P, _)),
  assertz(z(P, Z)).
setZ(P, Z) :- assertz(z(P, Z)).