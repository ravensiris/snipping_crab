import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :snipping_crab, SnippingCrab.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "snipping_crab_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :snipping_crab, SnippingCrabWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "WHTnPFoK/QXX8ioON5Soy0Z7rQ2Z9uPZNy9OmK9omWoM80GFOhgjLImuQn+NH6OP",
  server: false

# In test we don't send emails.
config :snipping_crab, SnippingCrab.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
