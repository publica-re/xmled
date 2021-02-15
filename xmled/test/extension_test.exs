defmodule A do
    use GenServer

    require Extension
    Extension.expandable

    @impl true
    def init(:ok), do: {:ok, []}

    def hi(target), do: GenServer.call(target, :hi)
    
    @impl true
    def handle_call(:hi, _from, state), do: {:reply, :hello, state}
end

defmodule B do
    use GenServer

    require Extension
    use Extension,
        inherit: A,
        except: [handle_call: 3]
    
    @impl true
    def handle_call(:hi, _from, state), do: {:reply, :yo, state}
end


defmodule ABTest do
    use ExUnit.Case, async: true

    test "A ok" do
        {:ok, pid} = GenServer.start_link(A, :ok)
        assert (A.hi(pid)) == :hello
    end

    test "B ok" do
        {:ok, pid} = GenServer.start_link(B, :ok)
        assert (B.hi(pid)) == :yo
    end
end