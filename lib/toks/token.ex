defmodule Toks.Token do
  @valid_roles ~w(publisher subscriber moderator)a
  @nonce_size 16
  def generate(session_id, role, opts \\ []) do
    session_id
    |> build_data(role, Keyword.take(opts, ~w(connection_data initial_layout_class_list)a))
    |> sign_and_build_token()
  end

  defp build_data(session_id, role, opts) when role in @valid_roles do
    data =
      [
        session_id: session_id,
        create_time: :os.system_time(:seconds),
        expire_time: :os.system_time(:seconds) + 3600,
        role: role,
        nonce: nonce()
      ] ++ opts

    URI.encode_query(data)
  end

  defp sign_and_build_token(data) do
    :sha
    |> :crypto.hmac(secret(), data)
    |> Base.encode16()
    |> encode_token(data)
    |> prefix_token()
  end

  defp encode_token(signed, data), do: Base.encode64("partner_id=#{key()}&sig=#{signed}:#{data}")

  defp prefix_token(data), do: "T1==#{data}"

  defp nonce do
    @nonce_size
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> String.downcase()
  end

  defp key do
    Application.fetch_env!(:toks, :key)
  end

  defp secret do
    Application.fetch_env!(:toks, :secret)
  end
end
