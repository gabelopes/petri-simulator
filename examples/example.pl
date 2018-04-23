arc(place(p1), transition(t1), 1).
arc(place(p1), transition(t2), 1).

arc(place(p2), transition(t3), 1).
arc(place(p2), transition(t4), 1).

arc(place(p3), transition(t2), 1).
arc(place(p3), transition(t3), 1).
arc(place(p3), transition(t4), 1).

arc(transition(t1), place(p1), 1).
arc(transition(t1), place(p3), 1).

arc(transition(t2), place(p2), 1).
arc(transition(t2), place(p3), 1).

arc(transition(t3), place(p2), 1).

arc(transition(t4), place(p1), 1).

marks(place(p1), 1).