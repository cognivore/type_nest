defmodule Lambda do
  @moduledoc """
  An PoC of typing lambdas.
  """

  alias Etypes.Types, as: T

  @spec higher_order(T.lambda(non_neg_integer, integer), non_neg_integer)
       :: integer
  # @spec higher_order((non_neg_integer -> integer), non_neg_integer)
  #       :: integer
  def higher_order(f, x), do: f.(x)

  @spec main() :: integer 
  def main() do
    higher_order(fn (x) -> -x end, 5)
  end

end
