defmodule Toks.AuthHeader do
  @behaviour Tesla.Middleware

  @impl Tesla.Middleware
  def call(env, next, _options) do
    env
    |> Tesla.put_header("X-OPENTOK-AUTH", Toks.JWT.gen())
    |> Tesla.run(next)
  end
end
