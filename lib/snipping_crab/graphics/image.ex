defmodule SnippingCrab.Graphics.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :file, :string
    field :height, :integer
    field :width, :integer
    field :x, :integer
    field :y, :integer

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:file, :x, :y, :width, :height])
    |> validate_required([:file, :x, :y, :width, :height])
  end
end
