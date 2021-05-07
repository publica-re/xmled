defmodule Reactive.Main do
    use Reactive.Component

    state_from_props do: %{
            greetings: "Hello " <> Map.get(props, :name) <> "!"
        }

    render do
        component Reactive.Test, :test, opts: :swag
        IO.inspect(components)
        :swag
    end
end