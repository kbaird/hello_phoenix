defmodule HelloPhoenix.Repo.Migrations.CreateZoidberg do
  use Ecto.Migration

  def change do
    create table(:zoidbergs) do
      add :name, :string
      add :age, :integer
      add :profession, :string

      timestamps
    end

  end
end
