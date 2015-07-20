defmodule Expand.Mixin do
  defmacro __using__(_) do
    quote do
      @doc """
      Get a string representation of the supplied data structure.
      """
      def it(item, i \\ 0), do: _to_string(item, i)

      defp _to_string(item, i) when is_boolean(item) do
        _in(i) <> Atom.to_string(item)
      end

      defp _to_string(item, i) when is_atom(item) do
        _in(i) <> ":" <> Atom.to_string(item)
      end

      defp _to_string(item, i) when is_integer(item) do
        _in(i) <> Integer.to_string(item)
      end

      defp _to_string(item, i) when is_tuple(item) do
        _in(i) <> "{\n" <>
        _list_dump(Tuple.to_list(item), i + 1) <> "\n" <>
        _in(i) <> "}"
      end

      """
      Distinguish between keyword lists and other lists.
      """
      defp _to_string(item, i) when is_list(item) do
        _in(i) <> "[\n" <>
        cond do
          Keyword.keyword?(item) ->
            _keyword(item, i + 1)
          true ->
            _list_dump(item, i + 1) <>
            "\n"
        end
        <> _in(i) <> "]"
      end

      """
      If all sequences of bytes are valid UTF-8, handle
      as a string, otherwise, print out the bytes as a list.
      """
      defp _to_string(item, i) when is_binary(item) do
        cond do
          String.valid?(item) ->
            _in(i) <> "\"" <> item <> "\""
          true ->
            values = _bytes(item)
            "<<" <> _list_dump(values, i, " ") <> ">>"
        end
      end

      defp _to_string(item, i) when is_bitstring(item) do
        size = bit_size(item)
        <<value::size(size)>> = item

        _in(i) <> "<<" <>
        Integer.to_string(value) <>
        "::size(" <> Integer.to_string(size) <> ")>>"
      end

      """
      If all keys are atoms, use the specific syntax.
      """
      defp _to_string(item, i) when is_map(item) do
        list = Map.to_list(item)
        if Keyword.keyword?(list) do
          _in(i) <> "%{\n" <>
          _keyword(list, i + 1) <>
          _in(i) <> "}"
        else
          _in(i) <> "%{\n" <>
          _map(list, i + 1) <>
          _in(i) <> "}"
        end
      end

      defp _list_dump(list, i, sep \\ "\n")

      defp _list_dump([head], i, sep) do
        _to_string(head, i)
      end

      defp _list_dump([head | tail], i, sep) do
        _to_string(head, i) <> "," <> sep <> _list_dump(tail, i, sep)
      end

      defp _keyword_pair({k, v}, i) do
        _in(i) <> Atom.to_string(k) <> ":\n" <> _to_string(v, i + 1)
      end

      defp _keyword([head], i) do
        _keyword_pair(head, i) <> "\n"
      end

      defp _keyword([head | tail], i) do
        _keyword_pair(head, i) <> ",\n" <> _keyword(tail, i)
      end

      defp _keyword([], i) do
        ""
      end

      defp _map_pair({k, v}, i) do
        _to_string(k, i) <> " =>\n" <> _to_string(v, i + 1)
      end

      defp _map([head], i) do
        _map_pair(head, i) <> "\n"
      end

      defp _map([head | tail], i) do
        _map_pair(head, i) <> ",\n" <> _map(tail, i)
      end

      defp _bytes(<<h :: size(8)>> <> t) do
        [h | _bytes(t)]
      end

      defp _bytes(<<>>) do
        []
      end

      """
      indent
      """
      defp _in(0) do
        ""
      end

      defp _in(i) do
        "  " <> _in(i - 1)
      end
    end
  end
end

defmodule Expand do
  @moduledoc """
  Get pretty-printed output for Elixir data structures.
  """

  use Expand.Mixin
end
