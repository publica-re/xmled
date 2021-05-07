
defmodule Transformer.Transform do
  def start_link(node, listener, templates) do
    state = Map.merge(get_initial_state(node, templates), %{listener: listener})
    Task.start_link(__MODULE__, :initialize, [state])
  end

  def get_initial_state(node, templates) do
    send node, %{action: :template, templates: templates}
    receive do
      {:template, %{parameters: parameters, render: render}} -> %{node: node, parameters: parameters, values: Map.new(Map.keys(parameters), &{&1, nil}), render: render, pool: %{}}
      v -> IO.inspect(v)
    end
  end

  def loop(%{values: values, render: render, pool: pool, parameters: parameters} = state) do
    render(state)
    receive do
      {:parameter, p_name, msg} ->
        if Enum.any?(Keyword.values(render), &(&1 == p_name)) do
          send self(), {:render, p_name}
        end
        loop(%{state | values: Map.put(values, p_name, msg)})
      {:render, p_name} ->
        Enum.map(
          Map.get(values, p_name),
          fn node ->
            if not Map.has_key?(pool, node) do
              Map.put(pool, node, Transformer.Transform.start_link(node, parameters, render))
            end
          end)
        IO.inspect(pool)
      v ->
        IO.inspect(v, label: "UKN")
        loop(state)
    end
  end

  def initialize(%{node: node, parameters: parameters} = state) do
    Enum.map(parameters, fn {p_name, p_query} -> (send node, Map.merge(%{action: :get, payload: {self(), &{:parameter, p_name, &1}}}, p_query)) end)
    loop(state)
  end

  defp render(state) do
    IO.inspect(state)
  end
end
