defmodule Tra do
  defmacro render(lst) do
    quote do
      Module.register_attribute(__MODULE__, :render, accumulate: false, persist: true)
      Module.put_attribute(__MODULE__, :render, unquote(lst))
    end
  end

  def sigil_x(binary, []) do
    Tpl.parse(binary)
  end

  defmacro queries(do: f) do
    quote do
      Module.register_attribute(__MODULE__, :opts, accumulate: true)
      unquote(f)
      IO.inspect(Module.get_attribute(__MODULE__, :opts))
    end
  end

  defmacro object(f, g) do
    quote do
      Module.put_attribute(__MODULE__, :opts, {unquote(f), unquote(g)})
    end
  end
end
