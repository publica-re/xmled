defmodule XMLed.DOM.Document do
  use GenServer
  alias XMLed.DOM.Node, as: Node

  use Extension,
    inherit: Node,
    except: [start_link: 1, start_link: 2, handle_call: 3],
    struct: [:doctype],
    enforce_keys: [:doctype]

  @impl true
  def handle_call(:node_name, _from, node), do: {:reply, {:ok, :document}, node}
  def handle_call(msg, from, node), do: Node.handle_call(msg, from, node)

  def start_link(args, opts \\ []), do: GenServer.start_link(__MODULE__, args, opts)
end
