defmodule Xml.Node do
  def gen_id(), do: :rand.uniform(20000) |> to_string() |> String.to_atom()

  def insert_node!(table, node) do
    id = gen_id()
    :ets.insert(table, {id, node})
    id
  end

  def retrieve_node!(table, id), do: (case :ets.lookup(table, id), do: ([{^id, element}] -> element))

  def update_node!(table, id, node), do: :ets.insert(table, {id, node})

  defmacro respond(payload, msg) do
    quote do
      {caller, response} = unquote(payload)
      send caller, response.(unquote(msg))
    end
  end

  defmacro add_listener(signal, request) do
    quote do
      state = var!(state)
      callers = Map.get(state, :callers, %{})
      for_this_signal = Map.get(callers, unquote(signal), MapSet.new())
      loop(%{state | callers: Map.put(callers, unquote(signal), MapSet.put(for_this_signal, unquote(request)))})
    end
  end

  defmacro dispatch_change(signal) do
    quote do
      state = var!(state)
      callers = Map.get(state, :callers)
      Enum.map(Map.get(callers, unquote(signal), MapSet.new()), fn request -> send self(), request end)
      loop(state)
    end
  end
end
