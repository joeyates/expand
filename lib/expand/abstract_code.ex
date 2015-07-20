defmodule Expand.AbstractCode do
  defp _to_string({:string, _, text}, i) when is_list(text) do
    _to_string(to_string(text), i)
  end

  defp _to_string({:bin, _, [{:bin_element, _, text, :default, :default}]}, i) do
    _to_string(text, i)
  end

  defp _to_string({:var, _, name}, i) do
    _to_string(name, i)
  end

  defp _to_string({:atom, _, name}, i) do
    _to_string(name, i)
  end

  defp _to_string({:cons, line1, name, cons}, i) do
    _to_string(_cons_dump({:cons, line1, name, cons}), i)
  end

  defp _to_string({:integer, _, value}, i) do
    _to_string(value, i)
  end

  defp _to_string({:op, _, :"=:=", i1, i2}, i) do
    _in(i) <> "(\n" <>
    _to_string(i1, i) <> "\n" <>
    _in(i) <> "==\n" <>
    _to_string(i2, i) <> "\n" <>
    _in(i) <> ")"
  end

  defp _to_string({:op, _, :orelse, alt1, alt2}, i) do
    _to_string(alt1, i) <> "\n" <>
    _in(i) <> "||\n" <>
    _in(i) <> "(\n" <>
    _to_string(alt2, i + 1) <> "\n" <>
    _in(i) <> ")"
  end

  defp _cons_dump({:cons, _, name, {:nil, _}}) do
    [name]
  end

  defp _cons_dump({:cons, _, name, cons}) do
    [name | _cons_dump(cons)]
  end

  use Expand.Mixin
end
