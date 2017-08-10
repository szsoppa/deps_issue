use Mix.Config

config :authable,
  ecto_repos: [DepsIssue.Repo],
  repo: DepsIssue.Repo,
  resource_owner: DepsIssue.User,
  token_store: Authable.Model.Token,
  client: Authable.Model.Client,
  app: Authable.Model.App,
  expires_in: %{
    access_token: 3600,
    refresh_token: 24 * 3600,
    authorization_code: 300,
    session_token: 30 * 24 * 3600
  },
  grant_types: %{
    authorization_code: Authable.GrantType.AuthorizationCode,
    client_credentials: Authable.GrantType.ClientCredentials,
    password: Authable.GrantType.Password,
    refresh_token: Authable.GrantType.RefreshToken
  },
  auth_strategies: %{
    headers: %{
      "authorization" => [
        {~r/Basic ([a-zA-Z\-_\+=]+)/, Authable.Authentication.Basic},
        {~r/Bearer ([a-zA-Z\-_\+=]+)/, Authable.Authentication.Bearer},
      ],
      "x-api-token" => [
        {~r/([a-zA-Z\-_\+=]+)/, Authable.Authentication.Bearer}
      ]
    },
    query_params: %{
      "access_token" => Authable.Authentication.Bearer
    },
    sessions: %{
      "session_token" => Authable.Authentication.Session
    }
  },
  scopes: ~w(read write session),
  renderer: Authable.Renderer.RestApi

config :shield_notifier,
  channels: %{
    email: %{
      from: {
        System.get_env("APP_NAME") || "Shield Notifier",
        System.get_env("APP_FROM_EMAIL") || "no-reply@localhost"}
    }
  }

config :shield_notifier, Shield.Notifier.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

config :shield,
  confirmable: true,
  hooks: Shield.Hook.Default,
  views: %{
    changeset: Shield.ChangesetView,
    error: Shield.ErrorView,
    app: Shield.AppView,
    client: Shield.ClientView,
    token: Shield.TokenView,
    user: Shield.UserView
  },
  cors_origins: "http://localhost:4200, *",
  front_end: %{
    base: "http://localhost:4200",
    confirmation_path: "/users/confirm?confirmation_token={{confirmation_token}}",
    reset_password_path: "/users/reset-password?reset_token={{reset_token}}"
  }
