forEach([], _).
forEach([H|T], P) :-
  call(P, H),
  forEach(T, P).

removeDuplicates([], []).
removeDuplicates([H|T], L) :-
  removeDuplicates(T, S),
  (\+ member(H, S) -> L = [H|S]; L = S).


do(0, _).
do(T, G) :-
  X is T - 1,
  do(X, G),
  G.