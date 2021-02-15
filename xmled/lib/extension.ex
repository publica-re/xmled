defmodule Extension do

    defmacro expandable(yes \\ true) do
        if yes do
            quote do
                Module.register_attribute(__MODULE__, :enforce_keys, persist: true)
                Module.register_attribute(__MODULE__, :expandable, persist: true, accumulable: false)
                Module.put_attribute(__MODULE__, :expandable, true)
            end
        end
    end

    @do_not_import [__struct__: 0, __struct__: 1]

    defmacro __using__(opts \\ []) do
        module = Keyword.get(opts, :inherit, [])
        module = Macro.expand(module, __CALLER__)
        if Keyword.get(module.__info__(:attributes), :expandable, []) == [true] do
            except = Keyword.get(opts, :except, [])
            struct = Keyword.get(opts, :struct, [])
            enforce_keys = Keyword.get(opts, :enforce_keys, [])
            functions =
                module.__info__(:functions) 
                |> Enum.filter(fn fun -> not (Enum.member?(except, fun) or Enum.member?(@do_not_import, fun)) end)
            signatures =
                functions
                    |> Enum.map(
                    fn {name, arity} ->
                        args =
                            if arity == 0 do []
                            else Enum.map 1..arity, fn(i) -> {String.to_atom(<< ?x, ?A + i - 1 >>), [], nil} end
                        end
                        {name, [], args}
                    end)
            zipped = List.zip([signatures, functions])
            Enum.concat([
                for sig_func <- zipped do
                    quote do
                        defdelegate unquote(elem(sig_func, 0)), to: unquote(module)
                        defoverridable unquote([elem(sig_func, 1)])
                    end
                end,
                [
                    if enforce_keys != :no do
                        new_enforced_keys = enforce_keys ++ Keyword.get(module.__info__(:attributes), :enforce_keys, [])
                        quote do
                            Module.put_attribute(__MODULE__, :enforce_keys, unquote(new_enforced_keys))
                        end
                    end,
                    if struct != :no do
                        new_struct =
                            (if Enum.member?(module.__info__(:functions), {:__struct__, 0}) do module.__struct__ else %{} end)
                            |> Map.to_list
                            |> Enum.filter(fn {name, _} -> name != :__struct__ end)
                            |> Keyword.merge(struct |> Enum.map(fn x -> case x do {a, b} -> {a, b}; v -> {v, nil} end end))
                        if length(new_struct) > 0 do
                            quote do
                                defstruct unquote(new_struct)
                            end
                        end
                    end
                ]
            ])
            else
                raise "module #{module} is not flagged as expandable"
            end
    end
end