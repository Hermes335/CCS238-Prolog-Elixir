% Program: Family Relationships
% Purpose: Describe parent, grandparent, sibling, and ancestor relationships.
% Concept demonstrated: Unification and basic backtracking.
% Authors: Amolong / Chua
% Date: 2026-11-19
% SWI-Prolog version used here: 10.0.2
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
% A query like parent(alice, Who) unifies Who with each matching child.
parent(alice, bob).
parent(alice, carol).
parent(bob, diana).
parent(carol, ethan).
parent(carol, fiona).
parent(george, alice).
parent(helen, alice).

% --- RULES ---
% Parent is shared between the two goals. Prolog backtracks to try the next
% parent/2 fact when a match does not lead to a grandchild.
grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandchild).

sibling(Person1, Person2) :-
    parent(Parent, Person1),
    parent(Parent, Person2),
    % dif/2 keeps a person from being their own sibling. Unlike \=/2, it can
    % also wait for variables to be bound before deciding if they differ.
    dif(Person1, Person2).

% The first clause finds a direct parent; backtracking can then use the
% recursive clause to find earlier generations.
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
