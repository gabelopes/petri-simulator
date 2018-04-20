arc(place(p1), transition(t1), 1).
arc(place(p2), transition(t1), 2).
arc(transition(t1), place(p3), 5).
arc(place(p3), transition(t2), 1).
arc(transition(t2), place(p4), 1).

inhibitoryArc(place(p5), transition(t1), 1).

marks(place(p1), 3).
marks(place(p2), 2).

z(place(p1), 2).