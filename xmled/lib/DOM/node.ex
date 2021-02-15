defmodule XMLed.DOM.Node do
  use GenServer
  use EnumType

  alias XMLed.DOM.Node, as: Node

  require Extension
  Extension.expandable 

  @enforce_keys []
  defstruct [
    :attributes,
    :baseURI,
    :lastChild,
    :ownerDocument,
    :parentNode,
    :previousSibling
  ]

  # https://www.w3.org/TR/2004/REC-DOM-Level-3-Core-20040407/core.html#ID-1950641247

  defenum NodeType do
    value ELEMENT_NODE, 1
    value ATTRIBUTE_NODE, 2
    value TEXT_NODE, 3
    value CDATA_SECTION_NODE, 4
    value ENTITY_REFERENCE_NODE, 5
    value ENTITY_NODE, 6
    value PROCESSING_INSTURCTION_NODE, 7
    value COMMENT_NODE, 8
    value DOCUMENT_NODE, 9
    value DOCUMENT_TYPE_NODE, 10
    value DOCUMENT_FRAGMENT_NODE, 11
    value NOTATION_NODE, 12

    def from(1), do: NodeType.ELEMENT_NODE
    def from(2), do: NodeType.ATTRIBUTE_NODE
    def from(3), do: NodeType.TEXT_NODE
    def from(4), do: NodeType.CDATA_SECTION_NODE
    def from(5), do: NodeType.ENTITY_REFERENCE_NODE
    def from(6), do: NodeType.ENTITY_NODE
    def from(7), do: NodeType.PROCESSING_INSTURCTION_NODE
    def from(8), do: NodeType.COMMENT_NODE
    def from(9), do: NodeType.DOCUMENT_NODE
    def from(10), do: NodeType.DOCUMENT_TYPE_NODE
    def from(11), do: NodeType.DOCUMENT_FRAGMENT_NODE
    def from(12), do: NodeType.NOTATION_NODE
  end

  defenum DocumentPosition do
    value DOCUMENT_POSITION_DISCONNECTED, 0x01
    value DOCUMENT_POSITION_PRECEDING, 0x02
    value DOCUMENT_POSITION_FOLLOWING, 0x04
    value DOCUMENT_POSITION_CONTAINS, 0x08
    value DOCUMENT_POSITION_CONTAINED_BY, 0x10
    value DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC, 0x20

    def from(0x01), do: DocumentPosition.DOCUMENT_POSITION_DISCONNECTED
    def from(0x02), do: DocumentPosition.DOCUMENT_POSITION_PRECEDING
    def from(0x04), do: DocumentPosition.DOCUMENT_POSITION_FOLLOWING
    def from(0x08), do: DocumentPosition.DOCUMENT_POSITION_CONTAINS
    def from(0x10), do: DocumentPosition.DOCUMENT_POSITION_CONTAINED_BY
    def from(0x20), do: DocumentPosition.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC
  end

  def nodeName([for: target]) do
    GenServer.call(target, :node_name)
  end
  def nodeValue(newValue \\ nil, opts)
  def nodeValue([for: target], _any), do: GenServer.call(target, :node_value)
  def nodeValue(newValue, [for: target]), do: GenServer.call(target, {:node_value, newValue})
  def nodeType([for: target]), do: GenServer.call(target, :node_type)
  def parentNode([for: target]), do: GenServer.call(target, :parent_node)
  def childNodes([for: target]), do: GenServer.call(target, :child_nodes)
  def firstChild([for: target]), do: GenServer.call(target, :first_child)
  def lastChild([for: target]), do: GenServer.call(target, :last_child)
  def previousSibling([for: target]), do: GenServer.call(target, :previous_sibling)
  def nextSibling([for: target]), do: GenServer.call(target, :next_sibling)
  def attributes([for: target]), do: GenServer.call(target, :attributes)
  def ownerDocument([for: target]), do: GenServer.call(target, :owner_document)
  def insertBefore(newChild, refChild, [for: target]), do: GenServer.call(target, {:insert_before, newChild, refChild})
  def replaceChild(newChild, oldChild, [for: target]), do: GenServer.call(target, {:replace_child, newChild, oldChild})
  def removeChild(oldChild, [for: target]), do: GenServer.call(target, {:remove_child, oldChild})
  def appendChild(newChild, [for: target]), do: GenServer.call(target, {:append_child, newChild})
  def hasChildNodes([for: target]), do: GenServer.call(target, :has_child_nodes)
  def cloneNode(deep, [for: target]), do: GenServer.call(target, {:clone_node, deep})
  def normalize([for: target]), do: GenServer.call(target, :normalize)
  def isSupported(feature, version, [for: target]), do: GenServer.call(target, {:is_supported, feature, version})
  def namespaceURI([for: target]), do: GenServer.call(target, :namespace_URI)
  def prefix(newPrefix \\ nil, opts)
  def prefix([for: target], _any), do: GenServer.call(target, :prefix)
  def prefix(newPrefix, [for: target]), do: GenServer.call(target, {:prefix, newPrefix})
  def localName([for: target]), do: GenServer.call(target, :local_name)
  def hasAttributes([for: target]), do: GenServer.call(target, :has_attributes)
  def baseURI([for: target]), do: GenServer.call(target, :base_URI)
  def compareDocumentPression(other, [for: target]), do: GenServer.call(target, {:compare_document_position, other})
  def textContent(newTextContent \\ nil, opts)
  def textContent([for: target], _any), do: GenServer.call(target, :text_content)
  def textContent(newTextContent, [for: target]), do: GenServer.call(target, {:text_content, newTextContent})
  def isSameNode(other, [for: target]), do: GenServer.call(target, {:is_same_node, other})
  def lookupPrefix(namespaceURI, [for: target]), do: GenServer.call(target, {:lookup_prefix, namespaceURI})
  def isEqualNode(arg, [for: target]), do: GenServer.call(target, {:is_equal_node, arg})
  def getFeature(feature, version, [for: target]), do: GenServer.call(target, {:get_feature, feature, version})
  def setUserData(key, data, handler \\ nil, opts)
  def setUserData(key, data, [for: target], _any), do: GenServer.call(target, {:set_user_data, key, data, nil})
  def setUserData(key, data, handler, [for: target]), do: GenServer.call(target, {:set_user_data, key, data, handler})
  def getUserData(key, [for: target]), do: GenServer.call(target, {:get_user_data, key})
  def internal_set(key, data, [for: target]), do: GenServer.call(target, {:set, key, data})

  def start_link(args, opts \\ []), do: GenServer.start_link(__MODULE__, args, opts)

  @impl true
  def init(%{} = node), do: {:ok, node}

  @impl true
  # def handle_call(:node_name, _from, node), do: {:reply, {:error, DOMException.Code.NOT_SUPPORTED_ERR }, node}
  # def handle_call(:node_value, _from, node), do:
  # def handle_call({:node_value, newValue}, _from, node), do:
  # def handle_call(:node_type, _from, node), do:
  def handle_call(:parent_node, _from, node), do: {:reply, {:ok,  Map.get(node, :parentNode, nil)}, node} 
  def handle_call(:child_nodes, _from, node) do
    lastChild = Map.get(node, :lastChild, nil)

    children =
      Stream.iterate(0, &(&1))
      |> Stream.transform({:ok, lastChild}, fn _, last ->
        case last do
          {:ok, pid} when is_pid(pid) -> {[pid], Node.previousSibling for: pid}
          _ -> {:halt,last}
        end
      end)
      |> Enum.reverse()
    {:reply, {:ok, children}, node} 
  end
  # def handle_call(:first_child, _from, node), do:
  # def handle_call(:last_child, _from, node), do:
  def handle_call(:previous_sibling, _from, node), do: {:reply, {:ok,  Map.get(node, :previousSibling, nil)}, node} 
  # def handle_call(:next_sibling, _from, node), do:
  # def handle_call(:attributes, _from, node), do: {:ok, nil}
  # def handle_call(:owner_document, _from, node), do:
  # def handle_call({:insert_before, newChild, refChild}, _from, node), do:
  # def handle_call({:replace_child, newChild, oldChild}, _from, node), do:
  def handle_call({:remove_child, oldChild}, _from, node) do
    {:reply, {:ok, oldChild}, remove_child_helper(node, oldChild)}
  end
  def remove_child_helper(parent, node) do
    lastChild = Map.get(parent, :lastChild, nil)
    {:ok, nodePreviousSibling} = Node.previousSibling for: node
    if lastChild == node do
      Map.put(parent, :lastChild, nodePreviousSibling)
    else
      Stream.iterate(0, &(&1))
      |> Stream.transform(lastChild, fn _, last ->
        case Node.previousSibling for: last do
          {:ok, ^node} ->
            Node.internal_set :previousSibling, nodePreviousSibling, for: last
            {:halt, nil}
          {:ok, pid} when is_pid(pid) -> {[], pid}
          _ -> {:halt, nil}
        end
      end)
      |> Stream.run()
      parent
    end
  end
  def handle_call({:append_child, newChild}, _from, node) do
    lastChild = Map.get(node, :lastChild, nil)
    if newChild != lastChild do
      {:ok, oldParent} = Node.parentNode for: newChild
      if oldParent != nil do
        if oldParent != self() do
          Node.removeChild newChild, for: oldParent
        else
        node = remove_child_helper(node, newChild)
        end
      end
      Node.internal_set :parentNode, self(), for: newChild
      Node.internal_set :previousSibling, lastChild, for: newChild
      {:reply, {:ok, newChild}, Map.put(node, :lastChild, newChild)}
    else
      {:reply, {:ok, newChild}, node}
    end
  end
  # def handle_call(:has_child_nodes, _from, node), do:
  # def handle_call({:clone_node, deep}, _from, node), do:
  # def handle_call(:normalize, _from, node), do:
  # def handle_call({:is_supported, feature, version}, _from, node), do:
  # def handle_call(:namespace_URI, _from, node), do:
  # def handle_call(:prefix, _from, node), do:
  # def handle_call({:prefix, newPrefix}, _from, node), do:
  # def handle_call(:local_name, _from, node), do:
  # def handle_call(:has_attributes, _from, node), do:
  # def handle_call(:base_URI, _from, node), do:
  # def handle_call({:compare_document_position, other}, _from, node), do:
  # def handle_call(:text_content, _from, node), do:
  # def handle_call({:text_content, newTextContent}, _from, node), do:
  # def handle_call({:is_same_node, other}, _from, node), do:
  # def handle_call({:lookup_prefix, namespaceURI}, _from, node), do:
  # def handle_call({:is_equal_node, arg}, _from, node), do:
  # def handle_call({:get_feature, feature, version}, _from, node), do:
  # def handle_call({:set_user_data, key, data, handler}, _from, node), do:
  # def handle_call({:get_user_data, key}, _from, %__MODULE__{userData} = node), do: {:reply, Map.fetch!(userData, key), node}
  def handle_call({:set, key, data}, _from, node) do
    {:reply, :ok, Map.put(node, key, data)}
  end
  def handle_call(_call, _from, node), do: {:reply, {:error, DOMException.Code.NOT_SUPPORTED_ERR }, node}
end
