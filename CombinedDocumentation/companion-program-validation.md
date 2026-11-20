# Companion program validation

Run on Windows PowerShell with SWI-Prolog 10.0.2, Elixir 1.20.5, and Erlang/OTP 29.1.2.
From the repository root, run `Set-ExecutionPolicy -Scope Process Bypass -Force` and then `.\activate.ps1` before these commands.

## Elixir tests

```powershell
cd CCS238-elixir
mix test
```

Observed output:

```text
Running ExUnit with seed: 607107, max_cases: 24

......................
Finished in 0.01 seconds (0.01s async, 0.00s sync)

Result: 22 passed
```

## Prolog family relationships

From the repository root:

```powershell
swipl -q -s CCS238-Prolog/prolog/family_relationships.pl -g "findall(C,parent(alice,C),Cs),format('children: ~w~n',[Cs]),findall(P,parent(P,alice),Ps),format('parents: ~w~n',[Ps]),findall(G,grandparent(alice,G),Gs),format('grandchildren: ~w~n',[Gs]),findall(S,sibling(ethan,S),Ss),format('siblings: ~w~n',[Ss]),findall(A,ancestor(A,fiona),As),format('ancestors: ~w~n',[As])" -t halt
```

Observed output:

```text
children: [bob,carol]
parents: [george,helen]
grandchildren: [diana,ethan,fiona]
siblings: [fiona]
ancestors: [carol,alice,george,helen]
```

## Prolog maze solver

```powershell
swipl -q -s CCS238-Prolog/prolog/maze_solver.pl -g "path(start,goal,First),format('first route: ~w~n',[First]),setof(Route,path(start,goal,Route),Routes),format('all routes: ~w~n',[Routes]),findall(R,path(start,nowhere,R),Missing),format('no route: ~w~n',[Missing]),path(goal,goal,Same),format('same location: ~w~n',[Same])" -t halt
```

Observed output:

```text
first route: [start,a,c,goal]
all routes: [[start,a,c,b,goal],[start,a,c,goal],[start,b,c,goal],[start,b,goal]]
no route: []
same location: [goal]
```

`findall/3` reports `[]` for the unreachable goal because `path(start, nowhere, _)` has no solution.

## Prolog list processing

```powershell
swipl -q -s CCS238-Prolog/prolog/list_processing.pl -g "sum_numbers([1,2,3,4],S),format('sum: ~w~n',[S]),sum_numbers([],ES),format('empty sum: ~w~n',[ES]),keep_even([1,2,3,4,5,6],E),format('evens: ~w~n',[E]),keep_even([-3,-2,-1,0],NE),format('negative inputs: ~w~n',[NE]),keep_even([],EE),format('empty evens: ~w~n',[EE]),double_numbers([1,2,3],D),format('doubled: ~w~n',[D]),double_numbers([],ED),format('empty doubled: ~w~n',[ED])" -t halt
```

Observed output:

```text
sum: 10
empty sum: 0
evens: [2,4,6]
negative inputs: [-2,0]
empty evens: []
doubled: [2,4,6]
empty doubled: []
```

## Direct Elixir calls

From `CCS238-elixir`:

```powershell
mix run -e 'IO.inspect(CCS238.FamilyRelationships.children(:alice)); IO.inspect(CCS238.FamilyRelationships.ancestors(:fiona)); IO.inspect(CCS238.MazeSolver.find_path(:start, :goal)); IO.inspect(CCS238.MazeSolver.all_paths(:start, :nowhere)); IO.inspect(CCS238.ListProcessing.sum_numbers([])); IO.inspect(CCS238.ListProcessing.keep_even([-3, -2, -1, 0]))'
```

Observed output:

```text
[:bob, :carol]
[:carol, :alice, :george, :helen]
{:ok, [:start, :a, :c, :goal]}
[]
0
[-2, 0]
```
