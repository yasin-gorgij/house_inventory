defmodule HouseInventory.Core.Item do
  @enforce_keys ~w(name stock)a
  defstruct ~w(name stock)a

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def update(item, field) do
    case field do
      {:name, name} -> %{item | name: name}
      {:stock, stock} -> %{item | stock: stock}
    end
  end
end
