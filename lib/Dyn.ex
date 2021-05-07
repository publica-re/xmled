defmodule Dyn do
  defmacro __using__(_opts) do
    quote do
      def start_link(obj) do
        Task.start_link(__MODULE__, :loop, [obj])
      end

      def loop(state) do
        receive do
          {:recv, key, c, d} ->
            send d, {c, Map.get(state, key)}
            loop(state)
          {:update, newobj} ->
            send self(), {:updated, newobj}
            loop(Map.merge(state, newobj))
          v ->
            IO.inspect(v, label: __MODULE__)
            loop(state)
        end
      end

      def {a, b} ~> {c, d} when is_pid(b) do
        send b, {:recv, a, c, d}
      end

      def b <~ a when is_pid(b) do
        send b, {:update, a}
      end
    end
  end
end
