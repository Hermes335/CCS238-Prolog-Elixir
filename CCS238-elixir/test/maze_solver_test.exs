defmodule CCS238.MazeSolverTest do
  use ExUnit.Case, async: true

  alias CCS238.MazeSolver

  # Expected values worked out by hand from the edge/2 facts and clause order
  # in maze_solver.pl.
  # TODO: confirm with SWI-Prolog and add the cases from program-specs.md

  describe "neighbors/1 (Prolog: adjacent(c, Next))" do
    @describetag skip: "not implemented"

    test "includes locations connected in either direction" do
      assert Enum.sort(MazeSolver.neighbors(:c)) == [:a, :b, :goal]
    end
  end

  describe "find_path/2 (Prolog: path(start, goal, Route))" do
    @describetag skip: "not implemented"

    test "finds the same first route as Prolog" do
      # only holds if neighbors/1 uses the same order as adjacent/2
      assert MazeSolver.find_path(:start, :goal) == {:ok, [:start, :a, :c, :goal]}
    end

    test "returns {:error, :no_path} for an unreachable location" do
      assert MazeSolver.find_path(:start, :nowhere) == {:error, :no_path}
    end

    test "returns a one-location route when start and goal are the same" do
      assert MazeSolver.find_path(:goal, :goal) == {:ok, [:goal]}
    end
  end

  describe "all_paths/2 (Prolog: setof(Route, path(start, goal, Route), Routes))" do
    @describetag skip: "not implemented"

    test "finds every route that never repeats a location" do
      expected = [
        [:start, :a, :c, :b, :goal],
        [:start, :a, :c, :goal],
        [:start, :b, :c, :goal],
        [:start, :b, :goal]
      ]

      # sorted because setof/3 sorts
      assert Enum.sort(MazeSolver.all_paths(:start, :goal)) == expected
    end

    test "returns [] when the goal is unreachable" do
      # setof/3 would fail here instead
      assert MazeSolver.all_paths(:start, :nowhere) == []
    end
  end
end
