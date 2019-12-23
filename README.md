# ExMachinaFactoryDelegator

Allows to separate factories into modules.

## Usage

Instead of

```elixir
      defmodule MyApp.Factory do
        use ExMachina

        def foo_factory do
          # ...
        end

        def bar_factory do
          # ...
        end
      end
```

Now you can do the following

```elixir
      defmodule MyApp.Factory do
        use ExMachina

        import ExMachinaFactoryDelegator
        import_factories MyApp.Factories.FooFactory
        import_factories MyApp.Factories.BarFactory
      end

      defmdoule MyApp.Factories.FooFactory do
        def foo_factory do
          # ...
        end
      end

      defmdoule MyApp.Factories.BarFactory do
        def bar_factory do
          # ...
        end
      end
```

## Installation

```elixir
def deps do
  [
    {
      :ex_machina_factory_delegator,
      github: "Elonsoft/ex_machina_factory_delegator",
      branch: "master"
    }
  ]
end
```
