defmodule SnippingCrabWeb.ImageController do
  use SnippingCrabWeb, :controller

  alias SnippingCrab.Graphics.Image

  def index(conn, _params) do
    changeset = Image.changeset(%Image{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    changeset = Image.changeset(%Image{}, image_params)
    render(conn, "new.html", changeset: changeset)
  end
end
