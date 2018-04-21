:- dynamic arc/3.
:- dynamic inhibitoryArc/3.
:- dynamic marks/2.
:- dynamic z/2.

ellapsedTime(4).

removeDuplicates([], []).
removeDuplicates([H|T], L) :-
  removeDuplicates(T, S),
  (\+ member(H, S) -> L = [H|S]; L = S).

% Places

isReady(place(_)) :- ellapsedTime(0).
isReady(place(P)) :-
  isPlace(P),
  z(place(P), X),
  ellapsedTime(T),
  R is mod(T, X),
  R =:= 0.

isPlace(P) :- arc(place(P), _, _).
isPlace(P) :- arc(_, place(P), _).

places(L) :- findall(P, isPlace(P), L).

% Transitions

isActive(T) :-
  arc(_, transition(T), _), % If arc to T does not exist, then fails
  forall(arc(P, transition(T), M), hasEnoughMarks(P, M)),
  forall(inhibitoryArc(Q, transition(T), _), hasNoMarks(Q)).

activate(T) :-
  isActive(T),
  forall(arc(P, transition(T), M), subtractMarks(P, M)),
  forall(arc(transition(T), Q, X), addMarks(Q, X)).

isTransition(T) :- arc(_, transition(T), _).
isTransition(T) :- arc(transition(T), _, _).

transitions(L) :- 
  findall(T, isTransition(T), S),
  removeDuplicates(S, L).

activeTransitions(L) :- 
  findall(T, (isTransition(T), isActive(T)), S),
  removeDuplicates(S, L).

getRandomActiveTransition(T) :-
  activeTransitions(L),
  random_member(T, L).

% Arcs

setArc(A, B, M) :-
  retract(arc(A, B, _)),
  assertz(arc(A, B, M)).
setArc(A, B, M) :- assertz(arc(A, B, M)).

setInhibitoryArc(A, B, M) :-
  retract(inhibitoryArc(A, B, _)),
  assertz(inhibitoryArc(A, B, M)).
setInhibitoryArc(A, B, M) :- assertz(inhibitoryArc(A, B, M)).

% Marks

addMarks(P, M) :-
  marks(P, X),
  Y is M + X,
  setMarks(P, Y).

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

% Time Units (assuming seconds)

setZ(P, Z) :-
  retract(z(P, _)),
  assertz(z(P, Z)).
setZ(P, Z) :- assertz(z(P, Z)).

% Timer

doAfter(G, T) :-
  sleep(T),
  G.

doAfterAsync(G, T) :-
  thread_create(doAfter(G, T), _, [detached(true)]).  

doAfterAsyncWhile(G, T, C) :- 
  C,
  doAfterAsync((G, doAfterAsyncWhile(G, T, C)), T).
doAfterAsyncWhile(_, _, _).

% Execution
addOneMark(P) :-
  marks(place(P), M),
  N is M + 1,
  setMarks(place(P), N).

marksLessThan(P, M) :-
  marks(place(P), N),
  N < M.

start :-
  doAfterAsyncUntil(addOneMark(p1), 3, marksLessThan(p1, 10)).