defmodule GithubstarsWeb.Explode do
  @moduledoc """
  Utility for responding with standard HTTP/JSON error payloads
  """

  alias Plug.Conn

  @spec reply(Conn.t(), atom, list) :: Conn.t()
  def reply(conn, type, errors) do
    status =
      type
      |> get_status_code()

    payload =
      type
      |> get_message()
      |> build_payload(type, errors)

    conn
    |> do_reply(status, payload)
  end

  def not_found(conn) do
    payload = %{
      "message" => "Not Found",
      "code" => get_error_code(:not_found)
    }

    conn
    |> do_reply(get_status_code(:not_found), payload)
  end

  @spec do_reply(Conn.t(), integer, map) :: Conn.t()
  defp do_reply(conn, status_code, payload) do
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(status_code, Jason.encode!(payload))
    |> Conn.halt()
  end

  @spec build_payload(String.t(), atom, list) :: map
  defp build_payload(message, type, errors) do
    %{
      "code" => get_error_code(type),
      "message" => message,
      "errors" => build_errors(errors, type)
    }
  end

  defp build_errors(errors, :validation) do
    errors
    |> Enum.map(&build_validation_error/1)
  end

  defp build_errors(errors, :not_found) do
    errors
    |> Enum.map(&build_not_found_error/1)
  end

  defp build_validation_error(error) do
    %{
      "message" => error["message"],
      "code" => get_error_code(error["type"]),
      "field" => Map.get(error, "field")
    }
  end

  defp build_not_found_error(error) do
    %{
      "message" => error["message"],
      "code" => get_error_code(Map.get(error, "type", :not_found))
    }
  end

  defp get_message(:validation), do: "Validation failed!"
  defp get_message(:not_found), do: "Not found!"

  defp get_status_code(:validation), do: 422
  defp get_status_code(:not_found), do: 404

  defp get_error_code(:validation), do: 100
  defp get_error_code(:required), do: 101
  defp get_error_code(:cast), do: 102
  defp get_error_code(:not_found), do: 200
end
