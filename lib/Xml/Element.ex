defmodule Xml.Element do
  require Xml.Node
  import Xml.Node
  def start_link(table, element, parent) do
    id = insert_node!(table, parse(table, element, parent))
    Task.start_link(__MODULE__, :loop, [%{table: table, id: id, callers: %{}}])
  end

  def parse(table, {:xmlElement, name, expanded_name, nsinfo, namespace, _parents, pos, attributes, children, _language, _xmlbase, _elementdef}, parent) do
    %{
      name: name,
      expanded_name: expanded_name,
      nsinfo: nsinfo,
      namespace: namespace,
      parent: parent,
      position: pos,
      attributes: Enum.map(attributes, fn attribute -> elem(Xml.Attribute.start_link(table, attribute, self()),1) end),
      children: Enum.map(children, fn child ->
        case elem(child, 0) do
          :xmlText -> elem(Xml.Text.start_link(table, child, self()), 1)
          :xmlElement -> elem(Xml.Element.start_link(table, child, self()), 1)
        end
      end),
    }
  end

  def loop(%{table: table, id: id} = state) do
    element = retrieve_node!(table, id)
    receive do
      %{action: :get, object: :name, payload: payload} = request ->
        respond(payload, Map.get(element, :name))
        add_listener(:name, request)
      %{action: :set, object: :name, value: value} ->
        update_node!(table, id, Map.put(element, :name, value))
        dispatch_change(:name)
      %{action: :get, object: :position, payload: payload} = request ->
        respond(payload, Map.get(element, :position))
        add_listener(:position, request)
      %{action: :set, object: :position, value: value} ->
        update_node!(table, id, Map.put(element, :position, value))
        dispatch_change(:position)
      %{action: :get, object: :children, filter: filter, payload: payload} = request ->
        children = Enum.map(Map.get(element, :children), fn child -> {child, Map.new(Map.keys(filter), fn x -> {x, nil} end)} end)
        send self(), %{action: :mixed, object: :children, filter: filter, result: children, payload: payload}
        add_listener(:children, request)
      %{action: :get, object: :attributes, filter: filter, payload: payload} = request ->
        attributes = Enum.map(Map.get(element, :attributes), fn child -> {child, Map.new(Map.keys(filter), fn x -> {x, nil} end)} end)
        send self(), %{action: :mixed, object: :attributes, filter: filter, result: attributes, payload: payload}
        add_listener(:attributes, request)
      %{action: :templates, templates: [template | rt], payload: payload} = request ->
        matches = Map.get(template, :matches, %{})
        parameters = Map.get(request, :parameters, %{})
        cond do
          matches == :root and Map.get(element, :parent, nil) == nil ->
            respond(payload, template)
          true ->
            send self(), %{action: :templates, templates: rt, payload: payload}
        end
        %{action: :mixed, object: :children, filter: filter, result: children, payload: payload} ->
          case Enum.map(children, fn {child, filters} -> {child, Enum.filter(filters, fn {_, v} -> v == nil end)} end)
               |> Enum.find(nil, fn {_, filters} -> length(filters) > 0 end) do
            {child, [{f, _} | _]} ->
              send child,
                   %{action: :get, object: f, payload: { self(), fn fv -> %{action: :mixed, object: :children, filter: filter, result: Enum.map(children, fn {c, filters} -> if c == child do {c, Map.replace!(filters, f, fv)} else {c, filters} end end), payload: payload} end}}
            nil ->
              respond(payload, Enum.filter(children, fn {_, filters} -> Enum.all?(filter, fn {f, q} -> value = Map.get(filters, f); if is_function(q) do q.(value) else q == value end end) end) |> Enum.map(fn {c, _} -> c end))
          end
          loop(state)
        %{action: :mixed, object: :attributes, filter: filter, result: attributes, payload: payload} ->
          case Enum.map(attributes, fn {child, filters} -> {child, Enum.filter(filters, fn {_, v} -> v == nil end)} end)
                |> Enum.find(nil, fn {_, filters} -> length(filters) > 0 end) do
            {child, [{f, _} | _]} ->
              send child,
                    %{action: :get, object: f, payload: { self(), fn fv -> %{action: :mixed, object: :attributes, filter: filter, result: Enum.map(attributes, fn {c, filters} -> if c == child do {c, Map.replace!(filters, f, fv)} else {c, filters} end end), payload: payload} end}}
            nil ->
              respond(payload, Enum.filter(attributes, fn {_, filters} -> Enum.all?(filter, fn {f, q} -> value = Map.get(filters, f); if is_function(q) do q.(value) else q == value end end) end) |> Enum.map(fn {c, _} -> c end))
          end
          loop(state)
      %{action: :get, object: :children, payload: payload} = request ->
        respond(payload, Map.get(element, :children))
        add_listener(:children, request)
      %{action: :get, object: :attributes, payload: payload} = request ->
        respond(payload, Map.get(element, :attributes))
        add_listener(:attributes, request)
      v ->
        IO.inspect(v, label: "UKN")
        loop(state)
    end
  end
end
