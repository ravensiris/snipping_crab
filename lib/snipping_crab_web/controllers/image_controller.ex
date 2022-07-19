defmodule SnippingCrabWeb.ImageController do
  use SnippingCrabWeb, :controller

  alias SnippingCrab.Graphics
  alias SnippingCrab.Graphics.Image

  def index(conn, _params) do
    images = Graphics.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Graphics.change_image(%Image{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    case Graphics.create_image(image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: Routes.image_path(conn, :show, image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Graphics.get_image!(id)
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}) do
    image = Graphics.get_image!(id)
    changeset = Graphics.change_image(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Graphics.get_image!(id)

    case Graphics.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: Routes.image_path(conn, :show, image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Graphics.get_image!(id)
    {:ok, _image} = Graphics.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: Routes.image_path(conn, :index))
  end
end
