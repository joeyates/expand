# expand
A pretty printer for Elixir

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
