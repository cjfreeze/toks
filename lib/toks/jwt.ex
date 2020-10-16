defmodule Toks.JWT do
  use Joken.Config
  @nonce_size 16

  def token_config do
    %{}
    |> add_claim("iss", fn -> key() end, &(&1 == key()))
    |> add_claim("ist", fn -> "project" end, &(&1 == "project"))
    |> add_claim("iat", fn -> :os.system_time(:second) end, &is_integer/1)
    |> add_claim("exp", fn -> :os.system_time(:second) + 180 end, &is_integer/1)
    |> add_claim("jti", fn -> nonce() end, &(is_binary(&1) and byte_size(&1) >= @nonce_size))
  end

  defp key do
    Application.fetch_env!(:toks, :key) |> IO.inspect()
  end

  defp nonce do
    @nonce_size
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
  end

  def gen do
    with {:ok, signed, _} <- generate_and_sign(%{}, signer()) do
      signed
    end
  end

  defp signer do
    Joken.Signer.create("HS256", Application.fetch_env!(:toks, :secret) |> IO.inspect())
  end
end
