defmodule MinimalServer.Endpoint do
  use Plug.Router

  plug(:match)

  # As we want our API to be JSON-compliant, we are implementing Plug.Parsers here.
  # We will use it for parsing the request body because it
  # handles application/json requests with the given :json_decoder.
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  # a temporary “catch-all route” which matches all requests
  # and respond with HTTP not found (404) status code.
#  match _ do
#    send_resp(conn, 404, "Giving you the finger muhahaha!!")
#  end

  forward("/bot", to: MinimalServer.Router)

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts),
    do: Plug.Cowboy.http(__MODULE__, [])
end
