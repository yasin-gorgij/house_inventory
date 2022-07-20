defmodule HouseInventory.Core.Item do
  @enforce_keys ~w(name stock)a
  defstruct ~w(name stock)a

  @type item() :: %HouseInventory.Core.Item{name: String.t(), stock: number()}

  @doc """
  Creates an Item.

  ## Parametes

    - name: Item's name
    - stock: Item's number

  ## Example

      iex> HouseInventory.Core.Item.new("Dishwashing liquid", 4)
      %HouseInventory.Core.Item{name: "Dishwashing liquid", stock: 4}
  """
  @spec new(String.t(), number()) :: item()
  def new(name, stock) do
    %__MODULE__{
      name: name,
      stock: stock
    }
  end

  @doc """
  Changes item name

  ## Parameters

    - item: The item itself
    - new_name: The item new name

  ## Examples

      iex> an_item = %HouseInventory.Core.Item{name: "Dishwashing", stock: 2}
      iex> HouseInventory.Core.Item.change_name(an_item, "Gloves")
      %HouseInventory.Core.Item{name: "Gloves", stock: 2}
  """
  @spec change_name(item(), String.t()) :: item()
  def change_name(item, new_name) do
    %{item | name: new_name}
  end

  @doc """
  Updates item stock

  ## Parameters

    - item: The item itself
    - new_stock: The item new stock

  ## Examples

      iex> an_item = %HouseInventory.Core.Item{name: "Gloves", stock: 2}
      iex> HouseInventory.Core.Item.update_stock(an_item, 11)
      %HouseInventory.Core.Item{name: "Gloves", stock: 11}
  """
  @spec update_stock(item(), number()) :: item()
  def update_stock(item, new_stock) do
    %{item | stock: new_stock}
  end
end
