% Simulator Definitions
:- dynamic arc/3.
:- dynamic inhibitoryArc/3.
:- dynamic marks/2.
:- dynamic z/2.
:- dynamic running/1.
:- dynamic ellapsedTime/1.

% Imports
:- consult(arcs).
:- consult(callers).
:- consult(common).
:- consult(execution).
:- consult(marks).
:- consult(places).
:- consult(printing).
:- consult(time).
:- consult(timer).
:- consult(transitions).