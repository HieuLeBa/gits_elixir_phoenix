defmodule GitsElixirPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :gits_elixir_phoenix,
    adapter: Ecto.Adapters.Postgres
end
