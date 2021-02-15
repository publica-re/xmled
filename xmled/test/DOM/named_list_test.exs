defmodule XMLedTest.DOM.NamedList do
  use ExUnit.Case, async: true
  alias XMLed.DOM.NamedList, as: NamedList

  setup do
    %{
      empty_list: start_supervised!(%{id: EmptyNamedList, start: {NamedList, :start_link, [[]]}}),
      nonempty_list:
        start_supervised!(
          %{
            id: NonEmptyNamedList,
            start: {
              NamedList,
              :start_link,
              [%{items: [
                  %{name: "browser", namespaceURI: "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"},
                  %{name: "starting", namespaceURI: "https://samuelmullen.com/articles/elixir-processes-testing/"}
                ]}]}
           }
        )
    }
  end

  test "XMLed.DOM.NamedList.length/0 returns 0 on an empty list", %{empty_list: pid} do
    assert (NamedList.length for: pid) == 0
  end

  test "XMLed.DOM.NamedList.length/0 returns non-zero on a non-empty list", %{nonempty_list: pid} do
    assert (NamedList.length for: pid) > 0
  end

  test "XMLed.DOM.NamedList.getName/1 finds the correct item", %{nonempty_list: pid} do
    assert (NamedList.getName 0, for: pid) == "browser"
  end

  test "XMLed.DOM.NamedList.getNamespaceURI/1 finds the correct item", %{nonempty_list: pid} do
    assert (NamedList.getNamespaceURI 0, for: pid) == "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
  end

  test "XMLed.DOM.NamedList.contains/1 finds an item", %{nonempty_list: pid} do
    assert (NamedList.contains "browser", for: pid) == true
  end

  test "XMLed.DOM.NamedList.contains/1 does not find a missing item", %{nonempty_list: pid} do
    assert (NamedList.contains "brwoser", for: pid) == false
  end

  test "XMLed.DOM.NamedList.containsNS/1 finds an item", %{nonempty_list: pid} do
    assert (NamedList.containsNS "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul", "browser", for: pid) == true
  end

  test "XMLed.DOM.NamedList.containsNS/1 finds an item with incorrect NS", %{nonempty_list: pid} do
    assert (NamedList.containsNS "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xulx", "browser", for: pid) == false
  end

  test "XMLed.DOM.NamedList.containsNS/1 finds an item with incorrect name", %{nonempty_list: pid} do
    assert (NamedList.containsNS "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul", "brwoser", for: pid) == false
  end
end
