defmodule Demonstration.Repo do
  use Ecto.Repo,
    otp_app: :demonstration,
    adapter: Ecto.Adapters.Postgres
end
