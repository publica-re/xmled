defmodule Book do
  def templates(), do: [
        %{
          matches: :root,
          parameters: %{books: %{object: :children, filter: %{name: :book}}},
          render: [{:apply_templates, :books}]
        },
        %{
          matches: %{node: :book, parent: :bookstore},
          parameters: %{title: %{object: :children, filter: %{name: :title}}, comments: %{object: :children, filter: %{name: :comments}}},
          render: ["<h1>",{:render, :title},"</h1>","<ul>",{:render, :comments},"</ul>"]
        },
        %{
          matches: %{node: :comments},
          parameters: %{comments: %{object: :children, filter: %{name: :userComment}}},
          render: [{:render, :comments}]
        },
        %{
          matches: %{node: :userComment},
          parameters: %{children: %{object: :children}},
          render: ["<li>",{:render, :children},"</li>"]
        }
      ]
end
