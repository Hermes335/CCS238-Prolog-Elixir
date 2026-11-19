defmodule CCS238.ListProcessing do
  @moduledoc """
  Recursive sum, even filter and doubling over lists of integers.

  Elixir version of `list_processing.pl`, using the same names. The Prolog
  output argument becomes the return value, and guards pick the clause where
  Prolog would backtrack.
  """

  @doc """
  Sum of the list. `[]` gives `0`.

  Prolog: `sum_numbers([1,2,3,4], Sum)`
  """
  @spec sum_numbers([integer()]) :: integer()
  def sum_numbers(_numbers) do
    # TODO: [] and [head | tail] clauses (no Enum.sum, we're comparing recursion)
    raise "not implemented"
  end

  @doc """
  Only the even numbers, in their original order.

  Prolog: `keep_even([1,2,3,4,5,6], Evens)`
  """
  @spec keep_even([integer()]) :: [integer()]
  def keep_even(_numbers) do
    # TODO: use guards to pick the even/odd clause.
    # rem(-3, 2) is -1 in Elixir but -3 mod 2 is 1 in SWI, so test rem(x, 2) == 0
    raise "not implemented"
  end

  @doc """
  Every number doubled.

  Prolog: `double_numbers([1,2,3], Doubled)`
  """
  @spec double_numbers([integer()]) :: [integer()]
  def double_numbers(_numbers) do
    # TODO: [] and [head | tail] clauses (no Enum.map)
    raise "not implemented"
  end
end
