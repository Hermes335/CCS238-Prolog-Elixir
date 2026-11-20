# Code and trace evidence for four analysis topics

This matrix supports the [working thesis and outline](../CombinedPaper/thesis-and-analysis-outline.md). Outputs below come from the completed companion programs and the [validation log](companion-program-validation.md). The code excerpts are short; the paper appendix will need full listings.

## Syntax and Semantics (Group A): grandparent relationship

| Prolog | Elixir |
| --- | --- |
| `grandparent(G, C) :- parent(G, P), parent(P, C).` | `for child <- children(person), grandchild <- children(child), do: grandchild` |
| `grandparent(alice, Who)` asks Prolog to find values that make both goals true. | `grandchildren(:alice)` iterates over Alice's children and returns their children as a list. |

**Trace:** Alice matches Bob in the first step, then Diana in the second. The next first-step match is Carol, whose children are Ethan and Fiona. Prolog's recorded answers are `[diana,ethan,fiona]`; the enabled Elixir test expects the same three people.

**What the evidence supports:** A rule describes a condition for a relationship; a comprehension constructs the output list. The shared variable `P` connects the Prolog goals, while the Elixir `child` value connects the two generators.

**Source locations:** [Prolog family rules], lines 29–31; [Elixir grandchildren function], lines 54–58.

## Data Types and Type Systems (Group A): recursive list sum

| Prolog | Elixir |
| --- | --- |
| `sum_numbers([], 0).` | `def sum_numbers([]), do: 0` |
| `sum_numbers([Head\|Tail], Sum) :- sum_numbers(Tail, TailSum), Sum is Head + TailSum.` | `def sum_numbers([head \| rest]), do: head + sum_numbers(rest)` |

**Trace:** For `[1,2,3,4]`, both programs match a nonempty list repeatedly until `[]`. On the way back, the values become `4`, `7`, `9`, then `10`. Both return `0` for `[]`. The list filter also returns `[-2,0]` for `[-3,-2,-1,0]` in both languages.

**What the evidence supports:** Both use head/tail list structure and an empty-list base case. Prolog's `Sum` is an output argument and `is/2` evaluates arithmetic. Elixir returns the arithmetic expression. The Elixir `@spec sum_numbers([integer()]) :: integer()` records intended types but does not enforce them at runtime.

**Source locations:** [Prolog list rules], lines 20–35; [Elixir list functions], lines 11–33.

## Expressions and Control Structures (Group B): maze search

| Prolog | Elixir |
| --- | --- |
| `adjacent(Current, Next), dif(Current, Goal), \+ memberchk(Next, Visited), path_visit(Next, Goal, [Next\|Visited], Route).` | `Enum.find_value(neighbors(current), fn next -> if next in visited, do: nil, else: first_route(next, goal, [next \| visited]) end)` |
| Backtracking tries another `Next` when a branch fails. | `find_value` tries the next neighbor when the callback returns `nil`. |

**Trace:** Both first find `[start,a,c,goal]`. The Prolog `setof/3` run found four simple routes: `[start,a,c,b,goal]`, `[start,a,c,goal]`, `[start,b,c,goal]`, and `[start,b,goal]`. For `start` to `nowhere`, the Prolog search has no solution; Elixir's `find_path/2` returns `{:error, :no_path}` and `all_paths/2` returns `[]` in the passing tests.

**What the evidence supports:** Prolog supplies the choice-point and retry behavior. Elixir spells out neighbor iteration, a failure sentinel, recursive calls, and a tagged public result. Both explicitly record visited locations.

**Source locations:** [Prolog maze rules], lines 27–44; [Elixir maze functions], lines 32–83.

## Logic Programming (Group B): querying a relation in two directions

| Prolog query | Elixir call | Result |
| --- | --- | --- |
| `parent(alice, Who)` | `children(:alice)` | Bob and Carol |
| `parent(Who, alice)` | `parents(:alice)` | George and Helen |

**Trace:** In the first Prolog query, `alice` fixes the first argument of `parent/2`; unification binds `Who` to `bob`, then backtracking finds `carol`. In the second query, `alice` fixes the second argument and `Who` becomes `george`, then `helen`. Elixir's `^person` pattern checks the first tuple position in `children/1` and the second in `parents/1`; each function returns all matches together.

**What the evidence supports:** The same Prolog facts can be queried with different unknowns. Elixir names each query direction as a separate function. This is a difference in interface and execution behavior, not a claim that either language can only represent one kind of relationship.

**Source locations:** [Prolog parent facts], lines 18–24; [Elixir facts and functions], lines 14–47.

## Claims that still need external sources

The code and run log establish behavior for these examples. The final paper still needs primary or scholarly sources for the languages' original design goals, type systems, execution models, and historical context. It should also distinguish these small-program observations from general claims about readability, reliability, and maintainability.
