defmodule XmledTest do
  use ExUnit.Case

  test "greets the world" do
    {:ok, pid} = Reactive.Main.start_link(%{name: "Marcel"})
    assert GenServer.call(pid, :render) == :swag
  end
end
