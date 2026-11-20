% Program: Maze Solver
% Purpose: Find a route through a small undirected graph.
% Concept demonstrated: Backtracking and search termination.
% Authors: Amolong / Chua
% Date: 2026-11-19
% SWI-Prolog version used here: 10.0.2
%
% HOW TO RUN
% From the CCS238-Prolog folder: swipl -s prolog/maze_solver.pl
% Example query: ?- path(start, goal, Route).
%
% SAMPLE INPUT / EXPECTED OUTPUT (language-neutral)
% Input: Find a path from start to goal.
% Expected output: A simple route such as [start, a, c, goal].
%
% --- FACTS ---
% Each edge connects two adjacent locations; edge/2 is treated as undirected.
edge(start, a).
edge(start, b).
edge(a, c).
edge(b, c).
edge(c, goal).
edge(b, goal).

% --- RULES ---
% path/3 returns a route including both endpoints. Keeping a visited list
% prevents cycles and guarantees termination on this finite graph.
path(Start, Goal, Route) :-
    path_visit(Start, Goal, [Start], ReverseRoute),
    reverse(ReverseRoute, Route).

% When Current unifies with Goal, the route is complete. dif/2 below stops
% Prolog from trying to continue this route after backtracking at the goal.
path_visit(Goal, Goal, Visited, Visited).
path_visit(Current, Goal, Visited, Route) :-
    % adjacent/2 has two clauses, so backtracking checks edges both ways.
    adjacent(Current, Next),
    dif(Current, Goal),
    % \+ means "not provable"; memberchk/2 blocks a location already visited.
    \+ memberchk(Next, Visited),
    path_visit(Next, Goal, [Next|Visited], Route).

adjacent(A, B) :- edge(A, B).
adjacent(A, B) :- edge(B, A).

% --- QUERIES TO TRY ---
% ?- path(start, goal, Route).
% ?- setof(Route, path(start, goal, Route), Routes).
% ?- path(start, nowhere, Route).
%
% NOTES FOR COMPARISON
% Unification matches the current location and edge endpoints during search.
% Backtracking explores alternate adjacent locations. The visited list blocks
% revisiting nodes, so the search terminates even when cycles are present.
