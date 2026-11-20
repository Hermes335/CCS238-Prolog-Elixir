# CCS238 Elixir Project

**Team:** Amolong / Chua  
**Language:** Elixir  
**Line of inquiry:** Unification vs. pattern matching; backtracking vs. recursion

Elixir versions of the three programs in [`../CCS238-Prolog/prolog/`](../CCS238-Prolog/prolog/). They use the same facts so the two languages can be compared side by side.

## Folder overview

- `lib/ccs238/`: the three Elixir modules
- `test/`: ExUnit tests
- `docs/execution-traces/`: execution trace artifacts
- `docs/screenshots/`: screenshots

## How to run (Windows)

Install Erlang/OTP and Elixir (see <https://elixir-lang.org/install.html>). Mix comes with Elixir. Then from this folder:

```powershell
mix compile
iex.bat -S mix
```

In PowerShell `iex` is an alias for `Invoke-Expression`, so use `iex.bat`. In Command Prompt or Git Bash, `iex -S mix` works.

### Example calls

Family relationships:

```elixir
CCS238.FamilyRelationships.children(:alice)
CCS238.FamilyRelationships.grandchildren(:alice)
CCS238.FamilyRelationships.siblings(:ethan)
CCS238.FamilyRelationships.ancestors(:fiona)
```

Maze solver:

```elixir
CCS238.MazeSolver.find_path(:start, :goal)
CCS238.MazeSolver.all_paths(:start, :goal)
```

List processing:

```elixir
CCS238.ListProcessing.sum_numbers([1, 2, 3, 4])
CCS238.ListProcessing.keep_even([1, 2, 3, 4, 5, 6])
CCS238.ListProcessing.double_numbers([1, 2, 3])
```

## Tests

```powershell
mix test
```

All 22 tests run and cover the three programs, including empty lists, negative numbers, and an unreachable maze goal.

## Prolog to Elixir

| Prolog | Elixir |
| --- | --- |
| `parent(alice, Who)` | `children(:alice)` |
| `parent(Who, alice)` | `parents(:alice)` |
| `grandparent(alice, Who)` | `grandchildren(:alice)` |
| `sibling(ethan, Who)` | `siblings(:ethan)` |
| `ancestor(Who, fiona)` | `ancestors(:fiona)` |
| `adjacent/2` | `neighbors/1` |
| `path(start, goal, Route)` | `find_path(:start, :goal)` |
| `setof(Route, path(start, goal, Route), Routes)` | `Enum.sort(all_paths(:start, :goal))` |
| `sum_numbers([1,2,3,4], Sum)` | `sum_numbers([1, 2, 3, 4])` |
| `keep_even([1,2,3,4,5,6], Evens)` | `keep_even([1, 2, 3, 4, 5, 6])` |
| `double_numbers([1,2,3], Doubled)` | `double_numbers([1, 2, 3])` |

## Programs

- [x] Family relationships: children, parents, grandchildren, siblings, ancestors
- [x] Maze solver: neighbors, first path, all paths
- [x] List processing: sum, even filter, doubling

## Tool versions

- Elixir version used here: 1.20.5
- Erlang/OTP version used here: 29.1.2
- OS: Windows (PowerShell)
