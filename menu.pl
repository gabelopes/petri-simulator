writef_ln(S, A) :-
  nl, writef(S, A), nl.

handleAddArc(p) :-
  write_ln("Name of the origin place:"),
  read(P),
  write_ln("Name of the destination transition:"),
  read(T),
  write_ln("Weight of the arc:"),
  read(W),
  setArc(place(P), transition(T), W),
  writef_ln("Arc %w --%w--> %w successfully added.", [P, W, T]).
handleAddArc(t) :-
  write_ln("Name of the origin transition:"),
  read(T),
  write_ln("Name of the destination place:"),
  read(P),
  write_ln("Weight of the arc:"),
  read(W),
  setArc(transition(T), place(P), W),
  writef_ln("Arc %w --%w--> %w successfully added.", [T, W, P]).

handleEntry(l) :-
  write_ln("Give the file location:"),
  write_ln("Give it between quotes. Remember to escape bars on Windows (\\)."),
  write_ln('E.g. "C:\\\\myfile.pl".'),
  read(F),
  text_to_string(F, S),  
  consult(S),
  writef_ln("Net '%w' successfully loaded.", [S]),
  menu.
handleEntry(l) :-
  write_ln("Failed to load net."),
  menu.

handleEntry(a) :-
  write_ln("Choose one of the options:"),
  write_ln("p - Create an arc from a place to a transition"),
  write_ln("t - Create an arc from a transition to a place"),
  read(O),
  handleAddArc(O),
  menu.
handleEntry(a) :-
  write_ln("Could not add arc."),
  menu.

handleEntry(i) :-
  write_ln("Name of the origin place:"),
  read(P),
  write_ln("Name of the destination transition:"),
  read(T),
  write_ln("Weight of the inhibitory arc:"),
  read(W),
  setInhibitoryArc(place(P), transition(T), W),
  writef_ln("Inhibitory arc %w --%w--> %w successfully added.", [P, W, T]),
  menu.
handleEntry(i) :-
  write_ln("Could not add inhibitory arc."),
  menu.

handleEntry(m) :-
  write_ln("Name of the place:"),
  read(P),
  write_ln("Number of marks:"),
  read(M),
  setMarks(place(P), M),
  writef_ln("Marks of %w successfully set to %w", [P, M]),
  menu.
handleEntry(m) :-
  write_ln("Unable to set marks."),
  menu.

handleEntry(z) :-
  write_ln("Name of the place:"),
  read(P),
  writef_ln("Time Z(%w):", [P]),
  read(Z),
  setZ(place(P), Z),
  writef_ln("Time of %w successfully set to %w", [P, Z]),
  menu.
handleEntry(z) :-
  write_ln("Unable to set time."),
  menu.

handleEntry(j) :-
  write_ln("Name of the place:"),
  read(P),
  unsetZ(place(P)),
  writef_ln("Time of %w successfully unset", [P]),
  menu.
handleEntry(j) :-
  write_ln("Unable to unset time."),
  menu.

handleEntry(f) :-
  write_ln("Name of the place:"),
  read(P),
  setInitial(P),
  write_ln("Place %w successfully set as automatically fed.", [P]),
  menu.  
handleEntry(f) :-
  write_ln("Could not set automatic feed, is the name informed a place?"),
  menu.

handleEntry(h) :-
  write_ln("Name of the place:"),
  read(P),
  unsetInitial(P),
  write_ln("Place %w successfully unset as automatically fed.", [P]),
  menu.
handleEntry(h) :-
  write_ln("Could not unset automatic feed, is the name informed a place?"),
  menu.

handleEntry(s) :-
  write_ln("Give the file location:"),
  write_ln("Give it between quotes. Remember to escape bars and special characters using \\<char>."),
  write_ln('E.g. "C:\\\\myfile.pl".'),
  read(F),
  text_to_string(F, S),
  saveNetToFile(S),
  writef_ln("Net successfully saved to '%w'.", [S]),
  menu.
handleEntry(s) :-
  write_ln("Failed to saved net."),
  menu.

handleEntry(b) :-
  start,
  menu.
handleEntry(b) :-
  write_ln("There is nothing to do here. Try setting up a Petri net."),
  menu.

handleEntry(x) :- halt.

handleEntry(_) :-
  write_ln("Invalid entry."),
  menu.

writeInstructions :-
  write_ln("In this simulator, you do not need to explicitly create places and transitions."),
  write_ln("By creating arcs from places to transitions or from transitions to places, the simulator automatically detects all places and transitions existent in the net."),
  write_ln("Whenever you are asked to give an input, include a dot at the end of the input, then press Enter."),
  write_ln("In the simulator, each cycle is a second, and when you begin the simulation, there are two cases:"),
  write_ln("\t1. If there are no timed-places, then it will stop once there are no active transitions left."),
  write_ln("\t2. If there is any timed-place, then it will never stop. Thus, to abort a simulation press Ctrl+C, then A.").

writeEntries :-
  nl, write_ln("To start, use one of the options below:"),
  write_ln("l - Load a Petri net from a Prolog file"),
  write_ln("a - Create an arc"),
  write_ln("i - Create an inhibitory arc"),
  write_ln("m - Set marks of a place"),
  write_ln("z - Set time of a place"),
  write_ln("j - Unset time of a place"),
  write_ln("f - Set place to be automatically fed"),
  write_ln("h - Unset place to be automatically fed"),
  write_ln("s - Save current net as a Prolog file"),
  write_ln("b - Begin simulation"),
  write_ln("x - Exit").

menu :-
  writeEntries,
  read(O),
  handleEntry(O).

instructionMenu :-
  writeInstructions,
  menu.