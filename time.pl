:- dynamic z/2.

setZ(P, Z) :-
  retract(z(P, _)),
  assertz(z(P, Z)).
setZ(P, Z) :- assertz(z(P, Z)).

unsetZ(P) :-
  retract(z(P, _)).