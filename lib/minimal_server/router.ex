defmodule MinimalServer.Router do
  @moduledoc """
    Handles requests from the web browser to the response rendering
  """
  use Plug.Router

  plug(:match)
 plug(:disptach)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message()))
  end

  defp message do
    %{
      response_type: "in_channel",
      text: "Hello from the Bazinga Bot :)"
    }
  end
end
