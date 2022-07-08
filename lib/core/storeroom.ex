defmodule HouseInventory.Core.Storeroom do
  @enforce_keys [:name]
  defstruct [:name, items: []]

  alias HouseInventory.Core.Item

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def update_name(storeroom, new_name) do
    %{storeroom | name: new_name}
  end

  def add_item(storeroom, item) do
    %{storeroom | items: [item | storeroom.items]}
  end

  def update_item_name(storeroom, item, new_name) do
    new_item = Item.update(item, {:name, new_name})
    update_storeroom_item(storeroom, item, new_item)
  end

  def update_item_stock(storeroom, item, new_stock) do
    new_item = Item.update(item, {:stock, new_stock})
    update_storeroom_item(storeroom, item, new_item)
  end

  def delete_item(storeroom, item) do
    items = List.delete(storeroom.items, item)
    %{storeroom | items: items}
  end

  defp update_storeroom_item(storeroom, old_item, new_item) do
    storeroom
    |> delete_item(old_item)
    |> add_item(new_item)
  end
end
