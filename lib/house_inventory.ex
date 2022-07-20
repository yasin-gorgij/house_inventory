defmodule HouseInventory do
  alias HouseInventory.Service.StoreroomService
  @service StoreroomService

  def create(storeroom_name) do
    GenServer.start_link(@service, storeroom_name)
  end

  def edit_name(new_name) do
    GenServer.call(@service, {:edit_name, new_name})
  end

  def add_item(name, stock) do
    GenServer.call(@service, {:add_item, name, stock})
  end

  def get_items() do
    GenServer.call(@service, {:items})
  end
end
