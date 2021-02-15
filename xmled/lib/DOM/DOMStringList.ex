defmodule XMLed.DOM.DOMStringList do
  use GenServer

  # https://www.w3.org/TR/2004/REC-DOM-Level-3-Core-20040407/core.html#DOMStringList

  def item(index), do: GenServer.call(__MODULE__, {:item, index})
  def length(), do: GenServer.call(__MODULE__, :length)
  def contains(str), do: GenServer.call(__MODULE__, {:contains, str})

  @impl true
  def init(list \\ []), do: {:ok, list}

  @impl true
  def handle_call({:item, index}, _from, list) do
    case Enum.fetch(list, index) do
      {:ok, value} -> {:reply, value, list}
      _ -> {:reply, nil, list}
    end
  end

  def handle_call(:length, _from, list), do: {:reply, length(list), list}
  def handle_call({:contains, str}, _from, list), do: {:reply, Enum.member?(list, str), list}
end
