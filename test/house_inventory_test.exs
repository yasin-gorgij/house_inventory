defmodule HouseInventoryTest do
  use ExUnit.Case
  alias HouseInventory.Core.Storeroom

  @gloves "Gloves"
  @tissue_paper "Tissue paper"
  @five 5

  @downstairs %Storeroom{name: "Downstairs"}

  describe("Core - Storeroom:") do
    test "storeroom with a name should be created" do
      assert Storeroom.new("Downstairs") == @downstairs
    end

    test "change storeroom name" do
      storeroom = Storeroom.change_name(@downstairs, "Upstairs")

      assert storeroom.name == "Upstairs"
    end

    test "add item to storeroom" do
      storeroom = Storeroom.add_item(@downstairs, @gloves, @five)

      assert Enum.count(storeroom.items) == 1
      assert storeroom.items == %{@gloves => @five}
    end

    test "change item name in the storeroom" do
      new_name = "Dishwash"

      storeroom =
        @downstairs
        |> Storeroom.add_item(@gloves, @five)
        |> Storeroom.change_item_name(@gloves, new_name)

      assert hd(Map.keys(storeroom.items)) == new_name
    end

    test "update item stock in the storeroom" do
      new_stock = 10

      storeroom =
        @downstairs
        |> Storeroom.add_item(@gloves, @five)
        |> Storeroom.update_item_stock(@gloves, new_stock)

      assert Map.get(storeroom.items, @gloves) == new_stock
    end

    test "delete item from storeroom" do
      storeroom =
        @downstairs
        |> Storeroom.add_item(@tissue_paper, @five)
        |> Storeroom.add_item(@gloves, @five)

      assert Enum.count(storeroom.items) == 2

      storeroom = Storeroom.delete_item(storeroom, @gloves)

      assert Enum.count(storeroom.items) == 1
      assert storeroom.items == %{@tissue_paper => @five}
    end
  end
end
