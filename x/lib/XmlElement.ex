defmodule XmlElement do
  use XmlNode

  def start_link(table, element) do
    id = insert_node(table, element)
    Task.start_link(__MODULE__, :loop, [%{table: table, id: id, callers: %{}}])
  end

  defdelegate insert_node(table, element), to: XmlNode
  defdelegate retrieve_node(table, element), to: XmlNode

  def loop(%{table: table, id: id} = args) do
    [{id, element}] = :ets.lookup(table, id)
    receive do
      {:get_name, caller} ->
        send caller, {:value, id, Map.get(element, :name)}
        add_caller(args, caller, :name)
      {:set_name, value} ->
        :ets.insert(table, {id, Map.put(element, :name, value)})
        send_callers(args, :name, :get_name)
    end
  end

  def add_caller(%{callers: callers} = args, caller, obj) do
    new_obj_callers = MapSet.put(Map.get(callers, obj, MapSet.new()), caller)
    loop(%{args | callers: Map.put(callers, obj, new_obj_callers)})
  end

  def send_callers(%{callers: callers} = args, obj, msg) do
    Enum.map(Map.get(callers, obj, MapSet.new()), fn caller -> send self(), {msg, caller} end)
    loop(args)
  end
end

defmodule LV do
  def start_link(name) do
    Task.start_link(fn -> loop(name) end)
  end

  defp loop(name) do
    receive do
      v ->
        IO.inspect(v, label: name)
        loop(name)
    end
  end
end
