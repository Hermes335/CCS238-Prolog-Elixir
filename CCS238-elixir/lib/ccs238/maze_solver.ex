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
  def neighbors(location) do
    # These two passes follow the order of Prolog's two adjacent/2 clauses.
    forward = for {^location, next} <- @edges, do: next
    backward = for {next, ^location} <- @edges, do: next
    forward ++ backward
  end

  @doc """
  First route from `start` to `goal` that doesn't repeat a location.

  Returns `{:ok, route}`, or `{:error, :no_path}` where Prolog answers `false`.

  Prolog: `path(start, goal, Route)`
  """
  @spec find_path(location(), location()) :: {:ok, route()} | {:error, :no_path}
  def find_path(start, goal) do
    case first_route(start, goal, [start]) do
      nil -> {:error, :no_path}
      route -> {:ok, route}
    end
  end

  @doc """
  Every route from `start` to `goal` that doesn't repeat a location, or `[]`.

  Prolog: `setof(Route, path(start, goal, Route), Routes)`. `setof/3` sorts
  its answers, so compare with `Enum.sort(all_paths(start, goal))`.
  """
  @spec all_paths(location(), location()) :: [route()]
  def all_paths(start, goal) do
    routes_from(start, goal, [start])
  end

  # Pattern matching handles the goal before we look at any more neighbors.
  defp first_route(goal, goal, visited), do: Enum.reverse(visited)

  defp first_route(current, goal, visited) do
    # find_value stops at the first route; Prolog stops when we take its first answer.
    Enum.find_value(neighbors(current), fn next ->
      if next in visited, do: nil, else: first_route(next, goal, [next | visited])
    end)
  end

  defp routes_from(goal, goal, visited), do: [Enum.reverse(visited)]

  defp routes_from(current, goal, visited) do
    # Each recursive branch has its own visited list so a route cannot loop.
    for next <- neighbors(current), next not in visited,
        route <- routes_from(next, goal, [next | visited]), do: route
  end
end
