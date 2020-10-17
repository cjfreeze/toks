defmodule Toks do
  use Tesla

  alias Toks.Schemas.{
    Session,
    Identity
  }

  plug(Tesla.Middleware.BaseUrl, "https://api.opentok.com/")
  plug(Toks.AuthHeader)
  plug(Tesla.Middleware.Headers, [{"Accept", "application/json"}])
  plug(Tesla.Middleware.FormUrlencoded)
  plug(Tesla.Middleware.DecodeJson)

  def create_session do
    "/session/create"
    |> post(%{})
    |> handle_response(Session)
  end

  defp handle_response(resp, schema \\ Identity) do
    with {:ok, %{body: body}} <- resp do
      {:ok, schema.cast(body)}
    end
  end
end
