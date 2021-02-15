defmodule XMLed.DOM.DOMException do
  use EnumType


  # https://www.w3.org/TR/2004/REC-DOM-Level-3-Core-20040407/core.html#ID-17189187

  defenum Code do
    value INDEX_SIZE_ERR, 1
    value DOMSTRING_SIZE_ERR, 2
    value HIERARCHY_REQUEST_ERR, 3
    value WRONG_DOCUMENT_ERR, 4
    value INVALID_CHARACTER_ERR, 5
    value NO_DATA_ALLOWED_ERR, 6
    value NO_MODIFICATION_ALLOWED_ERR, 7
    value NOT_FOUND_ERR, 8
    value NOT_SUPPORTED_ERR, 9
    value INUSE_ATTRIBUTE_ERR, 10
    value INVALID_STATE_ERR, 11
    value SYNTAX_ERR, 12
    value INVALID_MODIFICATION_ERR, 13
    value NAMESPACE_ERR, 14
    value INVALID_ACCESS_ERR, 15
    value VALIDATION_ERR, 16
    value TYPE_MISMATCH_ERR, 17
  end

  def from(1), do: Code.INDEX_SIZE_ERR
  def from(2), do: Code.DOMSTRING_SIZE_ERR
  def from(3), do: Code.HIERARCHY_REQUEST_ERR
  def from(4), do: Code.WRONG_DOCUMENT_ERR
  def from(5), do: Code.INVALID_CHARACTER_ERR
  def from(6), do: Code.NO_DATA_ALLOWED_ERR
  def from(7), do: Code.NO_MODIFICATION_ALLOWED_ERR
  def from(8), do: Code.NOT_FOUND_ERR
  def from(9), do: Code.NOT_SUPPORTED_ERR
  def from(10), do: Code.INUSE_ATTRIBUTE_ERR
  def from(11), do: Code.INVALID_STATE_ERR
  def from(12), do: Code.SYNTAX_ERR
  def from(13), do: Code.INVALID_MODIFICATION_ERR
  def from(14), do: Code.NAMESPACE_ERR
  def from(15), do: Code.INVALID_ACCESS_ERR
  def from(16), do: Code.VALIDATION_ERR
  def from(17), do: Code.TYPE_MISMATCH_ERR
end
