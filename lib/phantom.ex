defmodule Phantom do
  @moduledoc """
  Working with phantom types to trigger dialyzer errors when heterogenous types
  that are meant to be used as homogenous are misused.
  """

  @type t :: %__MODULE__{a: any, b: any}
  defstruct [:a, :b]

  @opaque phantom_t(_t0) :: t

  @spec mk_float(t) :: phantom_t(float)
  def mk_float(x), do: x

  @spec mk_int(t) :: phantom_t(integer)
  def mk_int(x), do: x

end
