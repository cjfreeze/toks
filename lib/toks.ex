defmodule Toks do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.opentok.com/")
  plug(Toks.AuthHeader)
  plug(Tesla.Middleware.Headers, [{"Accept", "application/json"}])
  plug(Tesla.Middleware.FormUrlencoded)
  plug(Tesla.Middleware.DecodeJson)

  def create_session do
    post("/session/create", %{})
  end
end
