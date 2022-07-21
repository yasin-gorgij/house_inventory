defmodule HouseInventory.Boundary.StoreroomManager do
  alias HouseInventory.Core.Storeroom
  use GenServer

  def create_storeroom(name) when is_binary(name) do
    GenServer.call(__MODULE__, {:create, name})
  end

  def delete_storeroom(name) when is_binary(name) do
    GenServer.call(__MODULE__, {:delete, name})
  end

  def get_storerooms do
    GenServer.call(__MODULE__, {:storerooms})
  end

  def edit_storeroom_name(current_name, new_name) do
    GenServer.call(__MODULE__, {:edit_name, current_name, new_name})
  end

  @impl true
  def init(storerooms) do
    {:ok, storerooms}
  end

  @impl true
  def handle_call({:create, name}, _from, storerooms) do
    new_storeroom = name |> Storeroom.new()
    new_storerooms = storerooms |> Map.put(name, new_storeroom)

    {:reply, :ok, new_storerooms}
  end

  @impl true
  def handle_call({:delete, name}, _from, storerooms) do
    new_storerooms = Map.delete(storerooms, name)

    {:reply, :ok, new_storerooms}
  end

  @impl true
  def handle_call({:storerooms}, _from, storerooms) do
    names = Map.keys(storerooms)

    {:reply, names, storerooms}
  end

  @impl true
  def handle_call({:edit_name, current_name, new_name}, _from, storerooms) do
    storeroom = storerooms |> Map.get(current_name)
    new_storeroom = storeroom |> Storeroom.edit_name(new_name)

    {:reply, :ok, new_storeroom}
  end

  @impl true
  def handle_call({:add_item, name, stock}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.add_item(name, stock)

    {:reply, :ok, new_storeroom}
  end

  @impl true
  def handle_call({:items}, _from, storeroom) do
    {:reply, storeroom.items, storeroom}
  end

  @impl true
  def handle_call({:change_item_name, current_name, new_name}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.change_item_name(current_name, new_name)

    {:reply, :ok, new_storeroom}
  end

  @impl true
  def handle_call({:update_item_stock, item, new_stock}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.update_item_stock(item, new_stock)

    {:reply, :ok, new_storeroom}
  end

  @impl true
  def handle_call({:delete_item, item}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.delete_item(item)

    {:reply, :ok, new_storeroom}
  end
end
