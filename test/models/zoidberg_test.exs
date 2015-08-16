defmodule HelloPhoenix.ZoidbergTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.Zoidberg

  @valid_attrs %{age: 42, name: "Dr. John Zoidberg", profession: "A Doctor, maybe?"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Zoidberg.changeset(%Zoidberg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Zoidberg.changeset(%Zoidberg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
