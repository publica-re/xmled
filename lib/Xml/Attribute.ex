defmodule Xml.Attribute do
  require Xml.Node
  import Xml.Node
  def start_link(table, element, parent) do
    id = insert_node!(table, parse(table, element, parent))
    Task.start_link(__MODULE__, :loop, [%{table: table, id: id, callers: %{}}])
  end

  def parse(_table, {:xmlAttribute, name, expanded_name, nsinfo, namespace, _parents, pos, _language, value, _normalized}, parent) do
    %{
      name: name,
      expanded_name: expanded_name,
      nsinfo: nsinfo,
      namespace: namespace,
      parent: parent,
      position: pos,
      value: value,
    }
  end

  def loop(%{table: table, id: id} = state) do
    element = retrieve_node!(table, id)
    receive do
      {:get_name, payload} = request ->
        respond(payload, Map.get(element, :name))
        add_listener(:name, request)
      {:set_name, value} ->
        update_node!(table, id, Map.put(element, :name, value))
        dispatch_change(:name)
    end
  end
end
