defmodule KV do
  def start_link do
    Task.start_link(__MODULE__, :loop, [%{value: "yo", callers: []}])
  end

  def loop(map) do
    receive do
      {:get_text, caller} ->
        send caller, {:value, Map.get(map, :value)}
        loop(%{map | callers: [caller | Map.get(map, :callers, [])]})
      {:set_text, value} ->
        Enum.map(Map.get(map, :callers), fn caller -> send caller, {:new_value, value} end)
        loop(%{map | value: value})
    end
  end
end

defmodule LV do
  def start_link do
    Task.start_link(fn -> loop(%{value: nil}) end)
  end

  defp loop(map) do
    IO.inspect(map, label: "LV")
    receive do
      {:value, value} ->
        IO.inspect(value, label: "LV: initial value")
        loop(%{map | value: value})
      {:new_value, value} ->
        IO.inspect(value, label: "LV: new value")
        loop(%{map | value: value})
    end
  end
end


{:ok, kpid} = KV.start_link
{:ok, mpid} = KV.start_link
{:ok, lpid} = LV.start_link
IO.inspect([kpid, lpid])
send kpid, {:get_text, lpid}
:timer.sleep(1000)
send kpid, {:set_text, "world"}
send mpid, {:set_text, "patate"}
