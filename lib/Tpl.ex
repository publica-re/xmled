defmodule Tpl do
    import Elixir.Combine.Parsers.Base
    import Elixir.Combine.Parsers.Text
    use Combine

    def parse(str), do: Enum.concat(Combine.parse(str, map(parse_variables(), &Enum.concat/1)))

    defp parse_variables(p \\ nil) do
      p
      |> map(sequence([many(element()), take_while(fn c -> c != nil end)]), &Enum.concat/1)
    end

    defp element(p \\ nil) do
      p
      |> map(sequence([text_group(), match_group()]), &(&1))
    end

    defp match_group(p \\ nil) do
      p
      |> map(between(char("{"), var_name(), char("}")), &{:variable, &1})
    end

    defp var_name(p \\ nil) do
      p
      |> label(word_of(~r/[\w_]+/), "variable name")
    end

    defp text_group(p \\ nil) do
      p
      |> map(take_while(fn c -> c != nil and c != 123 end), &{:string, to_string &1})
    end
end
