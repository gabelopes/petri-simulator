arcs(A) :-
  findall(arc(P, T, M), arc(P, T, M), A).

inhibitoryArcs(A) :-
  findall(inhibitoryArc(P, T, M), inhibitoryArc(P, T, M), A).

marks(M) :-
  findall(marks(P, N), marks(P, N), M).

initials(I) :-
  findall(initial(P), initial(P), I).

times(Z) :-
  findall(z(P, W), z(P, W), Z).

writeFact(O, F) :-
  format(atom(R), "~w.", [F]),
  writeln(O, R).

saveNetToFile(F) :-
  open(F, write, O),
  arcs(A),
  forEach(A, writeFact(O)),
  inhibitoryArcs(H),
  forEach(H, writeFact(O)),
  marks(M),
  forEach(M, writeFact(O)),
  initials(I),
  forEach(I, writeFact(O)),
  times(Z),
  forEach(Z, writeFact(O)),
  close(O).