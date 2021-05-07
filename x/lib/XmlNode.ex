defmodule XmlNode do
  def insert_node(table, node) do
    id = :rand.uniform(20000) |> to_string() |> String.to_atom()
    :ets.insert(table, {id, node})
    id
  end
end
