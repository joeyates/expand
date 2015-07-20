defmodule ExpandTest do
  use ExUnit.Case
  alias Expand

  test ".it pretty prints strings" do
    assert Expand.it("hello") == "\"hello\""
  end

  test ".it pretty prints binaries" do
    assert Expand.it(<<55, 128>>) == "<<55, 128>>"
  end

  test ".it pretty prints atoms" do
    assert Expand.it(:atom) == ":atom"
  end

  test ".it pretty prints bitstrings" do
    assert Expand.it(<<15::size(4)>>) == "<<15::size(4)>>"
  end

  test ".it pretty prints booleans" do
    assert Expand.it(true) == "true"
  end

  test ".it pretty prints lists" do
    assert Expand.it([1, 2, 3]) == "[\n  1,\n  2,\n  3\n]"
  end

  test ".it pretty prints keyword lists" do
    assert Expand.it([a: 1, b: 2]) == "[\n  a:\n    1,\n  b:\n    2\n]"
  end

  test ".it pretty prints atom-keyed maps" do
    assert Expand.it(%{a: 1, b: 2}) == "%{\n  a:\n    1,\n  b:\n    2\n}"
  end

  test ".it pretty prints non-atom-keyed maps" do
    assert Expand.it(%{"a" => 1, "b" => 2}) == "%{\n  \"a\" =>\n    1,\n  \"b\" =>\n    2\n}"
  end

  test ".it pretty prints tuples" do
    assert Expand.it({1, 2}) == "{\n  1,\n  2\n}"
  end
end
