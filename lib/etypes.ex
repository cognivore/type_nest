defmodule Etypes do
  @moduledoc """
  Demo for Etypes project.
  For `test.sh` to work, make sure to label your bugs with comment `# bug`.
  """

  alias Etypes.Types, as: T

  @spec brokenByDesign(t) :: T.comaybe(t) when t: any()
  def brokenByDesign(_x), do: "Dialyzer doesn't do type inference!"

  # bug
  @spec brokenMaybe(t) :: T.comaybe(t) when t: non_neg_integer()
  def brokenMaybe(_x), do: "If we are specific about type t, then dialyzer will find the error."

  @spec brokenArgument(t) :: T.comaybe(t) when t: non_neg_integer()
  def brokenArgument(x), do: x

  @spec green(t) :: T.comaybe(t) when t: non_neg_integer()
  def green(x) do
    case x do
      42 -> {:error, "Does not compute"}
      _  -> x
    end
  end

  # bug
  # mk_int/1 phantoms `integer`, but we have annotated `main` to phantom `float`
  @spec phantomBug() :: Phantom.phantom_t(float)
  def phantomBug() do
    Phantom.mk_int(%Phantom{a: 4, b: 2})
  end

  @spec notInteger(boolean()) :: boolean()
  def notInteger(x), do: not x

  ### DEMO THAT DIALYZER DOESN'T DO TYPE INFERENCE ###

  # Dialyzer fails to catch this error
  # Higher order expects function on integers, but we pass a function on bools
  def lambdaTcBug() do
    Lambda.higher_order(&notInteger/1, 42)
  end

  @spec notInteger1() :: (boolean() -> boolean())
  def notInteger1() do
    &notInteger/1
  end

  # This isn't caught too!
  def lambdaTcBug1() do
    Lambda.higher_order(notInteger1(), 42)
  end

  # bug
  @spec lambdaTcBug2(T.lambda(non_neg_integer, integer)) :: boolean()
  def lambdaTcBug2(f), do: Lambda.higher_order(f, 42)

  ### END OF DEMO THAT DIALYZER DOESN'T DO TYPE INFERENCE ###

  # bug 
  @spec hello() :: T.comaybe(t) when t: non_neg_integer()
  def hello() do
    brokenByDesign(1)
    brokenMaybe(2)
    # bug
    brokenArgument(-3)
    # This function asks for non_neg_integer
    green(4)
    green(42)
    lambdaTcBug()
    lambdaTcBug1()
    lambdaTcBug2(notInteger1())
  end
  # ^._ this happens because hello/0 calls a function with a bug, which results
  #     in confusing "No return value" error?

  ### Note on `with` statement ### 
  # https://github.com/elixir-lang/elixir/issues/6738
  # But R25 breaks opaque types: https://github.com/erlang/otp/issues/6935

end
