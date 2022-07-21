defmodule HouseInventory.Core.Storeroom do
  defstruct items: %{}

  def add_item(storeroom, item_name, item_stock) do
    new_items = Map.put(storeroom.items, item_name, item_stock)
    %{storeroom | items: new_items}
  end

  def get_items(storeroom) do
    storeroom.items
  end

  def get_item_stock(storeroom, item_name) do
    Map.get(storeroom.items, item_name)
  end

  def update_item_stock(storeroom, item_name, new_stock) do
    new_items = Map.update!(storeroom.items, item_name, fn _ -> new_stock end)
    %{storeroom | items: new_items}
  end

  def change_item_name(storeroom, current_name, new_name) do
    current_stock = Map.get(storeroom.items, current_name)
    new_items = Map.delete(storeroom.items, current_name)

    %{storeroom | items: new_items}
    |> add_item(new_name, current_stock)
  end

  def delete_item(storeroom, item_name) do
    new_items = Map.delete(storeroom.items, item_name)
    %{storeroom | items: new_items}
  end

  def item_exitst?(storeroom, item_name) do
    Map.has_key?(storeroom.items, item_name)
  end
end
