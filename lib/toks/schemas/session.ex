defmodule Toks.Schemas.Session do
  @struct_fields [
    :create_dt,
    :ice_credential_expiration,
    :ice_server,
    :ice_servers,
    :media_server_hostname,
    :messaging_server_url,
    :messaging_url,
    :partner_id,
    :project_id,
    :properties,
    :session_id,
    :session_segment_id,
    :session_status,
    :status_invalid,
    :symphony_address
  ]
  @fields Enum.map(@struct_fields, &to_string/1)
  defstruct @struct_fields

  def cast([map]) when is_map(map), do: cast(map)

  def cast(map) when is_map(map) and not is_struct(map) do
    fields =
      map
      |> Map.take(@fields)
      |> Stream.map(fn {k, v} ->
        {String.to_existing_atom(k), v}
      end)

    struct(__MODULE__, fields)
  end
end
