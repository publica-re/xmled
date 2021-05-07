defmodule Run do
  import Tra

  queries do
    object :y, data: %Yo{name: "yo"}
    object :z, data: %Yo{name: "na", age: 20}
  end

  render ~x"Hello {name_z}, you're {age_z}"

end
