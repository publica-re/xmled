defmodule XMLed.DOM.DOMImplementation do
  use GenServer

  alias XMLed.DOM.Document, as: Document

  @enforce_keys [:documents, :document_types]
  defstruct [:documents, :document_types]


  def createDocument(namespaceURI, qualifiedName, doctype \\ nil, opts \\ [for: __MODULE__])
  def createDocument(namespaceURI, qualifiedName, [for: target], _fail), do:
    GenServer.call(target, {:create_document, namespaceURI, qualifiedName, nil})
  def createDocument(namespaceURI, qualifiedName, doctype, [for: target]), do:
    GenServer.call(target, {:create_document, namespaceURI, qualifiedName, doctype})

  def createDocumentType(qualifiedName, publicId, systemId, [for: target] \\ [for: __MODULE__]), do:
    GenServer.call(target, {:create_document_type, qualifiedName, publicId, systemId})

  def getFeature(feature, version \\ nil, [for: target] \\ [for: __MODULE__]), do:
    GenServer.call(target, {:get_feature, feature, version})

  def hasFeature(feature, version \\ nil, [for: target] \\ [for: __MODULE__]), do:
    GenServer.call(target, {:has_feature, feature, version})

  def start_link(args, opts \\ []), do: GenServer.start_link(__MODULE__, args, opts)

  @impl true
  def init(%__MODULE__{} = source), do: {:ok, source}
  def init(_any), do: {:ok, %__MODULE__{documents: [], document_types: []}}

  @impl true
  def handle_call({:create_document, namespaceURI, qualifiedName, doctype}, _from, %__MODULE__{documents: documents} = implementation) do
    {:ok, pid} = Document.start_link(%Document{doctype: doctype})
    {:reply, pid,  %__MODULE__{implementation | documents: [pid | documents]}}
  end

end
