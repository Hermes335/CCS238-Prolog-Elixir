# Provisional thesis

Prolog delegates matching and search to unification and backtracking, so relational questions and route finding can be expressed directly as rules. Elixir requires explicit functions and search steps, but its named return values and visible control flow make the same programs easier to follow as general application code; Elixir is therefore the stronger default for such code, while Prolog remains especially effective for relation-heavy search.

This position is deliberately arguable. The paper must test it against the examples, evaluation criteria, and sources rather than assume that shorter code is always better or that explicit code is always clearer.

## Four analysis topics

### 1. Syntax and Semantics (Group A)

**Question:** How does each language express a two-step family relationship?

**Working claim:** Prolog states a grandparent relationship as two goals sharing a variable. Elixir uses two generators in a list comprehension to produce the matching grandchildren. Both represent the same family facts, but a Prolog rule is a condition to prove, while the Elixir function computes and returns a list.

**Code pair:** `grandparent/2` in [family_relationships.pl] and `grandchildren/1` in [family_relationships.ex].

**Trace to discuss:** Alice leads to Bob, then Diana; backtracking or the next comprehension iteration leads to Carol, then Ethan and Fiona. Both produce Diana, Ethan, and Fiona.

**Design explanation to source:** Why Prolog makes a clause a logical relation and why Elixir organizes this work as a function over explicit values.

### 2. Data Types and Type Systems (Group A)

**Question:** How do the two programs represent and process an integer list?

**Working claim:** Both split a list into a head and tail for recursion. Prolog's predicate relates an input list to an output value and uses `is/2` to evaluate arithmetic. Elixir's function returns the computed value directly; its `@spec` documents the intended integer-list input and integer output. The specification is not a runtime type check.

**Code pair:** `sum_numbers/2` in [list_processing.pl] and `sum_numbers/1` in [list_processing.ex].

**Trace to discuss:** `[1,2,3,4]` reaches the empty-list base case and returns a sum of `10`; `[]` returns `0`. The `keep_even` examples provide a second check for negative integers.

**Design explanation to source:** How each language treats terms, lists, and declared or documented types. Do not describe Elixir as statically type checked merely because `@spec` appears in the file.

### 3. Expressions and Control Structures (Group B)

**Question:** Who controls the search for a maze route?

**Working claim:** Prolog tries `adjacent/2` choices through backtracking, while the Elixir code walks neighbors with recursive helpers and `Enum.find_value/2`. Both keep a visited list to prevent cycles. Failure appears as an unsuccessful Prolog query or a tagged Elixir return value, `{:error, :no_path}`.

**Code pair:** `path_visit/4` and `adjacent/2` in [maze_solver.pl], alongside `first_route/3`, `routes_from/3`, and `find_path/2` in [maze_solver.ex].

**Trace to discuss:** The first route is `start → a → c → goal`. Searching for every simple route yields four routes. Searching for `nowhere` finds none.

**Design explanation to source:** Why search is implicit in Prolog's execution model and explicit in Elixir's function calls and return values.

### 4. Logic Programming (Group B)

**Question:** Can the same parent relationship be asked in both directions?

**Working claim:** Prolog can ask `parent(alice, Who)` and `parent(Who, alice)` using the same `parent/2` facts. The Elixir implementation provides separate `children/1` and `parents/1` functions, each fixing a different tuple position. This makes Prolog's relation flexible for queries, while Elixir gives each direction a named interface.

**Code pair:** `parent/2` facts in [family_relationships.pl], alongside `@parent_facts`, `children/1`, and `parents/1` in [family_relationships.ex].

**Trace to discuss:** Alice's children are Bob and Carol; Alice's parents are George and Helen. Explain how Prolog binds `Who` in each query and how Elixir's pinned pattern selects tuples.

**Design explanation to source:** What relational querying offers, and what explicit directional functions offer, for the paper's chosen scenarios.

## Evidence limits and next writing step

The companion programs use a small, fixed family, graph, and input lists. They support concrete claims about these examples; they do not establish performance, reliability, or maintainability for all applications. The final paper should add sources for language history, design goals, typing, and execution behavior, then assess the thesis against the required evaluation matrix and scenarios.
