% Program: List Processing
% Purpose: Sum, filter, and map values in a list of integers.
% Concept demonstrated: Recursion and pattern matching on [Head|Tail].
% Authors: Amolong / Chua
% Date: 2026-11-19
% SWI-Prolog version: TODO (record the installed version)
%
% HOW TO RUN
% From the CCS238-Prolog folder: swipl -s prolog/list_processing.pl
% Example query: ?- sum_numbers([1,2,3,4], Sum).
%
% SAMPLE INPUT / EXPECTED OUTPUT (language-neutral)
% Input: Sum [1,2,3,4].
% Expected output: 10.
%
% --- FACTS ---
% This program needs no data facts; its operations work on input lists.

% --- RULES ---
sum_numbers([], 0).
sum_numbers([Head|Tail], Sum) :-
    sum_numbers(Tail, TailSum),
    Sum is Head + TailSum.

keep_even([], []).
keep_even([Head|Tail], [Head|FilteredTail]) :-
    0 is Head mod 2,
    keep_even(Tail, FilteredTail).
keep_even([Head|Tail], FilteredTail) :-
    1 is Head mod 2,
    keep_even(Tail, FilteredTail).

double_numbers([], []).
double_numbers([Head|Tail], [DoubledHead|DoubledTail]) :-
    DoubledHead is Head * 2,
    double_numbers(Tail, DoubledTail).

% --- QUERIES TO TRY ---
% ?- sum_numbers([1,2,3,4], Sum).
% ?- keep_even([1,2,3,4,5,6], Evens).
% ?- double_numbers([1,2,3], Doubled).
%
% NOTES FOR COMPARISON
% Unification matches [] against the base case and [Head|Tail] against each
% recursive case. Recursion processes the tail until the empty-list base case.
% The filter clauses use backtracking to select the matching even/odd case.
