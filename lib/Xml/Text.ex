defmodule Xml.Text do
  require Xml.Node
  import Xml.Node
  def start_link(table, element, parent) do
    id = insert_node!(table, parse(table, element, parent))
    Task.start_link(__MODULE__, :loop, [%{table: table, id: id, callers: %{}}])
  end

  def parse(_table, {:xmlText, _parents, pos, _language, value, _type}, parent) do
    %{
      parent: parent,
      position: pos,
      value: value,
    }
  end

  @spec loop(%{:id => any, :table => atom | :ets.tid(), optional(any) => any}) :: no_return
  def loop(%{table: table, id: id} = state) do
    element = retrieve_node!(table, id)
    receive do
      %{action: :get, object: :value, payload: payload} =  request->
        respond(payload, Map.get(element, :value))
        add_listener(:value, request)
      %{action: :get, object: :set, value: value} ->
        update_node!(table, id, Map.put(element, :value, value))
        dispatch_change(:value)
      %{action: :get, object: :position, payload: payload} = request ->
        respond(payload, Map.get(element, :position))
        add_listener(:position, request)
      %{action: :set, object: :position, value: value} ->
        update_node!(table, id, Map.put(element, :position, value))
        dispatch_change(:position)
      %{action: :get, object: :name, payload: payload} ->
        respond(payload, :"#text")
        loop(state)
      v ->
        IO.inspect(v, label: "nope")
        loop(state)
    end
  end
end
