defmodule ExpandAbstractCodeTest do
  use ExUnit.Case
  alias Expand.AbstractCode

  test ".it pretty prints abstract_code strings" do
    assert AbstractCode.it({:string, 3, 'hello'}) == "\"hello\""
  end

  test ".it pretty prints abstract_code bin_elements" do
    assert AbstractCode.it({:bin, 4, [{:bin_element, 5, "hello", :default, :default}]}) == "\"hello\""
  end

  test ".it pretty prints abstract_code vars" do
    assert AbstractCode.it({:var, 1, :_}) == ":_"
  end

  test ".it pretty prints abstract_code atoms" do
    assert AbstractCode.it({:atom, 1, :ciao}) == ":ciao"
  end

  test ".it pretty prints abstract_code integers" do
    assert AbstractCode.it({:integer, 1, 42}) == "42"
  end

  test ".it pretty prints abstract_code conses" do
    assert AbstractCode.it({:cons, 1, :ciao, {:nil, 1}}) == "[\n  :ciao\n]"
  end

  test ".it pretty prints abstract_code equals ops" do
    assert AbstractCode.it({:op, 1, :"=:=", :_@1, "y"}) == "(\n:_@1\n==\n\"y\"\n)"
  end

  test ".it pretty prints abstract_code orelse ops" do
    assert AbstractCode.it({:op, 1, :orelse, :_@1, "y"}) == ":_@1\n||\n(\n  \"y\"\n)"
  end
end
