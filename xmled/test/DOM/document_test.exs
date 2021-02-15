defmodule XMLedTest.DOM.Document do
    use ExUnit.Case, async: true
    alias XMLed.DOM.Document, as: Document
    alias XMLed.DOM.Node, as: Node
  
    setup do
      %{
        document: start_supervised!(%{id: Doc, start: {Document, :start_link, [%{qualifiedName: "yo", namespaceURI: "yo", doctype: "sh"}]}}),
      }
    end
  
    test "XMLed.DOM.Document.nodeName/0 returns the correct name", %{document: pid} do
       assert (Document.nodeName for: pid) == {:ok, :document}
    end

    test "XMLed.Node" do
        {:ok, root} = Node.start_link(%{})
        {:ok, child} = Node.start_link(%{})
        {:ok, child2} = Node.start_link(%{})
        {:ok, child3} = Node.start_link(%{})
        {:ok, child4} = Node.start_link(%{})
        Node.appendChild child, for: root
        Node.appendChild child2, for: root
        Node.appendChild child3, for: root
        Node.appendChild child4, for: root
        Node.appendChild child4, for: root
        {:ok, children} = Node.childNodes for: root
        IO.inspect(children, label: "children")
        assert (length(children)) == 4
    end
  end
  