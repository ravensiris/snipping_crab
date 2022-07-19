defmodule SnippingCrab.Repo do
  use Ecto.Repo,
    otp_app: :snipping_crab,
    adapter: Ecto.Adapters.Postgres
end
