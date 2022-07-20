defmodule SnippingCrab.SnippyCrab do
  use Rustler, otp_app: :snipping_crab, crate: "snippy_crab"

  # When your NIF is loaded, it will override this function.
  @spec crop_and_grayscale(
          binary(),
          non_neg_integer(),
          non_neg_integer(),
          non_neg_integer(),
          non_neg_integer()
        ) :: binary()
  def crop_and_grayscale(image, x, y, width, height), do: :erlang.nif_error(:nif_not_loaded)
end
