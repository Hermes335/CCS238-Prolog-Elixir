defmodule CCS238.FamilyRelationships do
  @moduledoc """
  Family tree queries: children, parents, grandchildren, siblings and ancestors.

  Elixir version of `family_relationships.pl`. A Prolog predicate can be
  queried in either direction, but an Elixir function only runs one way, so
  `parent/2` becomes two functions (`children/1` and `parents/1`). All answers
  come back together in a list instead of one at a time on backtracking.
  """

  @type person :: atom()

  # same facts as parent/2 in family_relationships.pl
  @parent_facts [
    {:alice, :bob},
    {:alice, :carol},
    {:bob, :diana},
    {:carol, :ethan},
    {:carol, :fiona},
    {:george, :alice},
    {:helen, :alice}
  ]

  @doc "Returns the facts as `{parent, child}` tuples."
  @spec parent_facts() :: [{person(), person()}]
  def parent_facts, do: @parent_facts

  @doc """
  Children of `person`.

  Prolog: `parent(alice, Who)`
  """
  @spec children(person()) :: [person()]
  def children(_person) do
    # TODO: match {^person, child} over @parent_facts
    raise "not implemented"
  end

  @doc """
  Parents of `person`.

  Prolog: `parent(Who, alice)`
  """
  @spec parents(person()) :: [person()]
  def parents(_person) do
    # TODO: same as children/1 but match on the child
    raise "not implemented"
  end

  @doc """
  Grandchildren of `person`.

  Prolog: `grandparent(alice, Who)`
  """
  @spec grandchildren(person()) :: [person()]
  def grandchildren(_person) do
    # TODO: children of each child, flattened into one list
    raise "not implemented"
  end

  @doc """
  People who share a parent with `person`, not counting `person`.

  Prolog: `sibling(ethan, Who)`
  """
  @spec siblings(person()) :: [person()]
  def siblings(_person) do
    # TODO: children of each parent, minus person.
    # Prolog returns a sibling once per shared parent, decide if we keep duplicates.
    raise "not implemented"
  end

  @doc """
  Parents, grandparents and so on of `person`.

  Prolog: `ancestor(Who, fiona)`
  """
  @spec ancestors(person()) :: [person()]
  def ancestors(_person) do
    # TODO: parents ++ ancestors of each parent, [] when there are no parents
    raise "not implemented"
  end
end
