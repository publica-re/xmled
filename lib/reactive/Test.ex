defmodule Reactive.Test do
    use Reactive.Component

    render do
        Map.get(props, :opts)
    end
end