defmodule ExMachinaFactoryDelegator do
  @moduledoc """
  Allows to separate factories into modules.

  ## Usage

  Instead of

      defmodule MyApp.Factory do
        use ExMachina

        def foo_factory do
          # ...
        end

        def bar_factory do
          # ...
        end
      end

  Now you can do the following

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
  """

  defmacro import_factories(module) do
    {:module, module} = Code.ensure_compiled(module_name(module))

    for {factory, arity} <- factories_from(module) do
      factory_delegate(factory, arity, module)
    end
  end

  defp module_name({:__aliases__, _, parts}) when is_list(parts) do
    Module.concat(parts)
  end

  defp module_name(module) when is_atom(module) do
    module
  end

  defp factories_from(module) when is_atom(module) do
    :functions
    |> module.__info__()
    |> Enum.filter(fn {name, _} ->
      name |> to_string |> String.ends_with?("_factory")
    end)
  end

  defp factory_delegate(name, 0, module) do
    quote location: :keep do
      defdelegate unquote(name)(), to: unquote(module)
    end
  end

  defp factory_delegate(name, 1, module) do
    quote location: :keep do
      defdelegate unquote(name)(attrs), to: unquote(module)
    end
  end
end
