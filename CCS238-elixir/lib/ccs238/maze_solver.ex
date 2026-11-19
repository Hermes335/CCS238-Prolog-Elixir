defmodule CCS238.MazeSolver do
  @moduledoc """
  Path finding in a small maze stored as an undirected graph.

  Elixir version of `maze_solver.pl`. Prolog finds other routes by
  backtracking; here the search recurses over the neighbor list instead.
  Both keep a visited list so they never loop.
  """

  @type location :: atom()
  @type route :: [location()]

  # same edge/2 facts and order as maze_solver.pl (the order decides the first route)
  @edges [
    {:start, :a},
    {:start, :b},
    {:a, :c},
    {:b, :c},
    {:c, :goal},
    {:b, :goal}
  ]

  @doc "Returns the edges as `{from, to}` tuples."
  @spec edges() :: [{location(), location()}]
  def edges, do: @edges

  @doc """
  Locations connected to `location` in either direction.

  Prolog: `adjacent/2`
  """
  @spec neighbors(location()) :: [location()]
  def neighbors(_location) do
    # TODO: forward edges first, then reversed ones (same order as adjacent/2)
    raise "not implemented"
  end

  @doc """
  First route from `start` to `goal` that doesn't repeat a location.

  Returns `{:ok, route}`, or `{:error, :no_path}` where Prolog answers `false`.

  Prolog: `path(start, goal, Route)`
  """
  @spec find_path(location(), location()) :: {:ok, route()} | {:error, :no_path}
  def find_path(_start, _goal) do
    # TODO: DFS helper like path_visit/4 with a visited list.
    # Goal clause first, then try unvisited neighbors until one works.
    raise "not implemented"
  end

  @doc """
  Every route from `start` to `goal` that doesn't repeat a location, or `[]`.

  Prolog: `setof(Route, path(start, goal, Route), Routes)`. `setof/3` sorts
  its answers, so compare with `Enum.sort(all_paths(start, goal))`.
  """
  @spec all_paths(location(), location()) :: [route()]
  def all_paths(_start, _goal) do
    # TODO: same search as find_path/2 but collect every route
    raise "not implemented"
  end
end
