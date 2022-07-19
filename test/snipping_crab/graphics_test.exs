defmodule SnippingCrab.GraphicsTest do
  use SnippingCrab.DataCase

  alias SnippingCrab.Graphics

  describe "images" do
    alias SnippingCrab.Graphics.Image

    import SnippingCrab.GraphicsFixtures

    @invalid_attrs %{file: nil, height: nil, width: nil, x: nil, y: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Graphics.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Graphics.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{file: "some file", height: 42, width: 42, x: 42, y: 42}

      assert {:ok, %Image{} = image} = Graphics.create_image(valid_attrs)
      assert image.file == "some file"
      assert image.height == 42
      assert image.width == 42
      assert image.x == 42
      assert image.y == 42
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Graphics.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{file: "some updated file", height: 43, width: 43, x: 43, y: 43}

      assert {:ok, %Image{} = image} = Graphics.update_image(image, update_attrs)
      assert image.file == "some updated file"
      assert image.height == 43
      assert image.width == 43
      assert image.x == 43
      assert image.y == 43
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Graphics.update_image(image, @invalid_attrs)
      assert image == Graphics.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Graphics.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Graphics.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Graphics.change_image(image)
    end
  end
end
