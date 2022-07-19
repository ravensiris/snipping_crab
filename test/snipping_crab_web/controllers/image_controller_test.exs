defmodule SnippingCrabWeb.ImageControllerTest do
  use SnippingCrabWeb.ConnCase

  import SnippingCrab.GraphicsFixtures

  @create_attrs %{file: "some file", height: 42, width: 42, x: 42, y: 42}
  @update_attrs %{file: "some updated file", height: 43, width: 43, x: 43, y: 43}
  @invalid_attrs %{file: nil, height: nil, width: nil, x: nil, y: nil}

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get(conn, Routes.image_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Images"
    end
  end

  describe "new image" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.image_path(conn, :new))
      assert html_response(conn, 200) =~ "New Image"
    end
  end

  describe "create image" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.image_path(conn, :show, id)

      conn = get(conn, Routes.image_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Image"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Image"
    end
  end

  describe "edit image" do
    setup [:create_image]

    test "renders form for editing chosen image", %{conn: conn, image: image} do
      conn = get(conn, Routes.image_path(conn, :edit, image))
      assert html_response(conn, 200) =~ "Edit Image"
    end
  end

  describe "update image" do
    setup [:create_image]

    test "redirects when data is valid", %{conn: conn, image: image} do
      conn = put(conn, Routes.image_path(conn, :update, image), image: @update_attrs)
      assert redirected_to(conn) == Routes.image_path(conn, :show, image)

      conn = get(conn, Routes.image_path(conn, :show, image))
      assert html_response(conn, 200) =~ "some updated file"
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put(conn, Routes.image_path(conn, :update, image), image: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Image"
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, Routes.image_path(conn, :delete, image))
      assert redirected_to(conn) == Routes.image_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.image_path(conn, :show, image))
      end
    end
  end

  defp create_image(_) do
    image = image_fixture()
    %{image: image}
  end
end
