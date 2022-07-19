defmodule SnippingCrabWeb.PageController do
  use SnippingCrabWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
