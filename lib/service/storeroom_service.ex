defmodule HouseInventory.Service.StoreroomService do
  alias HouseInventory.Core.Storeroom
  use GenServer

  def start(storeroom_name) do
    GenServer.start(__MODULE__, storeroom_name)
  end

  @impl true
  def init(storeroom_name) when is_binary(storeroom_name) do
    {:ok, Storeroom.new(storeroom_name)}
  end

  @impl true
  def init(_) do
    {:error, "Storeroom name must be string"}
  end

  @impl true
  def handle_call({:change_name, new_name}, _from, storeroom) do
    new_storeroom =
      storeroom
      |> Storeroom.change_name(new_name)

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
