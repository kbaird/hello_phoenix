defmodule HelloPhoenix.ZoidbergController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Zoidberg

  plug :scrub_params, "zoidberg" when action in [:create, :update]

  def index(conn, _params) do
    zoidbergs = Repo.all(Zoidberg)
    render(conn, "index.json", zoidbergs: zoidbergs)
  end

  def create(conn, %{"zoidberg" => zoidberg_params}) do
    changeset = Zoidberg.changeset(%Zoidberg{}, zoidberg_params)

    case Repo.insert(changeset) do
      {:ok, zoidberg} ->
        conn
        |> put_status(:created)
        |> render("show.json", zoidberg: zoidberg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    zoidberg = Repo.get!(Zoidberg, id)
    render conn, "show.json", zoidberg: zoidberg
  end

  def update(conn, %{"id" => id, "zoidberg" => zoidberg_params}) do
    zoidberg = Repo.get!(Zoidberg, id)
    changeset = Zoidberg.changeset(zoidberg, zoidberg_params)

    case Repo.update(changeset) do
      {:ok, zoidberg} ->
        render(conn, "show.json", zoidberg: zoidberg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    zoidberg = Repo.get!(Zoidberg, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    _zoidberg = Repo.delete!(zoidberg)

    send_resp(conn, :no_content, "")
  end
end
