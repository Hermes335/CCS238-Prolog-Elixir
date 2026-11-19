% Program: Family Relationships
% Purpose: Describe parent, grandparent, sibling, and ancestor relationships.
% Concept demonstrated: Unification and basic backtracking.
% Authors: Amolong / Chua
% Date: 2026-11-19
% SWI-Prolog version: TODO (record the installed version)
%
% HOW TO RUN
% From the CCS238-Prolog folder: swipl -s prolog/family_relationships.pl
% Example query: ?- parent(alice, Who).
%
% SAMPLE INPUT / EXPECTED OUTPUT (language-neutral)
% Input: Query for Alice's children.
% Expected output: Bob, Carol (in either order).
%
% --- FACTS ---
parent(alice, bob).
parent(alice, carol).
parent(bob, diana).
parent(carol, ethan).
parent(carol, fiona).
parent(george, alice).
parent(helen, alice).

% --- RULES ---
grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandchild).

sibling(Person1, Person2) :-
    parent(Parent, Person1),
    parent(Parent, Person2),
    dif(Person1, Person2).

ancestor(Ancestor, Descendant) :-
    parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :-
    parent(Ancestor, Intermediate),
    ancestor(Intermediate, Descendant).

% --- QUERIES TO TRY ---
% ?- parent(alice, Who).
% ?- grandparent(alice, Who).
% ?- sibling(ethan, Who).
% ?- ancestor(Who, fiona).

% NOTES FOR COMPARISON
% Unification occurs when query variables match the arguments of parent/2 and
% the relationship rules. Backtracking finds additional matching facts and
% alternate derivations of a relationship.
