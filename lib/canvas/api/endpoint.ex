defmodule CanvasApp.API.Endpoint do
  use Plug.Router

  plug :put_default_headers
  plug :match
  plug :dispatch

  alias CanvasApp.API.ApiContext, as: Service

  # list of already rendered canvases
  get "/drawings" do
    payload = Service.list_drawings()

    send_resp(conn, 200, Jason.encode!(payload))
  end

  match _ do
    send_resp(conn, 404, "page not found")
  end

  defp put_default_headers(conn, _) do
    conn
    |> put_resp_content_type("application/json")
    |> put_resp_header("access-control-allow-origin", "*")
  end
end
