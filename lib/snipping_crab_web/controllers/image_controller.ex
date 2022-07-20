defmodule SnippingCrabWeb.ImageController do
  use SnippingCrabWeb, :controller

  alias SnippingCrab.Graphics.Image
  alias SnippingCrab.SnippyCrab

  def index(conn, _params) do
    changeset = Image.changeset(%Image{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    changeset = Image.changeset(%Image{}, image_params)

    if changeset.valid? do
      %{file: %{path: path}} = changeset.changes
      %{x: x, y: y, width: width, height: height} = changeset.changes

      image_buffer = File.read!(path)
      {:ok, image} = SnippyCrab.crop_and_grayscale(image_buffer, x, y, width, height)
      image_b64 = Base.encode64(image)

      render(conn, "show.html", image_src: "data:image/png;base64,#{image_b64}")
    else
      render(conn, "new.html", changeset: changeset)
    end
  end
end
