use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deps_issue, DepsIssue.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :deps_issue, DepsIssue.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "deps_issue_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

  config :authable, Authable.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "deps_issue_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox