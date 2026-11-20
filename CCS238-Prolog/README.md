# CCS238 Prolog Project

**Team:** Amolong / Chua  
**Language:** Prolog (SWI-Prolog)  
**Line of inquiry:** Unification vs. pattern matching; backtracking vs. recursion

## Folder overview

- `prolog/` — three SWI-Prolog programs
- `documentation/program-specs.md` — language-neutral specifications and test placeholders
- `documentation/execution-traces/` — execution trace artifacts
- `documentation/screenshots/` — screenshots
- `documentation/ai-use-log.md` — AI use disclosure log

## How to run (SWI-Prolog on Windows)

On the prepared Windows setup, open PowerShell or the VS Code terminal at the repository root, activate the tools, and move into this folder:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\activate.ps1
cd CCS238-Prolog
```

The activation applies to the current terminal only. Then load a program with one of these commands:

```powershell
swipl -s prolog/family_relationships.pl
swipl -s prolog/maze_solver.pl
swipl -s prolog/list_processing.pl
```

Each command opens the SWI-Prolog prompt with that program loaded. Enter a query ending with a period (`.`); type `;` to request another answer or `.` to stop. Type `halt.` to exit.

### Example queries

Family relationships:

```prolog
?- parent(alice, Who).
?- grandparent(alice, Who).
?- sibling(ethan, Who).
?- ancestor(Who, fiona).
```

Maze solver:

```prolog
?- path(start, goal, Route).
?- setof(Route, path(start, goal, Route), Routes).
```

List processing:

```prolog
?- sum_numbers([1,2,3,4], Sum).
?- keep_even([1,2,3,4,5,6], Evens).
?- double_numbers([1,2,3], Doubled).
```

The family program uses a small example family, and the maze program uses a small example graph. The list predicates take lists of integers as input.

## Programs

- [x] Family relationships: parent, grandparent, sibling, and ancestor
- [x] Maze solver: path search with a visited-node list
- [x] List processing: sum, even-number filter, and doubling map

## Tool versions

- SWI-Prolog version used here: 10.0.2
- OS: Windows (PowerShell)
