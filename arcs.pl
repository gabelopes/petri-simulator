:- dynamic arc/3.
:- dynamic inhibitoryArc/3.

setArc(A, B, M) :-
  retract(arc(A, B, _)),
  assertz(arc(A, B, M)).
setArc(A, B, M) :- assertz(arc(A, B, M)).

setInhibitoryArc(A, B, M) :-
  retract(inhibitoryArc(A, B, _)),
  assertz(inhibitoryArc(A, B, M)).
setInhibitoryArc(A, B, M) :- assertz(inhibitoryArc(A, B, M)).