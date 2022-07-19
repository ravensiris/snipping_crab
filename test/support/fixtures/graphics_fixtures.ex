defmodule SnippingCrab.GraphicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SnippingCrab.Graphics` context.
  """

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        file: "some file",
        height: 42,
        width: 42,
        x: 42,
        y: 42
      })
      |> SnippingCrab.Graphics.create_image()

    image
  end
end
