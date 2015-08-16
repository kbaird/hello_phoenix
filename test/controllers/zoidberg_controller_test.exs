defmodule HelloPhoenix.ZoidbergControllerTest do
  use HelloPhoenix.ConnCase

  alias HelloPhoenix.Zoidberg
  @valid_attrs %{age: 42, name: "Dr. John Zoidberg", profession: "A Doctor, maybe?"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, zoidberg_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    zoidberg = Repo.insert! %Zoidberg{}
    conn = get conn, zoidberg_path(conn, :show, zoidberg)
    assert json_response(conn, 200)["data"] == %{
      "id" => zoidberg.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, zoidberg_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, zoidberg_path(conn, :create), zoidberg: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Zoidberg, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, zoidberg_path(conn, :create), zoidberg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    zoidberg = Repo.insert! %Zoidberg{}
    conn = put conn, zoidberg_path(conn, :update, zoidberg), zoidberg: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Zoidberg, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    zoidberg = Repo.insert! %Zoidberg{}
    conn = put conn, zoidberg_path(conn, :update, zoidberg), zoidberg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    zoidberg = Repo.insert! %Zoidberg{}
    conn = delete conn, zoidberg_path(conn, :delete, zoidberg)
    assert response(conn, 204)
    refute Repo.get(Zoidberg, zoidberg.id)
  end
end
