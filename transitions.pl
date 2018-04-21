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