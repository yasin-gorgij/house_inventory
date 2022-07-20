defmodule HouseInventory.Core.Storeroom do
  @enforce_keys [:name]
  defstruct [:name, items: %{}]

  @doc """
  Creates a Storeroom by getting its name
  """
  def new(name) do
    %__MODULE__{
      name: name
    }
  end

  def edit_name(storeroom, new_name) do
    %{storeroom | name: new_name}
  end

  def add_item(storeroom, item_name, item_stock) do
    new_items = Map.put(storeroom.items, item_name, item_stock)
    %{storeroom | items: new_items}
  end

  def get_item(storeroom, item_name) do
    Map.get(storeroom.items, item_name, "Item doesn't exist")
  end

  def change_item_name(storeroom, current_name, new_name) do
    current_stock = Map.get(storeroom.items, current_name)
    new_items = Map.delete(storeroom.items, current_name)
    storeroom = %{storeroom | items: new_items}
    add_item(storeroom, new_name, current_stock)
  end

  def update_item_stock(storeroom, item_name, new_stock) do
    new_items = Map.update!(storeroom.items, item_name, fn _ -> new_stock end)
    %{storeroom | items: new_items}
  end

  def delete_item(storeroom, item_name) do
    new_items = Map.delete(storeroom.items, item_name)
    %{storeroom | items: new_items}
  end
end
