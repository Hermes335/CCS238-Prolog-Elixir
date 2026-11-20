# CCS238-Prolog-Elixir

Coursework project for CCS238 using Prolog and Elixir.

## Overview

This repository contains coursework for CCS238, exploring logic programming with Prolog and concurrent programming with Elixir.

## Contents

- **Prolog** — logic programming exercises and problem-solving tasks.
- **Elixir** — concurrent and functional programming exercises.

## Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) (or another Prolog interpreter)
- [Elixir](https://elixir-lang.org/install.html) 1.14+

## Run on Windows (PowerShell)

From the repository root, load the local tools into the current terminal:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\activate.ps1
```

The execution policy change and activation apply only to that terminal. Run both commands again in each new PowerShell terminal.

Start a Prolog prompt with the family program loaded:

```powershell
swipl -s CCS238-Prolog/prolog/family_relationships.pl
```

At the `?-` prompt, try `parent(alice, Who).` and exit with `halt.`. The other programs are `maze_solver.pl` and `list_processing.pl` in the same folder.

Compile and test the Elixir Mix project:

```powershell
cd CCS238-elixir
mix compile
mix test
iex.bat -S mix
```

Use `iex.bat` in PowerShell because `iex` is a built-in alias. At the Elixir prompt, try `CCS238.FamilyRelationships.children(:alice)`; press Ctrl+C twice to exit. All 22 project tests now run and pass.

The local SWI-Prolog executable is under `.local-tools/swipl`. Erlang/OTP and Elixir were installed by Elixir's official user-level installer under `%USERPROFILE%\.elixir-install`. See the project READMEs for more example queries and function calls.
