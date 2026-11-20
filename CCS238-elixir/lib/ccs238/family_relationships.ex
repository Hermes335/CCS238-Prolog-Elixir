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
  def children(person) do
    # ^person means use the value passed in, rather than bind a new variable.
    for {^person, child} <- @parent_facts, do: child
  end

  @doc """
  Parents of `person`.

  Prolog: `parent(Who, alice)`
  """
  @spec parents(person()) :: [person()]
  def parents(person) do
    for {parent, ^person} <- @parent_facts, do: parent
  end

  @doc """
  Grandchildren of `person`.

  Prolog: `grandparent(alice, Who)`
  """
  @spec grandchildren(person()) :: [person()]
  def grandchildren(person) do
    # The second generator runs once for each child, like the two Prolog goals.
    for child <- children(person), grandchild <- children(child), do: grandchild
  end

  @doc """
  People who share a parent with `person`, not counting `person`.

  Prolog: `sibling(ethan, Who)`
  """
  @spec siblings(person()) :: [person()]
  def siblings(person) do
    # Keep one result per shared parent, the same way Prolog can backtrack.
    for parent <- parents(person), sibling <- children(parent), sibling != person, do: sibling
  end

  @doc """
  Parents, grandparents and so on of `person`.

  Prolog: `ancestor(Who, fiona)`
  """
  @spec ancestors(person()) :: [person()]
  def ancestors(person) do
    direct = parents(person)
    # Prolog tries the direct-parent clause first; recursion finds older generations.
    direct ++ Enum.flat_map(direct, &ancestors/1)
  end
end
