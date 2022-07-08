defmodule HouseInventoryTest do
  use ExUnit.Case
  alias HouseInventory.Core.{Item, Storeroom}

  @gloves %Item{name: "Gloves", stock: 3}
  @tissue_paper %Item{name: "Tissue paper", stock: 5}

  @downstairs %Storeroom{name: "Downstairs"}

  describe("Item:") do
    test "item with a name and stock should be created" do
      assert Item.new(name: "Gloves", stock: 3) == @gloves
    end

    test "item without a name should raise error" do
      assert_raise ArgumentError, fn ->
        Item.new(stock: 3)
      end
    end

    test "item without stock should raise error" do
      assert_raise ArgumentError, fn ->
        Item.new(name: "Shampoo")
      end
    end

    test "update item name" do
      item =
        @gloves
        |> Item.update({:name, "Hand wash"})

      assert item.name == "Hand wash"
      assert item.stock == 3
    end

    test "update item stock" do
      item =
        @gloves
        |> Item.update({:stock, 2})

      assert item.name == "Gloves"
      assert item.stock == 2
    end
  end

  describe("Storeroom:") do
    test "storeroom with a name should be created" do
      assert Storeroom.new(name: "Downstairs") == @downstairs
    end

    test "update storeroom name" do
      storeroom =
        @downstairs
        |> Storeroom.update_name("Upstairs")

      assert storeroom.name == "Upstairs"
    end

    test "storeroom without a name should raise error" do
      assert_raise ArgumentError, fn ->
        Storeroom.new(items: [@gloves])
      end
    end

    test "add item to storeroom" do
      storeroom =
        @downstairs
        |> Storeroom.add_item(@gloves)

      assert length(storeroom.items) == 1
      assert hd(storeroom.items) == @gloves
    end

    test "update item name in the storeroom" do
      new_name = "Dish wash"

      storeroom =
        @downstairs
        |> Storeroom.add_item(@gloves)
        |> Storeroom.update_item_name(@gloves, new_name)

      assert hd(storeroom.items).name == new_name
    end

    test "update item stock in the storeroom" do
      new_stock = 10

      storeroom =
        @downstairs
        |> Storeroom.add_item(@gloves)
        |> Storeroom.update_item_stock(@gloves, new_stock)

      assert hd(storeroom.items).stock == new_stock
    end

    test "delete item from storeroom" do
      storeroom =
        @downstairs
        |> Storeroom.add_item(@tissue_paper)
        |> Storeroom.add_item(@gloves)

      assert length(storeroom.items) == 2

      storeroom = Storeroom.delete_item(storeroom, @gloves)
      assert length(storeroom.items) == 1
      assert hd(storeroom.items) == @tissue_paper
    end
  end
end
