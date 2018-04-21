doAfter(G, T) :-
  sleep(T),
  G.

doAfterWhile(G, T, C) :- 
  C,
  doAfter((G, doAfterWhile(G, T, C)), T).
doAfterWhile(_, _, _).

doAfterAsync(G, T) :-
  thread_create(doAfter(G, T), _, [detached(true)]).  

doAfterAsyncWhile(G, T, C) :- 
  C,
  doAfterAsync((G, doAfterAsyncWhile(G, T, C)), T).
doAfterAsyncWhile(_, _, _).