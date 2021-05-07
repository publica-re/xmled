defmodule CLI do
  use Application

  def start(_type, [path]) do
    Task.start(fn -> process(path) end)
  end

  def process(path) do
    # GS.Grammar.parse_from_file("plants.xml")
    #{root, _} = :xmerl_scan.file(path)
    #table = :ets.new(:element, [:ordered_set, :public])
    #{:ok, elem_pid} = Xml.Element.start_link(table, root, nil)
    #{:ok, _} = Transformer.Transform.start_link(elem_pid, self(), Book.templates)
    loop()
  end

  def loop() do
    receive do
      v ->
        IO.inspect(v, label: "main")
        loop()
    end

  end
end
