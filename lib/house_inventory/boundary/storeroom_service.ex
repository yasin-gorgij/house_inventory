defmodule HouseInventory.Boundary.StoreroomService do
  alias HouseInventory.Core.Storeroom
  use GenServer

  def edit_name(new_name) do
    GenServer.call(__MODULE__, {:edit_name, new_name})
  end

  def add_item(name, stock) do
    GenServer.call(__MODULE__, {:add_item, name, stock})
  end

  def get_items() do
    GenServer.call(__MODULE__, {:items})
  end

  @impl true
  def init(storeroom \\ %Storeroom{}) do
    {:ok, storeroom}
  end

  @impl true
  #def handle_call({:create, name}, _from, storeroom) do
  #  {:ok, Storeroom.new(name)}
  #end

  @impl true
  def handle_call({:edit_name, new_name}, _from, storeroom) do
  

    {:reply, :ok, storeroom}
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
