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
  # [] is the base case. [head | rest] matches one value and the remaining list.
  def sum_numbers([]), do: 0
  def sum_numbers([head | rest]), do: head + sum_numbers(rest)

  @doc """
  Only the even numbers, in their original order.

  Prolog: `keep_even([1,2,3,4,5,6], Evens)`
  """
  @spec keep_even([integer()]) :: [integer()]
  def keep_even([]), do: []

  # A guard chooses the even clause. rem is different from Prolog's mod for
  # negative odd numbers, but both give zero for every even number.
  def keep_even([head | rest]) when rem(head, 2) == 0,
    do: [head | keep_even(rest)]

  def keep_even([_head | rest]), do: keep_even(rest)

  @doc """
  Every number doubled.

  Prolog: `double_numbers([1,2,3], Doubled)`
  """
  @spec double_numbers([integer()]) :: [integer()]
  # Build the result as recursion returns, keeping the original order.
  def double_numbers([]), do: []
  def double_numbers([head | rest]), do: [head * 2 | double_numbers(rest)]
end
