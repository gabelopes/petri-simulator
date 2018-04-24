isActive(T) :-
  arc(_, transition(T), _), % If arc to T does not exist, then fails
  forall(arc(P, transition(T), M), (hasEnoughMarks(P, M), isReady(P))),
  forall(inhibitoryArc(Q, transition(T), _), hasNoMarks(Q)).

timesToTransition(P, M, T) :-
  marks(P, X),
  T is div(X, M).

distributeMarks(T, P, M) :-
  timesToTransition(P, M, X),
  do(X, subtractMarks(P, M)),
  forall(arc(transition(T), Q, N), do(X, addMarks(Q, N))).

activate(T) :-
  isActive(T),
  forall(arc(P, transition(T), M), distributeMarks(T, P, M)).

isTransition(T) :- arc(_, transition(T), _).
isTransition(T) :- arc(transition(T), _, _).
isTransition(T) :- inhibitoryArc(_, transition(T), _).

transitions(L) :- 
  findall(T, isTransition(T), S),
  removeDuplicates(S, L).

activeTransitions(L) :- 
  findall(T, (isTransition(T), isActive(T)), S),
  removeDuplicates(S, L).

getRandomActiveTransition(T) :-
  activeTransitions(L),
  random_member(T, L).