# expand  [![Build Status](https://api.travis-ci.org/joeyates/expand.svg)][Continuous Integration]
A pretty printer for Elixir

[Source Code]: https://github.com/joeyates/expand "Source code at GitHub"
[Continuous Integration]: http://travis-ci.org/joeyates/expand "Build status by Travis-CI"

# Add to a project

mix.exs:
```
...
  defp deps do
    [
      {:expand, ">= 0.0.3"}
    ]
  end
...
```

Primitive types are printed one item per line.

For example, here is the abbreviated output for `String.__info__(:functions)`:

```
> IO.puts Expand.it(String.__info__(:functions))
[
  at:
    2,
  capitalize:
    1,
  chunk:
    2,
...
]
```

# Extension

You can create a specialized pretty printer by `use`-ing the
`Expand.Mixin`, see Expand.AbstractCode for an example.
