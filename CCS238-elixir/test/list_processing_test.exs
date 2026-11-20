defmodule CCS238.ListProcessingTest do
  use ExUnit.Case, async: true

  alias CCS238.ListProcessing

  # Expected values follow the predicates in list_processing.pl.

  describe "sum_numbers/1 (Prolog: sum_numbers/2)" do
    test "sums a list of integers" do
      assert ListProcessing.sum_numbers([1, 2, 3, 4]) == 10
    end

    test "returns 0 for the empty list" do
      assert ListProcessing.sum_numbers([]) == 0
    end
  end

  describe "keep_even/1 (Prolog: keep_even/2)" do
    test "keeps only the even numbers, in order" do
      assert ListProcessing.keep_even([1, 2, 3, 4, 5, 6]) == [2, 4, 6]
    end

    test "returns [] for the empty list" do
      assert ListProcessing.keep_even([]) == []
    end

    test "handles negative numbers like SWI-Prolog's mod" do
      # in SWI, -3 mod 2 is 1 and -2 mod 2 is 0
      assert ListProcessing.keep_even([-3, -2, -1, 0]) == [-2, 0]
    end
  end

  describe "double_numbers/1 (Prolog: double_numbers/2)" do
    test "doubles every number" do
      assert ListProcessing.double_numbers([1, 2, 3]) == [2, 4, 6]
    end

    test "returns [] for the empty list" do
      assert ListProcessing.double_numbers([]) == []
    end
  end
end
