defmodule Reactive.Component do
    defmacro __using__(_opts) do
        quote do
            import Reactive.Component
            use GenServer

            Module.register_attribute __MODULE__, :components, accumulate: false
            Module.put_attribute __MODULE__, :components, %{}

            def init(props) do
                IO.inspect(__MODULE__.__info__(:functions))
                if Kernel.function_exported?(__MODULE__, :_state_from_props, 1) do
                    {:ok, %{state: apply(__MODULE__, :_state_from_props, [props]), props: props, components: %{}}}
                else 
                    {:ok, %{state: %{}, props: props, components: %{}}}
                end
            end

            def start_link(opts) do
                GenServer.start_link(__MODULE__, opts)
            end
        end
    end
    
    defmacro render(do: exec) do
        quote do
            def handle_call(:render, from, %{state: var!(state), props: var!(props), components: var!(components)} = ms) do
                output = unquote(exec)
                IO.inspect(binding())
                {:reply, output, var!(state)}
            end
        end
    end
    
    defmacro component(class, name, props) do
        quote do
            if not Map.has_key?(var!(components), unquote(name)) do
                case GenServer.start_link(unquote(class), unquote(props)) do
                    {:ok, pid} -> var!(components) = Map.put(var!(components), unquote(name), pid)
                    _ -> raise "nope"
                end
            end
        end
    end
    
    defmacro on(evt, do: exec) do
        quote do
            def handle_call({:render, event}, from, %{state: var!(state), props: var!(props)} = ms) do
                {:reply, unquote(exec), var!(state)}
            end
        end
    end
    
    defmacro state_from_props(do: exec) do
        quote do 
            def _state_from_props(var!(props)) do
                unquote(exec)
            end
        end
    end
end