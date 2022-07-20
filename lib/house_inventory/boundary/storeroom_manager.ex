defmodule HouseInventory.Boundary.StoreroomManager do
  alias HouseInventory.Core.Storeroom
  use GenServer

  def start(storerooms \\ []) do
    GenServer.start_link(__MODULE__, storerooms, name: __MODULE__)
  end

  def add_storeroom(name) when is_binary(name) do
    GenServer.call(__MODULE__, {:add, name})
  end

  def delete_storeroom(name) when is_binary(name) do
    GenServer.call(__MODULE__, {:delete, name})
  end

  @impl true
  def init(storerooms \\ []) do
    {:ok, storerooms}
  end

  @impl true
  def handle_call({:edit_name, new_name}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.edit_name(new_name)

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
