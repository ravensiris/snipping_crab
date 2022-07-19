defmodule SnippingCrab.SnippyCrab do
  use Rustler, otp_app: :snipping_crab, crate: "snippy_crab"

  # When your NIF is loaded, it will override this function.
  @spec add(integer(), integer()) :: integer()
  def add(a, b), do: :erlang.nif_error(:nif_not_loaded)
end
