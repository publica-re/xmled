defmodule Reactive.React do
    defmacro defreactive(opts, do: op) do
        name = elem(opts, 0)
        handle_name = String.to_atom("reactive_handle_" <> Atom.to_string name)
        handle_opts = put_elem(opts, 0, handle_name)
        [line: line] = elem(opts, 1)
        args = elem(opts, 2)
        new_args = [{:pid, [line: line], nil} | args]
        new_opts = put_elem(opts, 2, new_args)
        
        quote do
            def unquote(new_opts) do
                pid = Keyword.get binding(), :pid
                args = Keyword.delete binding(), :pid
                GenServer.call(pid, {unquote(name), args |> Keyword.values})
            end

            def unquote(opts) do
                apply(__MODULE__, unquote(handle_name), binding() |> Keyword.values)
            end

            def unquote(handle_opts), do: unquote(op)

            def handle_call({unquote(name), args}, from, state) do
                {:reply, apply(__MODULE__, unquote(handle_name), args), state}
            end
        end
    end
end