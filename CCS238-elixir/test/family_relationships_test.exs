defmodule CCS238.FamilyRelationshipsTest do
  use ExUnit.Case, async: true

  alias CCS238.FamilyRelationships

  # Expected values follow the parent/2 facts in the Prolog file.

  describe "children/1 (Prolog: parent(alice, Who))" do
    test "returns Alice's children" do
      assert Enum.sort(FamilyRelationships.children(:alice)) == [:bob, :carol]
    end

    test "returns [] for someone with no children" do
      assert FamilyRelationships.children(:diana) == []
    end
  end

  describe "parents/1 (Prolog: parent(Who, alice))" do
    test "returns Alice's parents" do
      assert Enum.sort(FamilyRelationships.parents(:alice)) == [:george, :helen]
    end

    test "returns [] for someone with no recorded parents" do
      assert FamilyRelationships.parents(:george) == []
    end
  end

  describe "grandchildren/1 (Prolog: grandparent(alice, Who))" do
    test "returns Alice's grandchildren" do
      # alice -> bob -> diana, alice -> carol -> ethan, fiona
      grandchildren = FamilyRelationships.grandchildren(:alice)
      assert Enum.sort(grandchildren) == [:diana, :ethan, :fiona]
    end
  end

  describe "siblings/1 (Prolog: sibling(ethan, Who))" do
    test "returns Ethan's sibling" do
      # both are children of carol
      assert Enum.sort(FamilyRelationships.siblings(:ethan)) == [:fiona]
    end

    test "returns [] for an only child" do
      assert FamilyRelationships.siblings(:diana) == []
    end
  end

  describe "ancestors/1 (Prolog: ancestor(Who, fiona))" do
    test "returns Fiona's ancestors" do
      # carol, then alice, then george and helen
      ancestors = FamilyRelationships.ancestors(:fiona)
      assert Enum.sort(ancestors) == [:alice, :carol, :george, :helen]
    end

    test "returns [] for someone with no recorded parents" do
      assert FamilyRelationships.ancestors(:george) == []
    end
  end
end
