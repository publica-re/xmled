defmodule XMLed.DOM.NamedList do
  use GenServer
  import Kernel, except: [length: 1]

  # https://www.w3.org/TR/2004/REC-DOM-Level-3-Core-20040407/core.html#NameList

  defstruct [:items]

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts)

  @impl true
  def init(%__MODULE__{} = namedList), do: {:ok, namedList}
  def init(%{items: items}), do: {:ok, %__MODULE__{items: items}}
  def init(items) when is_list(items), do: {:ok, %__MODULE__{items: items}}
  def init(), do: {:ok, %__MODULE__{items: []}}

  def getName(index, [for: target] \\ [for: __MODULE__]), do: GenServer.call(target, {:get_name, index})
  def getNamespaceURI(index, [for: target] \\ [for: __MODULE__]), do: GenServer.call(target, {:get_namespace_uri, index})
  def contains(str, [for: target] \\ [for: __MODULE__]), do: GenServer.call(target, {:contains, str})
  def containsNS(namespaceURI, name, [for: target] \\ [for: __MODULE__]), do: GenServer.call(target, {:contains_NS, namespaceURI, name})
  def length([for: target] \\ [for: __MODULE__]), do: GenServer.call(target, :length)

  @impl true
  def handle_call({:get_name, index}, _from, %__MODULE__{items: items} = namedList) do
    case Enum.fetch(items, index) do
      {:ok, %{name: name}} -> {:reply, name, namedList}
      _ -> {:reply, nil, namedList}
    end
  end

  def handle_call({:get_namespace_uri, index}, _from, %__MODULE__{items: items} = namedList) do
    case Enum.fetch(items, index) do
      {:ok, %{namespaceURI: namespaceURI}} -> {:reply, namespaceURI, items}
      _ -> {:reply, nil, namedList}
    end
  end

  def handle_call({:contains, str}, _from, %__MODULE__{items: items} = namedList), do:
    {:reply, Enum.any?(items, fn %{name: name} -> name == str end), namedList}

  def handle_call({:contains_NS, namespaceURI, name}, _from, %__MODULE__{items: items} = namedList), do:
    {:reply, Enum.any?(items, fn %{name: test_name, namespaceURI: test_namespaceURI} -> name == test_name and namespaceURI == test_namespaceURI  end), namedList}

  def handle_call(:length, _from, %__MODULE__{items: items} = namedList), do:
    {:reply, Kernel.length(items), namedList}
end
