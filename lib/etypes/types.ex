defmodule Etypes.Types do
  @moduledoc """
  Implementation of some convenience types for Elixir.
  """

  @type maybe(t0) :: {:just, t0} | :nothing
  @type comaybe(t0) :: t0 | {:error, String.t()}

  @type lambda(t0, t1) :: (t0 -> t1)

end
